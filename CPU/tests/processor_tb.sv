module processor_tb();
	logic clk, rst, switch, GPIOEn;
	logic [7:0] GPIO;
	processor proce(clk,rst,switch,GPIO, GPIOEn);
	initial begin
		clk = 1'b1;
		rst = 1'b0;
		switch = 1'b0;
		#1
		rst = 1'b1;
		#1
		rst = 1'b0;
		switch = 1'b1;
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
		while (i<152100) begin
			@(negedge clk);
				if (GPIOEn == 'd1) begin
					$fwrite(f, "%h\n", GPIO);
					i = i + 1;
					end
		end
	
		$fclose(f);
		$finish;
			
	end
	
endmodule 