module Cero #(parameter N = 32) (input logic [N-1:0] C,
											input logic Sel,
											output logic Res);
													
	assign Res = (C == '0) & (Sel == 1'b0);
	
endmodule 