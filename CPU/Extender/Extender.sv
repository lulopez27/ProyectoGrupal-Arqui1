module Extender (input logic [26:0] inmeIn,
				     input logic [1:0] Sel,
					  output logic [31:0] inmeOut);
	
	always_comb
		case(Sel)
		// 15 bits
		2'b00: inmeOut = {{17{inmeIn[26]}}, inmeIn[26:12]};
		// 19 bits
		2'b01: inmeOut = {{13{inmeIn[26]}}, inmeIn[26:8]};
		// 23 bits
		2'b10: inmeOut = {{9{inmeIn[26]}}, inmeIn[26:4]};
		// 27 bits
		2'b11: inmeOut = {{5{inmeIn[26]}}, inmeIn[26:0]};		
		default: inmeOut = 0;
		endcase
		
endmodule 