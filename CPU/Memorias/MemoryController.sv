module MemoryController (input logic clk, we,
								 input logic [31:0] addr, wd,
								 output logic [31:0] rd, GPIOaddr, output logic [7:0] GPIO, output logic GPIOEn);
						 
	logic [31:0] trueAddr, ROMRd, RAMRd;
						 
	DataMemory RAM(clk, we, trueAddr, wd, RAMRd, GPIOaddr, GPIO,GPIOEn);
	ImageROM ROM(trueAddr, ROMRd);
	
	always_comb
		begin
			if (addr >= 'd0 && addr <= 'd152099)
				begin
					trueAddr = addr;
					rd = ROMRd;
				end
			else if (addr >= 'd152100 && addr <= 'd305735)
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