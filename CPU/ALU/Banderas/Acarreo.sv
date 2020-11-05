module Acarreo (input logic CarSuma, CarResta, CarMultiplicacion,
				    input logic [2:0] Sel, 
				    output logic Res);
			
	assign Res = (CarSuma & (Sel == 3'b000)) | (CarResta & (Sel == 3'b001)) | (CarMultiplicacion & (Sel == 3'b010));
													
endmodule 