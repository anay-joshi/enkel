module d_array_testbench;

reg start;
reg clk;
reg reset;
wire q1,q2,q3,q4,q5;

d_array d(.start(start),.clk(clk),.q1(q1),.q2(q2),.q3(q3),.q4(q4),.q5(q5),.reset(reset));

initial begin
$dumpfile("array.vcd");
$dumpvars(q1,q1,q2,q3,q4,q5);
$monitor("t=%t ,clk=%b, q1=%b, q2=%b, q3=%b, q4=%b, q5=%b,start=%b", $time,clk,q1,q2,q3,q4,q5,start);

clk = 1'b1;

#1 reset = 1'b1;
#2 reset = 1'b0;
#1 start = 1'b1;
#5 start = 1'b0;

#100 $finish;


end

always
#5 clk = ~clk;

endmodule
