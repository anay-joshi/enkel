module CPU
(
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

input turn_ON;
input status;
input start_computer;
input carry;

wire MASTER_RESET_;
output enter_CPU;
wire stop;
wire MASTER_RESET;


output master_reset;
output A_PC_enable;
output A_PC_select;
output adder_compliment_enable;
output Aload;
output compliment_or_adder;
output latch_A_load;
output MAR_load;
output Bc;
output CS;
output OE;
output Bload;
output MEM_IR_select;
output mem_IR_enable;
output IR_PC_select;
output IR_load;
output Ac; 
output WE;
output PC_load;
output latch_PC_load;
output INC_ALU_select;
output show_load;
output en_inc;


assign master_reset = MASTER_RESET;
assign MASTER_RESET_ = MASTER_RESET;
assign en_inc = en_inc_NEXT;
assign latch_PC_load = latch_PC_load_LD | latch_PC_load_JMPB;
assign PC_load = PC_load_LD | PC_load_JMPB | PC_load_NEXT;
assign INC_ALU_select = INC_ALU_select_LD | INC_ALU_select_JMPB | INC_ALU_select_NEXT;
assign A_PC_enable = A_PC_enable_ADD | A_PC_enable_LD | A_PC_enable_JMPB;
assign A_PC_select = A_PC_select_ADD | A_PC_select_LD | A_PC_select_JMPB;
assign adder_compliment_enable = adder_compliment_enable_ADD | adder_compliment_enable_NOT | adder_compliment_enable_LD | adder_compliment_enable_JMPB;

assign Aload = Aload_ADD | Aload_NOT;
assign compliment_or_adder = compliment_or_adder_ADD | compliment_or_adder_NOT | compliment_or_adder_LD | compliment_or_adder_JMPB;
assign latch_A_load = latch_A_load_ADD | latch_A_load_NOT;
assign MAR_load = MAR_load_GET | MAR_load_FETCH | MAR_load_PUT | MAR_load_SHOW;
assign Bc = Bc_GET | Bc_FETCH | Bc_SHOW;
assign CS = ~((~CS_GET) |(~CS_FETCH) | (~CS_PUT) | (~CS_SHOW));
assign OE = ~((~OE_GET) |(~OE_FETCH) | (~OE_SHOW));
assign Bload = Bload_GET | Bload_FEED;
assign MEM_IR_select = MEM_IR_select_GET | MEM_IR_select_FEED;
assign mem_IR_enable = mem_IR_enable_GET | mem_IR_enable_FEED;
assign IR_PC_select = IR_PC_select_FETCH | IR_PC_select_PUT | IR_PC_select_SHOW | IR_PC_select_GET;
assign IR_load = IR_load_FETCH;
assign Ac = Ac_PUT;
assign WE = WE_PUT;
assign show_load = show_load_SHOW;

d_ff start_stage_1(.d(start_computer),.q(MASTER_RESET),.qbar(),.clk(clk),.reset(reset_start_stage_1));
d_ff start_stage_2(.d(MASTER_RESET_),.q(enter_CPU),.qbar(),.clk(clk),.reset(reset_start_stage_2));



decoder_plus dec(.sel(sel),.res(res));

input [2:0]sel;
wire [7:0]res;
wire dec_ADD;
wire dec_NOT;
wire dec_GET;
wire dec_PUT;
wire dec_FEED;
wire dec_LD;
wire dec_JMPB;
wire dec_SHOW;

assign dec_ADD = res[0];
assign dec_NOT = res[1];
assign dec_GET = res[2];
assign dec_PUT = res[3];
assign dec_FEED = res[4];
assign dec_LD = res[5];
assign dec_JMPB = res[6];
assign dec_SHOW = res[7];


input clk;

d_array GET(.start(start_GET),.reset(reset_GET),.q1(q1_GET),.q2(q2_GET),.q3(q3_GET),.q4(q4_GET),.q5(q5_GET),.clk(clk));


output start_GET;
wire reset_GET;
wire q1_GET,q2_GET,q3_GET,q4_GET,q5_GET;

wire MEM_IR_select_GET;
wire mem_IR_enable_GET;
wire MAR_load_GET;
wire CS_GET;
wire Bc_GET;
wire OE_GET;
wire Bload_GET;
wire IR_PC_select_GET;

/*
#5 MAR_load = 1'b1;
#0 CS = 1'b0;
#0 Bc = 1'b1;

#5 OE = 1'b0;
#0 Bload = 1'b1;

#5 Bload = 1'b0;

#5 OE = 1'b1;
#0 Bc = 1'b0;
#0 CS = 1'b1;
#0 MAR_load = 1'b0;
*/


assign IR_PC_select_GET = q1_GET | q2_GET | q3_GET |q4_GET | q5_GET;
assign MEM_IR_select_GET = 1'b1 & dec_GET;
assign mem_IR_enable_GET = 1'b1 & dec_GET;

assign MAR_load_GET = q1_GET |q2_GET |q3_GET;
assign CS_GET = ~(q1_GET |q2_GET |q3_GET);
assign Bc_GET = q1_GET |q2_GET |q3_GET;
assign OE_GET = ~(q2_GET |q3_GET);
assign Bload_GET = q2_GET;




/*
#0 compliment_or_adder = 1'b0;

#5 A_PC_enable = 1'b1;

#5 A_PC_select = 1'b1;
#0 adder_compliment_enable = 1'b1;
#0 latch_A_load = 1'b1;

#5 latch_A_load = 1'b0;

#5 A_PC_enable = 1'b0;
#0 A_PC_select = 1'b0;
#0 adder_compliment_enable = 1'b0;

#5 Aload = 1'b1;
*/

d_array ADD(.start(start_ADD),.q1(q1_ADD),.q2(q2_ADD),.q3(q3_ADD),.q4(q4_ADD),.q5(q5_ADD),.reset(reset_ADD),.clk(clk));
wire q1_ADD,q2_ADD,q3_ADD,q4_ADD,q5_ADD;

output start_ADD;
wire reset_ADD;
wire A_PC_enable_ADD;
wire A_PC_select_ADD;
wire  adder_compliment_enable_ADD;
wire Aload_ADD;
wire compliment_or_adder_ADD;
wire latch_A_load_ADD;

assign compliment_or_adder_ADD = 1'b0 & dec_ADD;
assign A_PC_enable_ADD = q1_ADD | q2_ADD | q3_ADD;
assign A_PC_select_ADD = q2_ADD | q3_ADD;
assign latch_A_load_ADD = q2_ADD;
assign adder_compliment_enable_ADD = q2_ADD | q3_ADD; 
assign Aload_ADD = q5_ADD;


/*
#0 compliment_or_adder = 1'b1;

#5 adder_compliment_enable = 1'b1;
#0 latch_A_load = 1'b1;

#5 latch_A_load = 1'b0;
#5 adder_compliment_enable = 1'b0;

#5 Aload = 1'b1;
*/
d_array NOT(.start(start_NOT),.q1(q1_NOT),.q2(q2_NOT),.q3(q3_NOT),.q4(q4_NOT),.q5(q5_NOT),.reset(reset_NOT),.clk(clk));

wire q1_NOT,q2_NOT,q3_NOT,q4_NOT,q5_NOT;

output start_NOT;
wire reset_NOT;
wire compliment_or_adder_NOT;
wire adder_compliment_enable_NOT;
wire latch_A_load_NOT;
wire Aload_NOT;

assign compliment_or_adder_NOT = 1'b1 & dec_NOT;
assign adder_compliment_enable_NOT = q1_NOT | q2_NOT;
assign latch_A_load_NOT = q2_NOT;
assign Aload_NOT = q4_NOT;



d_array PUT(.start(start_PUT),.q1(q1_PUT),.q2(q2_PUT),.q3(q3_PUT),.q4(q4_PUT),.q5(q5_PUT),.reset(reset_PUT),.clk(clk));
wire q1_PUT,q2_PUT,q3_PUT,q4_PUT,q5_PUT;
/*
IR_PC_select = 1'b1;

#5 MAR_load = 1'b1;

#5 CS = 1'b0;
#0 Ac = 1'b1;

#5 WE = 1'b0;

#5 WE = 1'b1;

#5 Ac = 1'b0;
#0 CS = 1'b1;
#0 MAR_load = 1'b0;
*/
output start_PUT;
wire reset_PUT;
wire IR_PC_select_PUT;
wire MAR_load_PUT;
wire CS_PUT;
wire Ac_PUT;
wire WE_PUT;

assign IR_PC_select_PUT = q1_PUT | q2_PUT | q3_PUT | q4_PUT | q5_PUT;
assign MAR_load_PUT = q1_PUT | q2_PUT | q3_PUT | q4_PUT;
assign CS_PUT = ~(q2_PUT | q3_PUT | q4_PUT);
assign WE_PUT = ~(q3_PUT | q4_PUT);
assign Ac_PUT = q2_PUT | q3_PUT | q4_PUT;

d_array FEED(.start(start_FEED),.q1(q1_FEED),.q2(q2_FEED),.q3(q3_FEED),.q4(q4_FEED),.q5(q5_FEED),.reset(reset_FEED),.clk(clk));
wire q1_FEED,q2_FEED,q3_FEED,q4_FEED,q5_FEED;
/*
#5 mem_IR_enable = 1'b1;
#5 MEM_IR_select = 1'b0;
#5 Bload = 1'b1;
#5 Bload = 1'b0;
#5 mem_IR_enable = 1'b0;
*/
wire mem_IR_enable_FEED;
wire MEM_ir_select_FEED;
wire Bload_FEED;
wire reset_FEED;
output start_FEED;
wire MEM_IR_select_FEED;

assign mem_IR_enable_FEED = q1_FEED | q2_FEED | q3_FEED | q4_FEED;
assign MEM_IR_select_FEED = 1'b0;
assign Bload_FEED = q3_FEED;


d_array LD(.start(start_LD),.q1(q1_LD),.q2(q2_LD),.q3(q3_LD),.q4(q4_LD),.q5(q5_LD),.reset(reset_LD),.clk(clk));
wire q1_LD,q2_LD,q3_LD,q4_LD,q5_LD;

/*
A_PC_select = 1'b0;
compliment_or_adder = 1'b0;

#5 A_PC_enable = 1'b1;
#0 adder_compliment_enable = 1'b1;

#5 latch_PC_load = 1'b1;
#5 latch_PC_load = 1'b0;

#5 adder_compliment_enable = 1'b0;
#0 A_PC_enable = 1'b0;
#0 INC_ALU_select = 1'b0;
#0 PC_load = 1'b1;

#5 PC_load = 1'b0;
*/

wire reset_LD;
output start_LD;
wire A_PC_select_LD;
wire compliment_or_adder_LD;
wire A_PC_enable_LD;
wire adder_compliment_enable_LD;
wire latch_PC_load_LD;
wire INC_ALU_select_LD;
wire PC_load_LD;

assign A_PC_select_LD = 1'b0;
assign compliment_or_adder_LD = 1'b0;
assign INC_ALU_select_LD = 1'b0;
assign A_PC_enable_LD = q1_LD | q2_LD | q3_LD;
assign adder_compliment_enable_LD = q1_LD | q2_LD | q3_LD;
assign latch_PC_load_LD = q2_LD;
assign PC_load_LD = q4_LD;

d_array JMPB(.start(start_JMPB),.q1(Q1_JMPB),.q2(Q2_JMPB),.q3(Q3_JMPB),.q4(Q4_JMPB),.q5(Q5_JMPB),.reset(reset_JMPB),.clk(clk));
wire q1_JMPB,q2_JMPB,q3_JMPB,q4_JMPB,q5_JMPB;
wire Q1_JMPB,Q2_JMPB,Q3_JMPB,Q4_JMPB,Q5_JMPB;

assign q1_JMPB = Q1_JMPB & carry;
assign q2_JMPB = Q2_JMPB & carry;
assign q3_JMPB = Q3_JMPB & carry;
assign q4_JMPB = Q4_JMPB & carry;
assign q5_JMPB = Q5_JMPB & carry;

wire reset_JMPB;
output start_JMPB;
wire A_PC_select_JMPB;
wire compliment_or_adder_JMPB;
wire A_PC_enable_JMPB;
wire adder_compliment_enable_JMPB;
wire latch_PC_load_JMPB;
wire INC_ALU_select_JMPB;
wire PC_load_JMPB;

assign A_PC_select_JMPB = 1'b0;
assign compliment_or_adder_JMPB = 1'b0;
assign INC_ALU_select_JMPB = 1'b0;
assign A_PC_enable_JMPB = q1_JMPB | q2_JMPB | q3_JMPB;
assign adder_compliment_enable_JMPB = q1_JMPB | q2_JMPB | q3_JMPB;
assign latch_PC_load_JMPB = q2_JMPB;
assign PC_load_JMPB = q4_JMPB;


d_array SHOW(.start(start_SHOW),.q1(q1_SHOW),.q2(q2_SHOW),.q3(q3_SHOW),.q4(q4_SHOW),.q5(q5_SHOW),.reset(reset_SHOW),.clk(clk));
wire q1_SHOW,q2_SHOW,q3_SHOW,q4_SHOW,q5_SHOW;
/*
IR_PC_select = 1'b0;

#5 MAR_load = 1'b1;
#0 CS = 1'b0;
#0 Bc = 1'b1;
#5 OE = 1'b0;
#5 show_load = 1'b1;
#5 show_load = 1'b0;
#5 OE = 1'b1;
#0 Bc = 1'b0;
#0 CS = 1'b1;
#0 MAR_load = 1'b0;
*/
wire reset_SHOW;
output start_SHOW;
wire reset_NEXT;

wire MAR_load_SHOW;
wire CS_SHOW;
wire Bc_SHOW;
wire OE_SHOW;
wire show_load_SHOW;
wire IR_PC_select_SHOW;
wire IR_load_SHOW;


assign IR_PC_select_SHOW = q1_SHOW | q2_SHOW | q3_SHOW | q4_SHOW | q5_SHOW;
assign MAR_load_SHOW = q1_SHOW | q2_SHOW | q3_SHOW | q4_SHOW;
assign CS_SHOW = ~(q1_SHOW | q2_SHOW | q3_SHOW);
assign Bc_SHOW = q2_SHOW | q3_SHOW;
assign OE_SHOW = ~(q2_SHOW | q3_SHOW);
assign show_load_SHOW = q3_SHOW;

d_array FETCH(.start(start_FETCH),.q1(q1_FETCH),.q2(q2_FETCH),.q3(q3_FETCH),.q4(q4_FETCH),.q5(q5_FETCH),.reset(reset_FETCH),.clk(clk));

wire q1_FETCH,q2_FETCH,q3_FETCH,q4_FETCH,q5_FETCH;

/*

#0 IR_PC_select = 1'b0;
MAR_load=1'b1;
CS = 1'b0;

#5 MAR_load = 1'b0;
#0 OE = 1'b0;
#0 Bc = 1'b1;
#0 IR_load = 1'b1;

#5 IR_load = 1'b0;

#5 OE = 1'b1;
#0 Bc = 1'b0;
#0 CS = 1'B1;
*/
wire reset_FETCH;
output start_FETCH;
wire IR_PC_select_FETCH;
wire MAR_load_FETCH;
wire CS_FETCH;
wire OE_FETCH;
wire Bc_FETCH;
wire IR_load_FETCH;


assign IR_PC_select_FETCH = 1'b0;
assign MAR_load_FETCH = q2_FETCH;
assign CS_FETCH = ~(q2_FETCH | q3_FETCH | q4_FETCH);
assign OE_FETCH = ~(q3_FETCH | q4_FETCH);
assign Bc_FETCH = q3_FETCH | q4_FETCH;
assign IR_load_FETCH = q3_FETCH;

d_array NEXT(.start(q5_FETCH),.q1(q1_NEXT),.q2(q2_NEXT),.q3(q3_NEXT),.q4(q4_NEXT),.q5(q5_NEXT),.reset(reset_NEXT),.clk(clk));
wire q1_NEXT,q2_NEXT,q3_NEXT,q4_NEXT,q5_NEXT;
/*
#5 en_inc = 1'b1;
#5 INC_ALU_select = 1'b1;
#5 en_inc = 1'b0;
#5 PC_load = 1'b1;
#5 PC_load = 1'b0;
*/
wire en_inc_NEXT;
wire INC_ALU_select_NEXT;
wire PC_load_NEXT;

assign en_inc_NEXT = q1_NEXT | q2_NEXT;
assign INC_ALU_select_NEXT = q1_NEXT | q2_NEXT | q3_NEXT | q4_NEXT | q5_NEXT;
assign PC_load_NEXT = q4_NEXT;


assign reset_ADD = master_reset;
assign reset_NOT = master_reset;
assign reset_GET = master_reset;
assign reset_PUT = master_reset;
assign reset_FETCH = master_reset;
assign reset_FEED = master_reset;
assign reset_LD = master_reset;
assign reset_JMPB = master_reset;
assign reset_SHOW = master_reset;
assign reset_NEXT = master_reset;

assign start_ADD = dec_ADD & q5_NEXT;
assign start_NOT = dec_NOT & q5_NEXT;
assign start_GET = dec_GET & q5_NEXT;
assign start_PUT = dec_PUT & q5_NEXT;
assign start_FEED = dec_FEED & q5_NEXT;
assign start_LD = dec_LD & q5_NEXT;
assign start_JMPB = dec_JMPB & q5_NEXT;
assign start_SHOW = dec_SHOW & q5_NEXT;

wire reset_start_stage_1;
wire reset_start_stage_2;
assign reset_start_stage_1 = turn_ON;
assign reset_start_stage_2 = turn_ON;


assign start_FETCH = (q5_ADD | q5_NOT | q5_GET | q5_PUT | q5_FEED | q5_SHOW | q5_LD | Q5_JMPB | enter_CPU) & status ;

endmodule
