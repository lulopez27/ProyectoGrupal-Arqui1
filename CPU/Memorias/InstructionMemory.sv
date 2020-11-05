module InstructionMemory (input logic [31:0] addr,
								  output logic [31:0] rd);
	
	logic [31:0] ROM[127:0];
	
	initial
		$readmemh("instructions.txt", ROM);
		
	assign rd = ROM[addr[31:0]];
	
endmodule 