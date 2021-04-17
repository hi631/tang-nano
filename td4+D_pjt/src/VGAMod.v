module VGAMod (
    input                   CLK, nRST,
    input                   PixelClk,
    output                  LCD_DE, LCD_HSYNC, LCD_VSYNC,
	output          [4:0]   LCD_B,
	output          [5:0]   LCD_G,
	output          [4:0]   LCD_R,
    output          [2:0]   regsel,
    input           [3:0]   regdat
);

    reg         [15:0]  Pcnt;
    reg         [15:0]  Lcnt;

	//pluse include in back pluse; t=pluse, sync act; t=bp, data act; t=bp+height, data end
	localparam      V_BackPorch = 16'd0; //6
	localparam      V_Pluse 	= 16'd5; 
	localparam      HightPixel  = 16'd480;
	localparam      V_FrontPorch= 16'd45; //62

	localparam      H_BackPorch = 16'd182;
	localparam      H_Pluse 	= 16'd1; 
	localparam      WidthPixel  = 16'd800;
	localparam      H_FrontPorch= 16'd210;

    localparam      PixelForHS  =   WidthPixel + H_BackPorch + H_FrontPorch;  	
    localparam      LineForVS   =   HightPixel + V_BackPorch + V_FrontPorch;

    always @(  posedge PixelClk or negedge nRST  )begin
        if( !nRST ) begin
            Lcnt <= 16'b0; Pcnt <= 16'b0;
        end else if(  Pcnt  ==  PixelForHS ) begin
            Pcnt <= 16'b0; Lcnt <= Lcnt + 1'b1;
        end else if(  Lcnt  == LineForVS  ) begin
            Lcnt <= 16'b0; Pcnt <= 16'b0;
         end else
            Pcnt <= Pcnt + 1'b1;
    end

	reg			[9:0]  Data_R;
	reg			[9:0]  Data_G;
	reg			[9:0]  Data_B;

    always @(  posedge PixelClk or negedge nRST  )begin
        if( !nRST ) begin
			Data_R <= 9'b0;	Data_G <= 9'b0;	Data_B <= 9'b0;
        end
	end

	// Note the negative polarity of HSYNC and VSYNC here
    assign  LCD_HSYNC = (( Pcnt >= H_Pluse)&&( Pcnt <= (PixelForHS-H_FrontPorch))) ? 1'b0 : 1'b1;
	assign  LCD_VSYNC = ((( Lcnt  >= V_Pluse )&&( Lcnt  <= (LineForVS-0) )) ) ? 1'b0 : 1'b1;
    //assign  FIFO_RST  = (( Pcnt ==0)) ? 1'b1 : 1'b0;  //Remaining time for host H_BackPorch to interrupt and send data

    assign  LCD_DE = (  ( Pcnt >= H_BackPorch )&&
                        ( Pcnt <= PixelForHS-H_FrontPorch ) &&
                        ( Lcnt >= V_BackPorch ) &&
                        ( Lcnt <= LineForVS-V_FrontPorch-1 ))  ? 1'b1 : 1'b0;

    wire [3:0][3:0] ddt;
    assign ddt[0] = 4'b1000;
    assign ddt[1] = 4'b0100;
    assign ddt[2] = 4'b0010;
    assign ddt[3] = 4'b1111;
    wire    Pdat;
    assign LCD_R = Pdat && regdat[Xpos] ? 5'b11111  : 5'b00000;
    assign LCD_G = Pdat && regdat[Xpos] ? 6'b111111 : 5'b000000;
    assign LCD_B = Pdat                 ? 5'b11111  : 5'b00000;

    assign regsel = Ypos[2:0];
    wire [15:0] Xtop,Ytop;
    wire [3:0]  Xpos, Ypos;
    assign Xtop = Pcnt - (H_BackPorch + 128);
    assign Ytop = Lcnt - 8;
    assign Xpos = 3 - Xtop[9:5];
    assign Ypos = Ytop[9:5];
    assign Pdat = (Xtop[4:2] != 0) && (Ytop[4:3] != 0) && (Xpos < 4) && (Ypos<8);

/*
    assign  LCD_R   =   (Pcnt<200)? 5'b00000 : 
                        (Pcnt<240 ? 5'b00001 :    
                        (Pcnt<280 ? 5'b00010 :    
                        (Pcnt<320 ? 5'b00100 :    
                        (Pcnt<360 ? 5'b01000 :    
                        (Pcnt<400 ? 5'b10000 :  5'b00000 )))));

    assign  LCD_G   =   (Pcnt<400)? 6'b000000 : 
                        (Pcnt<440 ? 6'b000001 :    
                        (Pcnt<480 ? 6'b000010 :    
                        (Pcnt<520 ? 6'b000100 :    
                        (Pcnt<560 ? 6'b001000 :    
                        (Pcnt<600 ? 6'b010000 :  
                        (Pcnt<640 ? 6'b100000 : 6'b000000 ))))));

    assign  LCD_B   =   (Pcnt<640)? 5'b00000 : 
                        (Pcnt<680 ? 5'b00001 :    
                        (Pcnt<720 ? 5'b00010 :    
                        (Pcnt<760 ? 5'b00100 :    
                        (Pcnt<800 ? 5'b01000 :    
                        (Pcnt<840 ? 5'b10000 :  5'b00000 )))));
*/
endmodule
