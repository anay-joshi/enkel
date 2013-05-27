module REST(
 MAR_load,
 PC_load,
 INC_ALU_select,
 IR_PC_select,
 IR_load,
 PC_reset,
 en_inc,
 IR_reset,
 from_A_to_mem,
 from_mem_to_B,
 from_IR_to_B,
 Bc,
 APc,
 Address,
 Data,
 from_PC_to_ALU,
 from_IR_to_decoder,
 programmer,
 A_programmer_select,
 from_ALU,
 latch_PC_load,
 show_out,
 show_load,
 show_reset,
 status,
 ALU_inc_select
 );
output status;
wire [7:0]from_inc;
wire [7:0]to_inc;
wire [7:0]to_PC;
wire [7:0]PC_to_choose;
wire [7:0]to_MAR;
output [7:0]Address;
wire [7:0]from_mem_to_IR;
wire [7:0]from_IR_to_ALU;
wire [7:0]IR_to_choose;
inout [7:0]Data;
wire [7:0]aram;
wire [7:0]bram;
wire [7:0]from_ALU_to_choose;
wire [7:0]from_INC_to_choose;
wire [7:0]programmer_to_choose;
wire [7:0]programmer_to_RAM;

input show_reset;
input show_load;
input latch_PC_load;
input [7:0]from_ALU;
input A_programmer_select;
input [7:0]programmer;

input [7:0]from_A_to_mem;
output [7:0]from_mem_to_B;
output [7:0]from_IR_to_B;
output [7:0]from_PC_to_ALU;
output [7:0]show_out;
input Bc;
input APc;
input INC_ALU_select;

input MAR_load;
input PC_load;
input ALU_inc_select;
input IR_PC_select;
input IR_load;
input PC_reset;
input en_inc;
input IR_reset;

wire [7:0] show_in;
wire [7:0] from_IR;
wire [2:0] ground3;
wire [7:0] into_mem;
output [2:0] from_IR_to_decoder;

assign IR_to_choose[7] = from_IR[4];
assign IR_to_choose[6] = from_IR[3];
assign IR_to_choose[5] = from_IR[2];
assign IR_to_choose[4] = from_IR[1];
assign IR_to_choose[3] = from_IR[0];
assign IR_to_choose[2] = ground3[2];
assign IR_to_choose[1] = ground3[1];
assign IR_to_choose[0] = ground3[0];

assign from_IR_to_decoder[2] = from_IR[7];
assign from_IR_to_decoder[1] = from_IR[6];
assign from_IR_to_decoder[0] = from_IR[5];

assign ground3 = 3'b000;

assign from_IR_to_B[7] = ground3[2];
assign from_IR_to_B[6] = ground3[1];
assign from_IR_to_B[5] = ground3[0];
assign from_IR_to_B[4] = from_IR[4];
assign from_IR_to_B[3] = from_IR[3];
assign from_IR_to_B[2] = from_IR[2];
assign from_IR_to_B[1] = from_IR[1];
assign from_IR_to_B[0] = from_IR[0];

assign status = from_IR[7] | from_IR[6] | from_IR[5] | (~from_IR[0]);

assign from_PC_to_ALU = to_inc;
assign from_mem_to_IR = from_mem_to_B;
assign Data = aram;
assign bram = Data;
assign PC_to_choose = to_inc;

assign show_in = from_mem_to_B;


register2 PC(.load(PC_load),.d(to_PC),.value(to_inc),.reset(PC_reset));

register2 show(.d(show_in),.value(show_out),.load(show_load),.reset(show_reset));

register2 latch_PC(.load(latch_PC_load),.d(from_ALU),.value(from_ALU_to_choose),.reset());

increment INC(.in(to_inc),.out(from_inc),.enable(en_inc));

register2 IR(.load(IR_load),.d(from_mem_to_IR),.value(from_IR),.reset(IR_reset));

choose A_programmer_choose(.in0(programmer),.in1(from_A_to_mem),.out(into_mem),.select(A_programmer_select),.enable(e1));
assign e1 = 1'b1;

choose IR_PC_choose(.in0(PC_to_choose),.in1(IR_to_choose),.select(IR_PC_select),.out(to_MAR),.enable(e2));
assign e2 = 1'b1;

register2 MAR(.load(MAR_load),.d(to_MAR),.value(Address),.reset(MAR_reset));

choose INC_ALU_choose(.in0(from_ALU_to_choose),.in1(from_inc),.select(INC_ALU_select),.out(to_PC),.enable(e3));
assign e3 = 1'b1;

tri_state_buffer Amem(.c(APc),.in(into_mem),.out(aram));

tri_state_buffer Bmem(.c(Bc),.in(bram),.out(from_mem_to_B));

endmodule
