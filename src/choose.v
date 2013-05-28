module choose(in0,in1,select,out,enable);

input enable;
input [7:0]in0;
input [7:0]in1;
output reg [7:0]out;
input select;
always@(enable or select or in0 or in1)
begin
	if(enable==0)
		out = 8'bzzzzzzzz;
	else if(select)
		out = in1;
	else
		out = in0;
end


endmodule
