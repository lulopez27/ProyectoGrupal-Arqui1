module PipelineMem(input clk, rst,
						input wmemi,rmemi,wregi,wpci,input[1:0] jmpi,input [2:0]ALUInsi,input [31:0]R2ri,R3ri,input [3:0] R2i,R3i,DestRi,
						output logic wmemo,rmemo,wrego,wpco,output logic[1:0] jmpo,output logic[2:0]ALUInso,output [31:0]R2ro,R3ro,output [3:0] R2o,R3o,DestRo);
		always_ff@(posedge clk or posedge rst)
		if(rst) begin
			R2ro = 32'h00;
			R3ro = 32'h00;
			ALUInso = 3'h00;
			R2o = 4'h00;
			R3o = 4'h00;
			DestRo =4'h00;
			wmemo = 1'b0;
			rmemo = 1'b0;
			wrego = 1'b0;
			jmpo = 1'b0;
			wpco = 1'b0;
		end
		else begin
			R2ro = R2ri;
			R3ro = R3ri;
			ALUInso = ALUInsi;
			R2o = R2i;
			R3o = R3i;
			DestRo = DestRi;
			wmemo = wmemi;
			rmemo = rmemi;
			wrego = wregi;
			jmpo = jmpi;
			wpco = wpci;
		end
endmodule