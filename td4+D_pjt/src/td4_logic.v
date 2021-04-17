module td4_logic(
           input CLOCK,
           input RESET,
           input [3:0] IN,
           output reg [3:0] OUT,
           input  reg [2:0] regsel,
           output reg [3:0] regdat
           );

   reg [3:0] A, B; // Registers
   reg [3:0] PC; // Program Counter
   wire [7:0] ROM [15:0]; //the Instruction memory
   reg C; // Carry flag

   wire Cnext;
   wire [3:0] OP; // Operation code
   wire [3:0] IM; // Immediate data
   wire [3:0] CHANNEL; // Input channel
   wire [3:0] ALU;
   wire LOAD0, LOAD1, LOAD2, LOAD3;
   wire SELECT_A, SELECT_B;

   assign IM = ROM[PC][3:0];
   assign OP = ROM[PC][7:4];

    // LCD Disp
    assign regdat = regsel == 3'h0 ? PC :
                    regsel == 3'h1 ? A  :
                    regsel == 3'h2 ? B  :
                    regsel == 3'h3 ? {3'b000,C} :
                    regsel == 3'h4 ? OUT :
                    regsel == 3'h5 ? {CLOCK,IN[2:0]}  :
                    4'b0000;

   // Data transfar
   always @(posedge CLOCK) begin
      C   <= RESET ? 0 :  Cnext;
      A   <= RESET ? 0 : ~LOAD0 ? ALU : A;
      B   <= RESET ? 0 : ~LOAD1 ? ALU : B;
      OUT <= RESET ? 0 : ~LOAD2 ? ALU : OUT;
      PC  <= RESET ? 0 : ~LOAD3 ? ALU : PC + 1;
   end
   
   // Opcode decode
   assign SELECT_A = OP[0] | OP[3];
   assign SELECT_B = OP[1]; // OP[0]
   assign LOAD0 =  OP[2] |  OP[3];
   assign LOAD1 = ~OP[2] |  OP[3];
   assign LOAD2 =  OP[2] | ~OP[3];
   assign LOAD3 = ~OP[2] | ~OP[3] | (~OP[0] & C);

   // Data selector
   assign CHANNEL = (~SELECT_B & ~SELECT_A) ? A :
                    (~SELECT_B &  SELECT_A) ? B :
                    ( SELECT_B & ~SELECT_A) ? IN :
                    4'b0000;

   // ALU
   assign {Cnext, ALU} = CHANNEL + IM;
   
   // Assembler macro's
   `define MOV_A(ii) ((8'b00110000)+(ii&4'hf))
   `define MOV_B(ii) ((8'b01110000)+(ii&4'hf))
   `define MOV_A_B    (8'b00010000)
   `define MOV_B_A    (8'b01000000)
   `define ADD_A(ii) ((8'b00000000)+(ii&4'hf))
   `define ADD_B(ii) ((8'b01010000)+(ii&4'hf))
   `define IN_A       (8'b00100000)
   `define IN_B       (8'b01100000)
   `define OUT_(ii)  ((8'b10110000)+(ii&4'hf))
   `define OUT_B      (8'b10010000)
   `define JMP_(ii)  ((8'b11110000)+(ii&4'hf))
   `define JNC_(ii)  ((8'b11100000)+(ii&4'hf))

 // Ramen timer

assign ROM[0] =  `OUT_(4'b0111);  //   # LED
assign ROM[1] =  `ADD_A(4'b0001);
assign ROM[2] =  `JNC_(4'b0001);  //   # loop 16 times
assign ROM[3] =  `ADD_A(4'b0001);
assign ROM[4] =  `JNC_(4'b0011);  //   # loop 16 times
assign ROM[5] =  `OUT_(4'b0110);  //   # LED
assign ROM[6] =  `ADD_A(4'b0001);
assign ROM[7] =  `JNC_(4'b0110);  //   # loop 16 times
assign ROM[8] =  `ADD_A(4'b0001);
assign ROM[9] =  `JNC_(4'b1000);  //   # loop 16 times
assign ROM[10] = `OUT_(4'b0000);  //   # LED
assign ROM[11] = `OUT_(4'b0100);  //   # LED
assign ROM[12] = `ADD_A(4'b0001);
assign ROM[13] = `JNC_(4'b1010);  //   # loop 16 times
assign ROM[14] = `OUT_(4'b1000);  //   # LED
assign ROM[15] = `JMP_(4'b1111);  //   stop

endmodule