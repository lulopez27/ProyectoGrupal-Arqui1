module MemoryController (input logic clk, we, switch,
								 input logic [31:0] addr, wd,
								 output logic [31:0] rd, output logic [7:0] GPIO, output logic GPIOEn);
						 
	logic [31:0] trueAddr, ROMRd, RAMRd;
						 
	DataMemory RAM(clk, we, trueAddr, wd, RAMRd, GPIO,GPIOEn);
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
			else if (addr == 'd305736)
				begin
					trueAddr = 32'b0;
					rd = {31'b0, switch};
				end
			else
				begin
					trueAddr = 32'b0;
					rd = 32'b0;
				end
		end
						 
endmodule 