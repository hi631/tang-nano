module VGAMod (
    input                   CLK, nRST,
    input                   PixelClk,
    output                  LCD_DE, LCD_HSYNC, LCD_VSYNC,
	output          [4:0]   LCD_B,
	output          [5:0]   LCD_G,
	output          [4:0]   LCD_R,
    output          [2:0]   regsel,
    input           [7:0]   regdat
);

    reg         [15:0]  Pcnt, Lcnt;

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

	reg			[9:0]  Data_R, Data_G, Data_B;
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

    wire    Pdat;
    assign LCD_R = Pdat && regdat[Xpos] ? 5'b11111  : 5'b00000;
    assign LCD_G = Pdat && regdat[Xpos] ? 6'b111111 : 5'b000000;
    assign LCD_B = Pdat                 ? 5'b11111  : 5'b00000;

    assign regsel = Ypos[2:0];
    wire [15:0] Xtop,Ytop;
    wire [4:0]  Xpos, Ypos;
    assign Xtop = Pcnt - (H_BackPorch + 16'd128);
    assign Ytop = Lcnt - 16'd8;
    assign Xpos = 4'b0111 - Xtop[9:5];
    assign Ypos = Ytop[9:5];
    assign Pdat = (Xtop[4:2] != 0) && (Ytop[4:3] != 0) && (Xpos < 8) && (Ypos<8);

endmodule
