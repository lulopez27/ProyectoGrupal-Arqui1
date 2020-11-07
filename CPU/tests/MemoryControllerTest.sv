module MemoryControllerTest();

	logic clk, we;
	logic[31:0] addr, wd, rd;

	MemoryController DUT(clk, we, addr, wd, rd);
	
	initial begin
	
		addr = 32'd0;
		#10;
		addr = 32'd10000;
		#10;
		addr = 32'd20000;
		#10;
		addr = 32'd30000;
		#10;
		addr = 32'd40000;
		#10;
		addr = 32'd50000;
		#10;
		addr = 32'd60000;
		#10;
		addr = 32'd70000;
		#10;
		addr = 32'd80000;
		#10;
		addr = 32'd90000;
		#10;
		addr = 32'd100000;
		#10;
		addr = 32'd110000;
		#10;
		addr = 32'd120000;
		#10;
		addr = 32'd130000;
		#10;
		addr = 32'd140000;
		#10;
		addr = 32'd150000;
		#10;
		
		clk = 1'b1;
		we = 1'b0;
		addr = 32'd152100;
		wd = 32'b0;
		
		#10;
		
		wd = 32'd152231;
		we = 1'b1;
		clk = 1'b0;
		
		#10;
		
		clk = 1'b1;
		we = 1'b0;
		addr = 32'd152101;
		wd = 32'd65;
		
		#10;
		
		clk = 1'b0;
		
		#10;
		
		addr = 32'd152100;
		clk = 1'b1;
	
		#10;
		
		addr = 32'd0;
		wd = 32'd44;
		clk = 1'b0;
		
		#10;
		
		clk = 1'b1;
		we = 1'b1;
		addr = 32'd304455;
		wd = 32'hffffffff;
		
		#10;
		
		clk = 1'b0;
	
	end

endmodule 