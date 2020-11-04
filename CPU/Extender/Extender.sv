module Extender (input logic [27:0] inmeIn,
				     input logic [1:0] Sel,
					  output logic [31:0] inmeOut);
	
	always_comb
		case(Sel)
		// 15 bits
		2'b00: inmeOut = {{18{inmeIn[14]}}, inmeIn[13:0]};
		// 19 bits
		2'b01: inmeOut = {{14{inmeIn[14]}}, inmeIn[17:0]};
		// 23 bits
		2'b10: inmeOut = {{10{inmeIn[14]}}, inmeIn[21:0]};
		// 28 bits
		2'b11: inmeOut = {{5{inmeIn[14]}}, inmeIn[26:0]};		
		default: inmeOut = 0;
		endcase
		
endmodule 