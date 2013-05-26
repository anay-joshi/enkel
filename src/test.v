module test;

COMPUTER comp(
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
wire status;
wire start_JMPB;
wire start_LD;
wire start_FEED;
wire carry;
wire start_SHOW;
wire [7:0]from_mem_to_B;
wire start_GET;
wire start_NOT;
wire start_ADD;
wire [7:0]from_A_to_mem;
wire [7:0] from_PC_to_ALU;
wire [7:0]from_IR_to_B;
reg Pc;
reg clk;
wire start_computer;
wire CS;
wire WE;
wire OE;

wire [7:0]Address;
reg [7:0]programmer;
reg A_programmer_select;
wire [7:0]show_out;
wire start_PUT;
wire start_FETCH;
wire master_reset;
wire enter_CPU;
wire [7:0]Address_RAM;
reg [7:0]Address_program;
tri [7:0] Data;
reg turn_ON;
reg trigger;

reg computer_programmer_Address_select;
reg computer_programmer_pins_select;
wire e1,e2,e3,e4,e5;
wire computer_programmer_CS_select;
wire computer_programmer_OE_select;
wire computer_programmer_WE_select;
reg CS_program;
reg WE_program;
reg OE_program;
wire CS_RAM;
wire WE_RAM;
wire OE_RAM;
reg e;

assign computer_programmer_CS_select = computer_programmer_pins_select;
assign computer_programmer_OE_select = computer_programmer_pins_select;
assign computer_programmer_WE_select = computer_programmer_pins_select;


mux CS_mux(.in0(CS_program),.in1(CS),.out(CS_RAM),.select(computer_programmer_CS_select),.enable(e1));
mux WE_mux(.in0(WE_program),.in1(WE),.out(WE_RAM),.select(computer_programmer_WE_select),.enable(e2));
mux OE_mux(.in0(OE_program),.in1(OE),.out(OE_RAM),.select(computer_programmer_OE_select),.enable(e3));

RamChip ram (.Address(Address_RAM), .Data(Data), .CS(CS_RAM), .WE(WE_RAM), .OE(OE_RAM));

assign e1 = e;
assign e2 = e;
assign e3 = e;
assign e4 = e;
assign e5 = e;

choose computer_programmer_Address_choose(.in0(Address_program),.in1(Address),.select(computer_programmer_Address_select),.out(Address_RAM),.enable(e4));

assign e1 = e;
assign e2 = e;
assign e3 = e;
assign e4 = e;
assign e5 = e;



initial begin
	$dumpfile("test.vcd");
	$dumpvars(carry,carry,status,start_SHOW,turn_ON,trigger,enter_CPU,start_JMPB,start_LD,start_FEED,from_mem_to_B,from_PC_to_ALU,start_NOT,start_GET,start_ADD,from_A_to_mem,from_IR_to_B,start_computer,show_out,clk,start_PUT,CS_RAM,OE_RAM,WE_RAM,master_reset,start_FETCH,Data,Address_RAM,Address_program,computer_programmer_Address_select);

	Pc = 1'b1;
	clk = 1'b1;

	turn_ON = 1'b0;
	trigger = 1'b0;
	A_programmer_select = 1'b0;
	computer_programmer_pins_select = 1'b0;
	computer_programmer_Address_select = 1'b0;
	e = 1'b0;

	CS_program=1'b1;
	WE_program=1'b1;
	OE_program=1'b1;
	Address_program = 8'b00000000;
	programmer = 8'b00000000;

	#1 e = 1'b1;
	#5 CS_program=1'b0;
	#0 WE_program=1'b0;
	#5 WE_program=1'b1;

	// GET data from 11100

	#5 Address_program = 8'b00000000;
	#0 programmer = 8'b01011100;
	#5 WE_program = 1'b0;
	#5 WE_program = 1'b1;

	// NOT data and store it in A

	#5 Address_program = 8'b00000001;
	#0 programmer = 8'b00100000;
	#5 WE_program = 1'b0;
	#5 WE_program = 1'b1;

	// GET data from 11101

	#5 Address_program = 8'b00000010;
	#0 programmer = 8'b01011101;
	#5 WE_program = 1'b0;
	#5 WE_program = 1'b1;

	// ADD it to data stored in A and sore result in A. Effectively, we are subtracting second number from first number

	#5 Address_program = 8'b00000011;
	#0 programmer = 8'b00000000;
	#5 WE_program = 1'b0;


	#5 WE_program = 1'b1;

	// FEED 1 in B. (for adding it to JMPB


	#5 Address_program = 8'b00000100;
	#0 programmer = 8'b10000011;
	#5 WE_program = 1'b0;
	#5 WE_program = 1'b1;

	// conditional jump

	#5 Address_program = 8'b00000101;
	#0 programmer = 8'b11000000;
	#5 WE_program = 1'b0;
	#5 WE_program = 1'b1;

	#5 Address_program = 8'b00000110;
	#0 programmer = 8'b11111110;
	#5 WE_program = 1'b0;
	#5 WE_program = 1'b1;


	#5 Address_program = 8'b00000100;
	#0 programmer = 8'b10000001;
	#5 WE_program = 1'b0;
	#5 WE_program = 1'b1;


	#5 Address_program = 8'b00000111;
	#0 programmer = 8'b10100000;
	#5 WE_program = 1'b0;
	#5 WE_program = 1'b1;


	#5 Address_program = 8'b00001000;
	#0 programmer = 8'b11111111;
	#5 WE_program = 1'b0;
	#5 WE_program = 1'b1;

	#5 Address_program = 8'b00001001;
	#0 programmer = 8'b00000001;
	#5 WE_program = 1'b0;
	#5 WE_program = 1'b1;



	#5 Address_program = 8'b11100000;
	#0 programmer = 8'b00011010;
	#5 WE_program = 1'b0;
	#5 WE_program = 1'b1;


	#5 Address_program = 8'b11101000;
	#0 programmer = 8'b00010001;
	#5 WE_program = 1'b0;
	#5 WE_program = 1'b1;


	#5 Address_program = 8'b11110000;
	#0 programmer = 8'b00000010;
	#5 WE_program = 1'b0;
	#5 WE_program = 1'b1;


	#5 Address_program = 8'b11111000;
	#0 programmer = 8'b00000001;
	#5 WE_program = 1'b0;
	#5 WE_program = 1'b1;



	#5 Address_program = 8'b00000000;
	#5 programmer = 8'bzzzzzzzz;
	#5 OE_program = 1'b0;
	#5 Address_program = 8'b00000001;
	#5 Address_program = 8'b00000010;
	#5 Address_program = 8'b00000011;
	#5 Address_program = 8'b00000101;
	#5 OE_program = 1'b1;
	#5 CS_program = 1'b1;

	#5
	Pc = 1'b0;
	A_programmer_select = 1'b1;
	computer_programmer_pins_select = 1'b1;
	computer_programmer_Address_select = 1'b1;


	#5 turn_ON = 1'b1;
	#13 turn_ON = 1'b0;
	#13 trigger = 1'b1;
	/*
	#5 start_computer = 1'b1;
	#10 start_computer = 1'b0;
	*/
   #1500 $finish;
end

always
	#5 clk = ~clk;

endmodule
