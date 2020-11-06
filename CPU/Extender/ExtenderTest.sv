module ExtenderTest();

	logic[26:0] inmeIn;
	logic[1:0] Sel;
	logic[31:0] inmeOut;

	Extender DUT(inmeIn, Sel, inmeOut);
	
	initial begin
		
		inmeIn = 26'h200321;
		Sel = 2'b00;
		
		#10;
		
		Sel = 2'b01;
		
		#10;
		
		Sel = 2'b10;
		
		#10;
		
		Sel = 2'b11;
		
		#10;
	
	end

endmodule 