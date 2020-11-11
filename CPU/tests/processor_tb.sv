`timescale 1s/1s
module processor_tb();
	logic clk, rst, GPIOEn;
	logic [7:0] GPIO;
	processor proce(clk,rst, GPIO, GPIOEn);
	initial begin
		clk = 1'b1;
		rst = 1'b0;
		#1
		rst = 1'b1;
		#1
		rst = 1'b0;
	end
	always begin
		#1
		clk = ~clk;
	end
//	int f, i;
//	initial begin
//		f = $fopen("output.txt", "w");
//		#5;
//		for (i = 0; i<152100; i++) begin
//			@(negedge GPIOEn);
//			$fwrite(f, "%h\n", GPIO);
//		end
//		
//		$fclose(f);
//		$finish;
//			
//	end
	
endmodule 