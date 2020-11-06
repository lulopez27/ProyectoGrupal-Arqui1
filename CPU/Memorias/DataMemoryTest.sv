module DataMemoryTest();

	logic clk, we;
	logic[31:0] addr, wd, rd;

	DataMemory DUT(clk, we, addr, wd, rd);
	
	initial begin
		
		clk = 1'b1;
		we = 1'b1;
		addr = 32'b0;
		wd = 32'hAFAF;
		
		#10;
		
		clk = 1'b0;
		
		#10;
		
		clk = 1'b1;
		addr = 32'd10000;
		wd = 32'hFFFF;
		
		#10;
		
		clk = 1'b0;
		
		#10;
		
		clk = 1'b1;
		addr = 32'd152100;
		wd = 32'hABCDEFAA;
	
		#10;
		
		clk = 1'b0;
		
		#10;
		
		clk = 1'b1;
		addr = 32'b0;
		we = 1'b0;
		wd = 32'd1;
		
		#10;
		
		clk = 1'b0;
	
	end

endmodule 