module InstructionMemoryTest();

	logic[31:0] addr, rd;

	InstructionMemory DUT(addr, rd);
	
	initial begin
	
		addr = 32'b0;
		
		#10;
		
		addr = 32'd1;
		
		#10;
		
		addr = 32'd2;
		
		#10;
		
		addr = 32'd3;
		
		#10;
		
		addr = 32'd4;
	
		#10;
	
	end

endmodule 