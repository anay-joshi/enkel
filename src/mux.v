module mux(in0,in1,select,out,enable);

input enable;
input in0;
input in1;
output reg out;
input select;
always@(enable or select or in0 or in1)
begin
if(enable==0)
out = 8'bz;
else if(select)
out <= in1;
else
out <= in0;
end


endmodule
