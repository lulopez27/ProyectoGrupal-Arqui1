module MemoryController (input logic clk, we,
								 input logic [31:0] addr, wd,
								 output logic [31:0] rd);
						 
	logic [31:0] trueAddr, ROMRd, RAMRd;
						 
	DataMemory RAM(clk, we, trueAddr, wd, RAMRd);
	ImageROM ROM(trueAddr, ROMRd);
	
	always_comb
		begin
			if (addr >= 'd0 && addr <= 'd152099)
				begin
					trueAddr = addr;
					rd = ROMRd;
				end
			else if (addr >= 'd152100 && addr <= 'd304455)
				begin
					trueAddr = addr - 'd152100;
					rd = RAMRd;
				end
			else
				begin
					trueAddr = 32'b0;
					rd = ROMRd;
				end
		end
						 
endmodule 