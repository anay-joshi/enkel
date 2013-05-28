module compliment(in,out,enable);

input [7:0]in;
output reg[7:0]out;
input enable;
always@(in) 
begin 
out = ~in;
end
endmodule
