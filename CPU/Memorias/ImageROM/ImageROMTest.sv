module ImageROMTest();

	logic[31:0] addr, rd;

	ImageROM DUT(addr, rd);
	
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
	
	end

endmodule 