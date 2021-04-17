module td4_logic(
           input CLOCK,
           input RESET,
           input [3:0] IN,
           output reg [3:0] OUT,
           input  reg [2:0] regsel,
           output reg [7:0] regdat
           );

   reg [7:0] A, B, S; // Registers
   reg [7:0] PC; // Program Counter
   wire [11:0] ROM [16:0]; //the Instruction memory
   reg C; // Carry flag

   wire Cnext;
   wire [3:0] OP; // Operation code
   wire [7:0] IM; // Immediate data
   wire [7:0] CHANNEL; // Input channel
   wire [7:0] ALU;
   wire LOAD0, LOAD1, LOAD2, LOAD3, LOAD4, LOAD5;
   wire SELECT_A, SELECT_B;

   assign IM = ROM[PC][7:0];
   assign OP = ROM[PC][11:8];

    // LCD Disp
    assign regdat = regsel == 3'h0 ? PC :
                    regsel == 3'h1 ? A  :
                    regsel == 3'h2 ? B  :
                    regsel == 3'h3 ? S  :
                    regsel == 3'h4 ? {LOAD0,LOAD1,LOAD2,LOAD3,LOAD4,LOAD5,1'b0,C} : // {7'b0000000,C} :
                    regsel == 3'h5 ? OUT :
                    regsel == 3'h6 ? {CLOCK,4'b0000,IN[2:0]}  :
                    8'b00000000;

   // Data transfar
   always @(posedge CLOCK) begin
      C   <= RESET ? 0 :  Cnext;
      A   <= RESET ? 0 : ~LOAD0 ? ALU : A;
      B   <= RESET ? 0 : ~LOAD1 ? ALU : B;
      S   <= RESET ? 0 : ~LOAD5 ? PC + 8'd1 : S;
      OUT <= RESET ? 0 : ~LOAD2 ? ALU[3:0] : OUT;
      PC  <= RESET ? 0 : (~LOAD3 | ~LOAD5) ? ALU : ~LOAD4 ? S : PC + 8'd1;
   end
   
   // Opcode decode
   assign SELECT_A = OP[0] | OP[3];
   assign SELECT_B = OP[1];
   assign LOAD0 =  OP[2] |  OP[3];
   assign LOAD1 = ~OP[2] |  OP[3];
   assign LOAD2 =  OP[2] | ~OP[3];
   assign LOAD3 = ~OP[2] | ~OP[3] | ~OP[1] | (~OP[0] & C);   // = 111x JMP/JNC
   assign LOAD4 = ~OP[2] | ~OP[3] |  OP[1] |   OP[0];        // = 1100 RET
   assign LOAD5 = ~OP[2] | ~OP[3] |  OP[1] |  ~OP[0];        // = 1101 CALL

   // Data selector
   assign CHANNEL = (~SELECT_B & ~SELECT_A) ? A :
                    (~SELECT_B &  SELECT_A) ? B :
                    ( SELECT_B & ~SELECT_A) ? IN :
                    4'b0000;

   // ALU
   assign {Cnext, ALU} = CHANNEL + IM;

 // Ramen timer
assign ROM[8'h00] = 12'hB07;
assign ROM[8'h01] = 12'hD0D;
assign ROM[8'h02] = 12'hD0D;
assign ROM[8'h03] = 12'hB06;
assign ROM[8'h04] = 12'hD0D;
assign ROM[8'h05] = 12'hD0D;
assign ROM[8'h06] = 12'h3FC;
assign ROM[8'h07] = 12'hB00;
assign ROM[8'h08] = 12'hB04;
assign ROM[8'h09] = 12'h001;
assign ROM[8'h0A] = 12'hE07;
assign ROM[8'h0B] = 12'hB00;
assign ROM[8'h0C] = 12'hF0C;
assign ROM[8'h0D] = 12'h3FC;
assign ROM[8'h0E] = 12'h001;
assign ROM[8'h0F] = 12'hE0E;
assign ROM[8'h10] = 12'hC00;
/*
assign ROM[8'h00] = 12'hB07;
assign ROM[8'h01] = 12'h3F0;
assign ROM[8'h02] = 12'h001;
assign ROM[8'h03] = 12'hE02;
assign ROM[8'h04] = 12'h3F0;
assign ROM[8'h05] = 12'h001;
assign ROM[8'h06] = 12'hE05;
assign ROM[8'h07] = 12'hB06;
assign ROM[8'h08] = 12'h3F0;
assign ROM[8'h09] = 12'h001;
assign ROM[8'h0A] = 12'hE09;
assign ROM[8'h0B] = 12'h3F0;
assign ROM[8'h0C] = 12'h001;
assign ROM[8'h0D] = 12'hE0C;
assign ROM[8'h0E] = 12'h3F0;
assign ROM[8'h0F] = 12'hB00;
assign ROM[8'h10] = 12'hB04;
assign ROM[8'h11] = 12'h001;
assign ROM[8'h12] = 12'hE0F;
assign ROM[8'h13] = 12'hB00;
assign ROM[8'h14] = 12'hF14;
*/
endmodule