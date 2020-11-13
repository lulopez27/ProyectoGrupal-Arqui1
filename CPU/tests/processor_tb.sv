`timescale 1s/1s
module processor_tb();
	logic clk, rst, GPIOEn;
	logic [7:0] GPIO;
	logic [31:0] GPIOaddr;
	processor proce(clk,rst,GPIOaddr, GPIO, GPIOEn);
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
	
	int f, i;
	initial begin
		f = $fopen("output.txt", "w");
		i = 0;
		#5;
		while (i<25) begin
			@(negedge clk);
				if (GPIOaddr >= 'd152100 && GPIOaddr <= 'd304199 && GPIOEn == 'd1) begin
					$fwrite(f, "%h\n", GPIO);
					i = i + 1;
					end
		end
	
		$fclose(f);
		$finish;
			
	end
	
endmodule 