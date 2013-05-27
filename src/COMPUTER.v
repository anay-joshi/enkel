module COMPUTER
(
turn_ON,
trigger,
clk,
start_computer,
CS,
WE,
OE,
Data,
Address,
programmer,
A_programmer_select,
show_out,
master_reset,
Pc,
from_IR_to_B,
from_PC_to_ALU,
from_A_to_mem,
from_mem_to_B,
carry,
start_SHOW,
start_ADD,
start_NOT,
start_GET,
start_JMPB,
start_LD,
start_FEED,
start_PUT,
start_FETCH,
status,
enter_CPU
);
output enter_CPU;
input turn_ON;
input trigger;
wire nclk;
output start_JMPB;
output start_LD;
output start_FEED;
output start_SHOW;
output start_GET;
output start_NOT;
output start_ADD;
inout [7:0]Data;
input clk;
input [7:0]programmer;
input A_programmer_select;
output start_computer;

output [7:0]show_out;
output [7:0]Address;
output start_FETCH;
output start_PUT;
output master_reset;
output CS;
output OE;
output WE;
input Pc;

wire A_PC_enable;
wire A_PC_select;
wire adder_compliment_enable;
wire Aload;
wire compliment_or_adder;
wire latch_A_load;
wire MAR_load;
wire Bc;
wire Bload;
wire MEM_IR_select;
wire mem_IR_enable;
wire IR_load;
wire IR_PC_select;
wire Ac;
wire APc;
wire [2:0]sel;
wire PC_load;
wire latch_PC_load;
wire INC_ALU_select;
output carry;
wire show_load;
wire [7:0]from_mem;
wire [7:0]from_IR;
wire [7:0]from_PC;
wire Areset;
wire Breset;
wire [7:0]from_B_to_adder;
wire PC_reset;
wire en_inc;
wire IR_reset;
output [7:0] from_A_to_mem;
output [7:0] from_mem_to_B;
output [7:0] from_IR_to_B;
output [7:0] from_PC_to_ALU;
wire [2:0] from_IR_to_decoder;
wire [7:0]from_ALU;
wire show_reset;
output status;

assign nclk = ~clk;
assign APc = Ac | Pc;
assign PC_reset = master_reset;
assign IR_reset = master_reset;
assign sel = from_IR_to_decoder;
assign show_reset = master_reset;
assign from_mem = from_mem_to_B;
assign from_IR = from_IR_to_B;
assign from_PC = from_PC_to_ALU;
assign Areset = master_reset;
assign Breset = master_reset;

pulse P(turn_ON,
trigger,
start_computer,
nclk);



CPU cpu(
master_reset,
clk,
A_PC_enable,
A_PC_select,
adder_compliment_enable,
Aload,
compliment_or_adder,
latch_A_load,
MAR_load,
Bc,
CS,
OE,
Bload,
MEM_IR_select,
mem_IR_enable,
IR_load,
IR_PC_select,
Ac,
WE,
sel,
PC_load,
latch_PC_load,
INC_ALU_select,
carry,
show_load,
start_computer,
en_inc,
start_FETCH,
start_PUT,
start_ADD,
start_NOT,
start_GET,
start_SHOW,
start_JMPB,
start_LD,
start_FEED,
status,
turn_ON,
enter_CPU
);




REST rest(
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


ALU alu(
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



 

endmodule
