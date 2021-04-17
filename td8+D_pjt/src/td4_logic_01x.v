module td4_logic(
           input CLOCK,
           input RESET,
           input [3:0] IN,
           output reg [3:0] OUT,
           input  reg [2:0] regsel,
           output reg [7:0] regdat
           );

   reg [7:0] A, B; // Registers
   reg [7:0] PC; // Program Counter
   wire [11:0] ROM [31:0]; //the Instruction memory
   reg C; // Carry flag

   wire Cnext;
   wire [3:0] OP; // Operation code
   wire [7:0] IM; // Immediate data
   wire [7:0] CHANNEL; // Input channel
   wire [7:0] ALU;
   wire LOAD0, LOAD1, LOAD2, LOAD3, LOAD4;
   wire SELECT_A, SELECT_B;

   assign IM = ROM[PC][7:0];
   assign OP = ROM[PC][11:8];

    // LCD Disp Selecter
    assign regdat = regsel == 3'h0 ? PC :
                    regsel == 3'h1 ? A  :
                    regsel == 3'h2 ? B  :
                    regsel == 3'h3 ? {7'b0000000,C} :
                    regsel == 3'h4 ? OUT :
                    regsel == 3'h5 ? {CLOCK,4'b0000,IN[2:0]}  :
                    8'b00000000;

   // Data transfar
   always @(posedge CLOCK) begin
      C   <= RESET ? 0 :  Cnext;
      A   <= RESET ? 0 : ~LOAD0 ? ALU : A;
      B   <= RESET ? 0 : ~LOAD1 ? ALU : B;
      OUT <= RESET ? 0 : ~LOAD2 ? ALU : OUT;
      PC  <= RESET ? 0 : ~LOAD3 ? ALU : ~LOAD4 ? S : PC + 1;
   end
   
   // Opcode decode
   assign LOAD0 =  OP[2] |  OP[3];                  // OP[3;2] = 00 A.sel 
   assign LOAD1 = ~OP[2] |  OP[3];                  //         = 01 B.sel
   assign LOAD2 =  OP[2] | ~OP[3];                  //         = 10 OUT
   assign LOAD3 = ~OP[2] | ~OP[3] | ~OP[1] | (~OP[0] & C);   // = 111x JMP/JNC
   assign LOAD4 = ~OP[2] | ~OP[3] |  OP[1] |  ~OP[0]);       // = 1101 RET

   // Data selector
   assign SELECT_A = OP[0] | OP[3];
   assign SELECT_B = OP[1];                         // OP[0] miss
   assign CHANNEL = (~SELECT_B & ~SELECT_A) ? A :   // OP[3-10] = 0x00=ADD(R)
                    (~SELECT_B &  SELECT_A) ? B :   //          = 0x01=M0V(R), 1x00=xx, 1x01=OUT 
                    ( SELECT_B & ~SELECT_A) ? IN :  //          = 0x10=IN (R)
                    4'b0000;                        //          = 0x11=,1x10,1x11=(ii) // CHANNEL=0

   // ALU
   assign {Cnext, ALU} = CHANNEL + IM;
   
   // Assembler macro's
   `define ADD_A(ii) ((12'b000000000000)+(ii&8'hff))    // 0000
   `define MOV_A_B    (12'b000100000000)                // 0001
   `define IN_A       (12'b001000000000)                // 0010
   `define MOV_A(ii) ((12'b001100000000)+(ii&8'hff))    // 0011
   `define MOV_B_A    (12'b010000000000)                // 0100
   `define ADD_B(ii) ((12'b010100000000)+(ii&8'hff))    // 0101 
   `define IN_B       (12'b011000000000)                // 0110
   `define MOV_B(ii) ((12'b011100000000)+(ii&8'hff))    // 0111
                                                        // 1000
   `define OUT_B      (12'b100100000000)                // 1001
                                                        // 1010
   `define OUT_(ii)  ((12'b101100000000)+(ii&8'hff))    // 1011
                                                        // 1100
                                                        // 1101
   `define JNC_(ii)  ((12'b111000000000)+(ii&8'hff))    // 1110
   `define JMP_(ii)  ((12'b111100000000)+(ii&8'hff))    // 1111

 // Ramen timer

assign ROM[0] =   `OUT_(8'b00000111);  //   # LED
assign ROM[1] =  `MOV_A(8'b11110000);
assign ROM[2] =  `ADD_A(8'b00000001);
assign ROM[3] =   `JNC_(8'b00000010);  //   # loop 16 times
assign ROM[4] =  `MOV_A(8'b11110000);
assign ROM[5] =  `ADD_A(8'b00000001);
assign ROM[6] =   `JNC_(8'b00000101);  //   # loop 16 times
assign ROM[7] =   `OUT_(8'b00000110);  //   # LED
assign ROM[8] =  `MOV_A(8'b11110000);
assign ROM[9] =  `ADD_A(8'b00000001);
assign ROM[10] =  `JNC_(8'b00001001);  //   # loop 16 times
assign ROM[11] = `MOV_A(8'b11110000);
assign ROM[12] = `ADD_A(8'b00000001);
assign ROM[13] =  `JNC_(8'b00001100);  //   # loop 16 times
assign ROM[14] = `MOV_A(8'b11110000);
assign ROM[15] =  `OUT_(8'b00000000);  //   # LED
assign ROM[16] =  `OUT_(8'b00000100);  //   # LED
assign ROM[17] = `ADD_A(8'b00000001);
assign ROM[18] =  `JNC_(8'b00001111);  //   # loop 16 times
assign ROM[19] =  `OUT_(8'b00001000);  //   # LED
assign ROM[20] =  `JMP_(8'b00010100);  //   stop

endmodule