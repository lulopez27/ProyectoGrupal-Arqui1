module PipelineMem(input clk, rst,
						input[31:0]ALURi,WrDatai,input wmemi,rmemi,wregi,
						output logic[31:0]ALURo,WrDatao,output logic wmemo,rmemo,wrego,immo);
		always_ff@(posedge clk or posedge rst)
		if(rst) begin
		ALURo = 32'h00;
		WrDatao = 32'h00;
		wmemo = 1'b0;
		rmemo = 1'b0;
		wrego = 1'b0;
		end
		else begin
		ALURo = ALURi;
		WrDatao = WrDatai;
		wmemo = wmemi;
		rmemo = rmemi;
		wrego = wregi;
		end
endmodule