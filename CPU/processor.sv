module processor(input clk, rst);
//	logic [1:0] op, inst;
//	logic immin,immout,wmem, rmem, wreg, wpc, jmp,wmemo,rmemo,wrego,immo,wpco,jmpo,
//			wmemi,rmemi,wregi,wpci,jmpi,wmemo2,rmemo2,wrego2,immo2,wpco2,jmpo2,wregi3,wrego3,jmpo1;
//	logic [2:0] ALUins,ALUinso;
//	logic [1:0] ExtndSel;
//	logic [31:0] R2i,R3i,R1o,R2o,R3o,ALURo;
//	logic [31:0] ALURi,ALURi3,ALURo3;
//	logic [31:0] PC,PCF,instruction;
//	logic [26:0] imme;
//	logic [3:0] destRegi,destRego,WrDesti,WrDesto,WrDesti2,WrDesto2,R2,R3;
//	assign jmpo1 = wpco & jmpo;
//	ControlUnit ctrlunit(op,inst,immin,
//				immout, wmem, rmem, wreg,wpc,jmp,ALUins,ExtndSel);
//	PipelineEx(clk,rst,R2i,R3i,destRegi,ALUins,wmem,rmem,wreg,immout,wpc,jmp,
//				R1o,R2o,R3o,destRego,ALUinso,wmemo,rmemo,wrego,immo,wpco,jmpo);
//	PipelineMem(clk,rst,ALURi,destRego,wmemo,rmemo,wrego,jmpo1,
//				ALURo,WrDesto,wmemo2,rmemo2,wrego2,jmpo2);
//	PipelineWB(clk,rst,ALURo,wrego2,
//				ALURo3,wrego3);
//	InstructionMemory InsMem(PC,PCF);
//	FlipFlop #(32)ffPC(clk,rst,PCF,instruction);
//	assign op = instruction[31:30];
//	assign inst = instruction[29:28];
//	assign immin = instruction[27];
//	assign imme = instruction[26:0];
//	assign destRegi = instruction[3:0];
//	assign R2 = instruction[7:4];
//	assign R3 = instruction[11:8];
//	RegisterFile regFile(clk,wrego3,R2,R3,destRegi,ALURo3,PCF,R2i,R3i);//Pegarle el mux mas a la derecha en vez de ALURo3
//	
	logic [31:0]next_pc;
	Mux2 #(32)PC_Mux (pc_p1,ALURes,JumpEn,next_pc);
	logic[31:0] curr_pc;
	FlipFlop #(32) PC(clk,rst,next_pc,curr_pc);
	logic[31:0] pc_p1;
	Suma #(32)PC_1(curr_pc,32'h1,pc_p1,);
	logic [31:0] AcIns;
	InstructionMemory InsMem(curr_pc,AcIns);
	logic [31:0] instruction;
	FliFlop #(32)pipelineFetch(clk,rst|JumpEn,AcIns,instruction)
	//##########################################
	logic [1:0]num_op,inst;
	logic immF;
	logic[3:0] R2,R3,DestR;
	logic[26:0] immediate;
	assign num_op = instruction[31:30];
	assign inst = instruction[29:28];
	assign immF = instruction[27];
	assign immediate = instruction[26:0];
	assign DestR = instruction[3:0];
	assign R2 = instruction[7:4];
	assign R3 = instruction[11:8];
	//##########################################
	logic Wmem,Rmem,Wreg,Jmp,Wpc;
	logic [2:0]ALUIns;
	logic [1:0]ExtndSel;
	ControlUnit  CtrlUnit(num_op,inst,immF,Wmem,Rmem,Wreg,Jmp,Wpc,ALUIns,ExtndSel);
	logic [31:0]R2r,R3r;
	RegisterFile RegFile(clk,Wreg3,R2,R3,DestR_4,Res1,R2r,R3r);
	logic [31:0]ExtendRes;
	Extend (immediate,ExtndSel,ExtendRes);
	logic [31:0]R3res;
	Mux2 #(32)Extend_Mux(R3r,ExtendRes,immF,R3res);
	logic [31:0]R2res;
	Mux2 #(32)PCReg_Mux(R2r,curr_pc,Jmp,R2res);
	
//	logic [31:0]R2res2,R3res2;
//	ForwUnitReg (R2res,R3res,R2,R3,DestR_2,DestR_3,DestR_4,R2res2,R3res2);
	
	logic Wmem1,Rmem1,Wreg1,Jmp1,Wpc1;
	logic [2:0] ALUIns1;
	logic [31:0] R2res3,R3res3;
	logic [3:0] R2_2,R3_2,DestR_2;
	PipelineMem (clk,rst|JumpEn,Wmem,Rmem,Wreg,Jmp,Wpc,ALUIns,R2res2,R3res2,R2,R3,DestR,
					Wmem1,Rmem1,Wreg1,Jmp1,Wpc1,ALUIns1,R2res3,R3res3,DestR_2);
	
	logic [31:0] R2res4,R3res4;
	ForwUnitALU (R2res3,R3res3,R2_2,R3_2,DestR_2,DestR_3,DestR_4,R2res4,R3res4);
	
	logic Nflag,Zflag,Oflag,Cflag;
	logic [31:0]ALURes;
	UnidadLogicoAritmetica #(32)ALU(R2res4,R3res4,ALUIns1,ALURes,Nflag,Zflag,Oflag,Cflag);
	logic JumpEn;
	condUnit CondUnit(Jmp1,Wpc1,Zflag,JumpEn);
	
	logic Wreg2,Rmem2,Wmem2;
	logic [31:0]ALURes1;
	logic [3:0]DestR_3;
	PipelineEx(Wmem1,Rmem1,Wreg1,ALURes,R3res4,DestR_2,Wreg2,Rmem2,Wmem2,ALURes1,R3res5,DestR_3);
	
	logic [31:0]CS;
	logic [7:0] GPIO;
	logic GPIOEn;
	MemoryController ChipSel(clk,Wmem2,ALURes1,R3res5,CS,GPIO,GPIOEn);
	logic [31:0]Res;
	Mux2 #(32)MemMux(ALURes1,CS,Rmem2,Res);
	logic Wreg3;
	logic [31:0]Res1;
	logic [3:0] DestR_4;
	PipelineWB (Wreg2,Res,DestR_3,Wreg3,Res1,DestR_4);
	
endmodule