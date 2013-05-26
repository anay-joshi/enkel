module ALU(
from_mem,
from_IR,
from_PC,
Aload,
Bload,
A_PC_select,
MEM_IR_select,
carry,
compliment_or_adder,
Areset,
Breset,
from_ALU,
adder_compliment_enable,
A_PC_enable,
mem_IR_enable,
from_A_to_mem,
latch_A_load,
from_B_to_adder
);

input adder_compliment_enable;
input A_PC_enable;
input mem_IR_enable;
input Areset;
input Breset;
input [7:0]from_mem;
input [7:0]from_IR;
input [7:0]from_PC;
output [7:0] from_ALU;
input Aload;
input Bload;
input A_PC_select;
input MEM_IR_select;
input latch_A_load;
output [7:0] from_A_to_mem;
output carry;
wire carry_to_reg;
wire [7:0]from_A_PC;
input compliment_or_adder;
wire [7:0]from_compliment;
output [7:0]from_B_to_adder;
wire [7:0]out_to_A;
wire [7:0]a_to_choose;
wire [7:0]to_B;
wire [7:0]from_B_to_compliment;

wire ground;
wire [7:0]from_adder;
wire [3:0]alu_select;
wire [7:0]out_to_A_latched;
wire latch_carry_load;
assign latch_carry_load = latch_A_load;
assign ground = 1'b0;
assign from_B_to_adder = from_B_to_compliment;
assign out_to_A = from_ALU;
assign from_A_to_mem = a_to_choose;

register2 A(.load(Aload),.value(a_to_choose),.d(out_to_A_latched),.reset(Areset));

register2 B(.load(Bload),.value(from_B_to_compliment),.d(to_B),.reset(Breset));

register2 latch_A(.load(latch_A_load),.value(out_to_A_latched),.d(out_to_A),.reset());

choose A_PC_choose(.in0(from_PC),.in1(a_to_choose),.select(A_PC_select),.out(from_A_PC),.enable(A_PC_enable));

choose mem_IR_choose(.in0(from_IR),.in1(from_mem),.select(MEM_IR_select),.out(to_B),.enable(mem_IR_enable));

compliment complimenter(.in(from_B_to_compliment),.out(from_compliment));

adder ADD(.carryin(ground),.X(from_B_to_adder),.Y(from_A_PC),.S(from_adder),.overflow(),.carryout(carry_to_reg));

carry_register carry_latcher(.load(latch_carry_load),.value(carry),.d(carry_to_reg),.reset());

choose adder_compliment_choose(.in0(from_adder),.in1(from_compliment),.select(compliment_or_adder),.out(from_ALU),.enable(adder_compliment_enable));



endmodule
