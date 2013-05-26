module pulse(turn_ON,trigger,start_computer,clk);

wire q1,q2;
input turn_ON;
input trigger;
input clk;
output start_computer;

d_ff D1(.d(trigger),.q(q1),.qbar(),.reset(turn_ON),.clk(clk));
d_ff D2(.d(q1),.q(q2),.qbar(),.reset(turn_ON),.clk(clk));

assign start_computer = q1 ^ q2;

endmodule

