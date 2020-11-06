module processor(input clk, rst);
	logic [1:0] op, inst;
	logic immin,immout,wmem, rmem, wreg, wpc, jmp,wmemo,rmemo,wrego,immo,wpco,jmpo,
			wmemi,rmemi,wregi,wpci,jmpi,wmemo2,rmemo2,wrego2,immo2,wpco2,jmpo2,wregi3,wrego3,jmpo1;
	logic [2:0] ALUins,ALUinso;
	logic [1:0] ExtndSel;
	logic [31:0] R2i,R3i,R1o,R2o,R3o,ALURo;
	logic [31:0] ALURi,ALURi3,ALURo3;
	logic [31:0] PC,PCF,PCinst;
	logic [3:0] destRegi,destRego,WrDesti,WrDesto,WrDesti2,WrDesto2,R2,R3;
	assign jmpo1 = wpco & jmpo;
	ControlUnit ctrlunit(op,inst,immin,
				immout, wmem, rmem, wreg,wpc,jmp,ALUins,ExtndSel);
	PipelineEx(clk,rst,R2i,R3i,destRegi,ALUins,wmem,rmem,wreg,immout,wpc,jmp,
				R1o,R2o,R3o,destRego,ALUinso,wmemo,rmemo,wrego,immo,wpco,jmpo);
	PipelineMem(clk,rst,ALURi,destRego,wmemo,rmemo,wrego,jmpo1,
				ALURo,WrDesto,wmemo2,rmemo2,wrego2,jmpo2);
	PipelineWB(clk,rst,ALURo,wrego2,
				ALURo3,wrego3);
	InstructionMemory InsMem(PC,PCF);
	FlipFlop #(32)ffPC(clk,rst,PCF,PCinst);
	assign op = PCinst[31:30];
	assign inst = PCinst[29:28];
	assign immin = PCinst[27];
	assign imme = PCinst[26:0];
	assign destRegi = PCinst[3:0];
	assign R2 = PCinst[7:4];
	assign R3 = PCinst[11:8];
	RegisterFile regFile(clk,wrego3,R2,R3,destRegi,ALURo3,PCF,R2i,R3i);//Pegarle el mux mas a la derecha en vez de ALURo3
	
endmodule