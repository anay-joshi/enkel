module increment(in,out,enable);
input [7:0]in;
input enable;
output [7:0] out;
reg [7:0] out;

always@(in or enable)
begin
if(enable)
out <= in+1;
end

endmodule
