module TOP
(
	input			nRST,XTAL_IN,KEY,

	output			LCD_CLK,LCD_HYNC,LCD_SYNC,LCD_DEN,
	output	[4:0]	LCD_R,
	output	[5:0]	LCD_G,
	output	[4:0]	LCD_B,

    output          LED_R,LED_G,LED_B
);

	wire		CLK_SYS,CLK_PIX;
    Gowin_PLL chip_pll(
        .clkout(CLK_SYS),   //output clkout     // 200M
        .clkoutd(CLK_PIX),  //output clkoutd    // 10M <- 33.33M
        .clkin(XTAL_IN)     //input clkin
    );	

    // LCD
	assign		LCD_CLK	= CLK_PIX;
    wire [2:0] regsel;
    wire [3:0] regdat;
	VGAMod	D1 (
		.CLK(CLK_SYS), .nRST(nRST),
		.PixelClk(CLK_PIX), .LCD_DE(LCD_DEN), .LCD_HSYNC(LCD_HYNC), .LCD_VSYNC(LCD_SYNC),
		.LCD_B(LCD_B), .LCD_G(LCD_G),.LCD_R(LCD_R), 
        .regsel(regsel), .regdat(regdat) );

    // TD4
	reg [27:0] count;
    always @ (posedge XTAL_IN)
        if(~KEY) count <= 0;
        else     count <= count+1;
	 
	wire [3:0] OUT,IN;
    assign {LED_B,LED_G,LED_R} = ~OUT;
    assign IN = {3'b000,~KEY};
	td4_logic td4_logic( .CLOCK(~count[22]), .RESET(~nRST), .IN(IN), .OUT(OUT),
                         .regsel(regsel), .regdat(regdat));

endmodule

