module processor(input clk, rst, output logic[31:0] GPIOaddr, output logic [7:0] GPIO,output logic GPIOEn);
	logic [31:0]next_pc;
	logic[31:0] pc_p1;
	logic [31:0]ALURes;
	logic [3:0]DestR_3;
	logic [31:0]Res;
	logic [31:0]Res1;
	logic Wreg3;
	logic JumpEn;
	logic [3:0] DestR_4;
	Mux2 #(32)PC_Mux (pc_p1,ALURes,JumpEn,next_pc);
	logic[31:0] curr_pc;
	FlipFlop #(32) PC(clk,rst,next_pc,curr_pc);
	logic none;
	Suma #(32)PC_1(curr_pc,32'h1,pc_p1,none);
	logic [31:0] AcIns;
	InstructionMemory InsMem(curr_pc,AcIns);
	logic [31:0] instruction, curr_pc1;
	PipelineFetch pipelineFetch(clk,rst|JumpEn,AcIns,curr_pc,instruction, curr_pc1);
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
	logic Wmem,Rmem,Wreg,Wpc,CondEn;
	logic [1:0] JmpF;
	logic [2:0]ALUIns;
	logic [1:0]ExtndSel;
	ControlUnit  CtrlUnit(num_op,inst,immF,Wmem,Rmem,Wreg,Wpc,CondEn,JmpF,ALUIns,ExtndSel);
	logic [31:0]R2r,R3r;
	RegisterFile RegFile(clk,Wreg3,R2,R3,DestR_4,Res1,R2r,R3r);
	logic [31:0]ExtendRes;
	Extender extnd(immediate,ExtndSel,ExtendRes);
	logic [31:0]R3res;
	Mux2 #(32)Extend_Mux(R3r,ExtendRes,immF,R3res);
	logic [31:0]R2res;
	Mux2 #(32)PCReg_Mux(R2r,curr_pc1,Wpc,R2res);
	
	//logic [31:0]R2res2,R3res2;
	//FowardUnitReg FwrdUnitReg(R2res,R3res,R2,R3,DestR_2,ALURes,DestR_3,Res,DestR_4,Res1,R2res2,R3res2);
	
	logic Wmem1,Rmem1,Wreg1,Wpc1,CondEn1,immF1;
	logic [1:0]JmpF1,ExtndSel1;
	logic [2:0] ALUIns1;
	logic [31:0] R2res3,R3res3;
	logic [3:0] R2_2,R3_2,DestR_2;
	PipelineMem pipeMem(clk,rst,Wmem,Rmem,Wreg,Wpc,CondEn,immF,JmpF,ALUIns,R2res,R3res,R2,R3,DestR,ExtndSel,
					Wmem1,Rmem1,Wreg1,Wpc1,CondEn1,immF1,JmpF1,ALUIns1,R2res3,R3res3,R2_2,R3_2,DestR_2,ExtndSel1);
	
	logic [31:0] R2res4,R3res4;
	ForwardUnitALU  FwrdUnitALU(R2res3,R3res3,R2_2,R3_2,ExtndSel1,immF1,DestR_3,Res,DestR_4,Res1,R2res4,R3res4);
	
	logic Nflag,Zflag,Vflag,Cflag;
	
	UnidadLogicoAritmetica #(32)ALU(R2res4,R3res4,ALUIns1,ALURes,Nflag,Zflag,Vflag,Cflag);

	condUnit CondUnit(clk,rst,JmpF1,Wpc1,CondEn1,Nflag,Zflag,Vflag,Cflag,JumpEn);
	
	logic Wreg2,Rmem2,Wmem2;
	logic [31:0]ALURes1,R3res5;
	
	PipelineEx pipeEx(clk,rst,Wmem1,Rmem1,Wreg1,ALURes,R3res4,DestR_2,Wreg2,Rmem2,Wmem2,ALURes1,R3res5,DestR_3);
	
	logic [31:0]CS;
	MemoryController ChipSel(clk,Wmem2,ALURes1,R3res5,CS,GPIOaddr,GPIO,GPIOEn);
	Mux2 #(32)MemMux(ALURes1,CS,Rmem2,Res);
	PipelineWB pipeWb(clk,rst,Wreg2,Res,DestR_3,Wreg3,Res1,DestR_4);
	
endmodule