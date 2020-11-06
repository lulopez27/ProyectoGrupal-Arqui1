module Mux8 #(parameter N = 32) (input logic[N-1:0] result0, result1, result2, result3, result4, result5, result6, result7,
											input logic [2:0] Sel,
											output logic[N-1:0] Out);
	
	always_comb
		case(Sel)
			3'd0 : Out = result0;
			3'd1 : Out = result1;
			3'd2 : Out = result2;
			3'd3 : Out = result3;
			3'd4 : Out = result4;
			3'd5 : Out = result5;
			3'd6 : Out = result6;
			3'd7 : Out = result7;
			default : Out = 'z;
		endcase
		
endmodule 