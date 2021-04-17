module led (
    input sys_clk,
    input sys_rst_n,
    output txs,
    input  rxs,
    output reg [2:0] led // 110 B, 101 R, 011 G
);

reg        txen;
wire       rxen;
reg  [7:0] sdt;
   //assign txs = 1'b0;
   rs232c_tx_rx uart(
	.RESETB(sys_rst_n), 
	.CLK(sys_clk),
	.TXD(txs),
	.RXD(rxs),
	.TX_DATA(sdt),
	.TX_DATA_EN(txen),
	.TX_BUSY(txbusy),
	.RX_DATA(sdt),
	.RX_DATA_EN(rxen),
	.RX_BUSY());

always @(posedge sys_clk) begin
    if(rxen) txen <= 1'b1;
    else     txen <= 1'b0;
end

reg [23:0] counter;
always @(posedge sys_clk or negedge sys_rst_n) begin
    if (!sys_rst_n) begin
        counter <= 24'd0; led <= 3'b110;
    end else if (counter == 24'd0600_0000) begin       // 24'd1200_0000 = 0.5s delay (24MHz)
        counter <= 24'd0; led[2:0] <= {led[1:0],led[2]};
    end else begin 
        counter <= counter + 24'd1; led <= led;
    end
end

endmodule
