module d_array(clk,start,q1,q2,q3,q4,q5,reset);

input reset;
input clk;
input start;
output q1,q2,q3,q4,q5;

d_ff d_ff_1(.d(start),.q(q1),.qbar(),.clk(clk),.reset(reset));
d_ff d_ff_2(.d(q1),.q(q2),.qbar(),.clk(clk),.reset(reset));
d_ff d_ff_3(.d(q2),.q(q3),.qbar(),.clk(clk),.reset(reset));
d_ff d_ff_4(.d(q3),.q(q4),.qbar(),.clk(clk),.reset(reset));
d_ff d_ff_5(.d(q4),.q(q5),.qbar(),.clk(clk),.reset(reset));



endmodule
