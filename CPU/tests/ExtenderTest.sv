module ExtenderTest();

	logic[27:0] inmeIn;
	logic[1:0] Sel;
	logic[31:0] inmeOut;

	Extender DUT(inmeIn, Sel, inmeOut);
	
	initial begin
		
		inmeIn = -15'd45;
		Sel = 2'b00;
		
		#10;
		
		inmeIn = 19'd10;
		Sel = 2'b01;
		
		#10;
		
		inmeIn = 23'd57;
		Sel = 2'b10;
		
		#10;
		
		inmeIn = 28'd98;
		Sel = 2'b11;
		
		#10;
	
	end

endmodule 