module processor_tb();
	logic clk, rst;
	processor proce(clk,rst);
	initial begin
		clk = 1'b1;
		rst = 1'b0;
		#1
		rst = 1'b1;
		#1
		rst = 1'b0;
	end
	always begin
		#5
		clk = ~clk;
	end
endmodule