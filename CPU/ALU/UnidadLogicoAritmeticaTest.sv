module UnidadLogicoAritmeticaTest();

	logic[31:0] A, B, C;
	logic[2:0] Sel;
	logic banNegativo, banCero, banDesborde, banAcarreo;

	UnidadLogicoAritmetica #(32) DUT(A, B, Sel, C, banNegativo, banCero, banDesborde, banAcarreo);
	
	initial begin
		
		A = 32'd45;
		B = 32'd30;
		Sel = 3'b000;
		
		#10;
		
		B = 32'd45;
		Sel = 3'b001;
		
		#10;
		
		Sel = 3'b010;
		
		#10;
		
		B = 32'd10;
		Sel = 3'b011;
		
		#10;
		
		B = 32'd4;
		Sel = 3'b100;
		
		#10;
		
		Sel = 3'b101;
	
	end

endmodule 