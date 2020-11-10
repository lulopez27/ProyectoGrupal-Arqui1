module DataMemory (input logic clk, we,
						 input logic [31:0] addr, wd,
						 output logic [31:0] rd, output logic [7:0] GPIO,output logic GPIOEn);
				
	logic [7:0] RAM1[9999:0];
	logic [7:0] RAM2[9999:0];
	logic [7:0] RAM3[9999:0];
	logic [7:0] RAM4[9999:0];
	logic [7:0] RAM5[9999:0];
	logic [7:0] RAM6[9999:0];
	logic [7:0] RAM7[9999:0];
	logic [7:0] RAM8[9999:0];
	logic [7:0] RAM9[9999:0];
	logic [7:0] RAM10[9999:0];
	logic [7:0] RAM11[9999:0];
	logic [7:0] RAM12[9999:0];
	logic [7:0] RAM13[9999:0];
	logic [7:0] RAM14[9999:0];
	logic [7:0] RAM15[9999:0];
	logic [7:0] RAM16[2099:0];
	logic [31:0] RAMD[1535:0];
	
	always_comb
		begin
			if (addr >= 'd0 && addr <= 'd9999)
				rd = {24'b0, RAM1[addr]};
			else if (addr >= 'd10000 && addr <= 'd19999)
				rd = {24'b0, RAM2[addr - 'd10000]};
			else if (addr >= 'd20000 && addr <= 'd29999)
				rd = {24'b0, RAM3[addr - 'd20000]};
			else if (addr >= 'd30000 && addr <= 'd39999)
				rd = {24'b0, RAM4[addr - 'd30000]};
			else if (addr >= 'd40000 && addr <= 'd49999)
				rd = {24'b0, RAM5[addr - 'd40000]};
			else if (addr >= 'd50000 && addr <= 'd59999)
				rd = {24'b0, RAM6[addr - 'd50000]};
			else if (addr >= 'd60000 && addr <= 'd69999)
				rd = {24'b0, RAM7[addr - 'd60000]};
			else if (addr >= 'd70000 && addr <= 'd79999)
				rd = {24'b0, RAM8[addr - 'd70000]};
			else if (addr >= 'd80000 && addr <= 'd89999)
				rd = {24'b0, RAM9[addr - 'd80000]};
			else if (addr >= 'd90000 && addr <= 'd99999)
				rd = {24'b0, RAM10[addr - 'd90000]};
			else if (addr >= 'd100000 && addr <= 'd109999)
				rd = {24'b0, RAM11[addr - 'd100000]};
			else if (addr >= 'd110000 && addr <= 'd119999)
				rd = {24'b0, RAM12[addr - 'd110000]};
			else if (addr >= 'd120000 && addr <= 'd129999)
				rd = {24'b0, RAM13[addr - 'd120000]};
			else if (addr >= 'd130000 && addr <= 'd139999)
				rd = {24'b0, RAM14[addr - 'd130000]};
			else if (addr >= 'd140000 && addr <= 'd149999)
				rd = {24'b0, RAM15[addr - 'd140000]};
			else if (addr >= 'd150000 && addr <= 'd152099)
				rd = {24'b0, RAM16[addr - 'd150000]};
			else if (addr >= 'd152100 && addr <= 'd153635)
				rd = RAMD[addr - 'd152100];
			else
				rd = 32'b0;
		end
	

	always_ff @(negedge clk)
		begin
			if (we) 
				begin
					if (addr >= 'd0 && addr <= 'd9999)
						RAM1[addr] <= wd[7:0];
					else if (addr >= 'd10000 && addr <= 'd19999)
						RAM2[addr - 'd10000] <= wd[7:0];
					else if (addr >= 'd20000 && addr <= 'd29999)
						RAM3[addr - 'd20000] <= wd[7:0];
					else if (addr >= 'd30000 && addr <= 'd39999)
						RAM4[addr - 'd30000] <= wd[7:0];
					else if (addr >= 'd40000 && addr <= 'd49999)
						RAM5[addr - 'd40000] <= wd[7:0];
					else if (addr >= 'd50000 && addr <= 'd59999)
						RAM6[addr - 'd50000] <= wd[7:0];
					else if (addr >= 'd60000 && addr <= 'd69999)
						RAM7[addr - 'd60000] <= wd[7:0];
					else if (addr >= 'd70000 && addr <= 'd79999)
						RAM8[addr - 'd70000] <= wd[7:0];
					else if (addr >= 'd80000 && addr <= 'd89999)
						RAM9[addr - 'd80000] <= wd[7:0];
					else if (addr >= 'd90000 && addr <= 'd99999)
						RAM10[addr - 'd90000] <= wd[7:0];
					else if (addr >= 'd100000 && addr <= 'd109999)
						RAM11[addr - 'd100000] <= wd[7:0];
					else if (addr >= 'd110000 && addr <= 'd119999)
						RAM12[addr - 'd110000] <= wd[7:0];
					else if (addr >= 'd120000 && addr <= 'd129999)
						RAM13[addr - 'd120000] <= wd[7:0];
					else if (addr >= 'd130000 && addr <= 'd139999)
						RAM14[addr - 'd130000] <= wd[7:0];
					else if (addr >= 'd140000 && addr <= 'd149999)
						RAM15[addr - 'd140000] <= wd[7:0];
					else if (addr >= 'd150000 && addr <= 'd152099)
						RAM16[addr - 'd150000] <= wd[7:0];
					else if (addr >= 'd152100 && addr <= 'd153635)
						RAMD[addr - 'd152100] <= wd;
				end
		end
		
		always_ff @(posedge clk) begin
			if (we) 
					if (addr >= 'd0 && addr <= 'd152099)begin
						GPIO = wd[7:0];
						end
		end
				
		always_latch begin
			if (addr >= 'd0 && addr <= 'd152099)begin
					GPIOEn = we;
			end
		end
				
		
endmodule 