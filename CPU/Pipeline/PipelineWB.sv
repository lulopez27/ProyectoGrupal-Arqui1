module PipelineWB(input clk, rst,
						input[31:0]WrDatai,input wregi,
						output logic[31:0]WrDatao,output logic wrego);
	always_ff@(posedge clk or posedge rst)
		if(rst) begin
		WrDatao = 32'h00;
		wrego = 1'b0;
		end
		else begin
		WrDatao = WrDatai;
		wrego = wregi;
		end
endmodule 