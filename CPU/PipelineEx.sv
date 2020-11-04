module PipelineEx( input clk, rst,
						input[31:0]R1i,R2i,R3i,input[3:0]destRegi,input[2:0] ALUinsi,input wmemi,rmemi,wregi,immi,
						output logic[31:0]R1o,R2o,R3o, output logic[3:0]destRego,
						output logic[2:0] ALUinso,output logic wmemo,rmemo,wrego,immo);
	always_ff@(posedge clk or posedge rst)
		if(rst) begin
		R1o = 32'h00;
		R2o = 32'h00;
		R3o = 32'h00;
		destRego = 4'b0000;
		ALUinso = 2'b00;
		wmemo = 1'b0;
		rmemo = 1'b0;
		wrego = 1'b0;
		immo = 1'b0;
		end
		else begin
		R1o = R1i;
		R2o = R2i;
		R3o = R3i;
		destRego = destRegi;
		ALUinso = ALUinsi;
		wmemo = wmemi;
		rmemo = rmemi;
		wrego = wregi;
		immo = immi;
		end
endmodule