module PipelineMem(input clk, rst,
						input wmemi,rmemi,wregi,jmpi,input[31:0]ALURi,input [3:0]WrDesti,
						output logic[31:0]ALURo,output logic[3:0]WrDesto,output logic wmemo,rmemo,wrego,jmpo);
						
						clk,rst|JumpEn,Wmem,Rmem,Wreg,Jmp,Wpc,ALUIns,R2res2,R3res2,R2,R3,DestR,
					Wmem1,Rmem1,Wreg1,Jmp1,Wpc1,ALUIns1,R2res3,R3res3,DestR_2
		always_ff@(posedge clk or posedge rst)
		if(rst) begin
		ALURo = 32'h00;
		WrDesto = 4'h00;
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