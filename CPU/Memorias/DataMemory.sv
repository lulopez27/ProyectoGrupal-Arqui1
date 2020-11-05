module DataMemory (input logic clk, we,
						 input logic [31:0] addr, wd,
						 output logic [31:0] rd);
				
	logic [31:0] RAM[255:0];
	
	assign rd = RAM[addr];

	always_ff @(negedge clk)
		if (we) RAM[addr] <= wd;
	
endmodule 