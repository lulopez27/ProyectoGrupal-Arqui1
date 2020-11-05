module Negativo (input logic UltBit,
					  input logic Sel,
					  output logic Res);
										
	assign Res = UltBit & (Sel == 1'b0);

endmodule 