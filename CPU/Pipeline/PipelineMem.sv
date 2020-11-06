module PipelineMem(input clk, rst,
						input[31:0]ALURi,WrDesti,input wmemi,rmemi,wregi,jmpi,
						output logic[31:0]ALURo,output logic[3:0]WrDesto,output logic wmemo,rmemo,wrego,jmpo);
		always_ff@(posedge clk or posedge rst)
		if(rst) begin
		ALURo = 32'h00;
		WrDesto = 32'h00;
		wmemo = 1'b0;
		rmemo = 1'b0;
		wrego = 1'b0;
		jmpo = 1'b0;
		end
		else begin
		ALURo = ALURi;
		WrDesto = WrDesti;
		wmemo = wmemi;
		rmemo = rmemi;
		wrego = wregi;
		jmpo = jmpi;
		end
endmodule 