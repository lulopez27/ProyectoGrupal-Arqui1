module pipeline_tb();
	logic clk, rst;
	logic Wmem,Rmem,Wreg,Wpc;
	logic Wmem1,Rmem1,Wreg1,Wpc1;
	logic Wreg2,Rmem2,Wmem2;
	logic [31:0]ALURes;
	logic [3:0]DestR_3;
	logic [31:0]Res;
	logic [31:0]Res1;
	logic Wreg3;
	logic [3:0] DestR_4;
	logic[3:0] R2,R3,DestR;
	logic [1:0] JmpF;
	logic [2:0]ALUIns;
	logic [31:0]R3res;
	logic [31:0]R2res;
	logic [1:0]JmpF1;
	logic [2:0] ALUIns1;
	logic [31:0] R2res3,R3res3;
	logic [3:0] R2_2,R3_2,DestR_2;
	logic [31:0]R3res4;
	logic [31:0]ALURes1,R3res5;
	PipelineMem pipeMem(clk,rst ,Wmem,Rmem,Wreg,Wpc,JmpF,ALUIns,R2res,R3res,R2,R3,DestR,
	
						Wmem1,Rmem1,Wreg1,Wpc1,JmpF1,ALUIns1,R2res3,R3res3,R2_2,R3_2,DestR_2);
	PipelineEx pipeEx(clk,rst,Wmem1,Rmem1,Wreg1,ALURes,R3res4,DestR_2,Wreg2,Rmem2,Wmem2,ALURes1,R3res5,DestR_3);
	
	PipelineWB pipeWb(clk,rst,Wreg2,Res,DestR_3,Wreg3,Res1,DestR_4);
	initial begin
		Wmem =  1'b1;
		Rmem = 1'b1;
		Wreg = 1'b1;
		Wpc = 1'b1;
		JmpF =  2'b11;
		ALURes = 32'd1;
		 R3res4= 32'd1;
		Res= 32'd1;
		ALUIns =  3'b111;
		R2res = 32'd18;
		R3res =  32'd4;
		R2 =  4'd5;
		R3 = 6'd5;
		DestR =  4'd7;
		clk = 1'b1;
		rst = 1'b0;
		#1
		rst = 1'b1;
		#1
		rst = 1'b0;
	end
	always begin
		#5
		clk = ~clk;
	end
endmodule 

//add wave -position end  sim:/pipeline_tb/clk
//add wave -position end  sim:/pipeline_tb/rst
//add wave -position end  sim:/pipeline_tb/Wmem
//add wave -position end  sim:/pipeline_tb/Rmem
//add wave -position end  sim:/pipeline_tb/Wreg
//add wave -position end  sim:/pipeline_tb/Wpc
//add wave -position end  sim:/pipeline_tb/Wmem1
//add wave -position end  sim:/pipeline_tb/Rmem1
//add wave -position end  sim:/pipeline_tb/Wreg1
//add wave -position end  sim:/pipeline_tb/Wpc1
//add wave -position end  sim:/pipeline_tb/Wreg2
//add wave -position end  sim:/pipeline_tb/Rmem2
//add wave -position end  sim:/pipeline_tb/Wmem2
//add wave -position end  sim:/pipeline_tb/ALURes
//add wave -position end  sim:/pipeline_tb/DestR_3
//add wave -position end  sim:/pipeline_tb/Res
//add wave -position end  sim:/pipeline_tb/Res1
//add wave -position end  sim:/pipeline_tb/Wreg3
//add wave -position end  sim:/pipeline_tb/DestR_4
//add wave -position end  sim:/pipeline_tb/R2
//add wave -position end  sim:/pipeline_tb/R3
//add wave -position end  sim:/pipeline_tb/DestR
//add wave -position end  sim:/pipeline_tb/JmpF
//add wave -position end  sim:/pipeline_tb/ALUIns
//add wave -position end  sim:/pipeline_tb/R3res
//add wave -position end  sim:/pipeline_tb/R2res
//add wave -position end  sim:/pipeline_tb/JmpF1
//add wave -position end  sim:/pipeline_tb/ALUIns1
//add wave -position end  sim:/pipeline_tb/R2res3
//add wave -position end  sim:/pipeline_tb/R3res3
//add wave -position end  sim:/pipeline_tb/R2_2
//add wave -position end  sim:/pipeline_tb/R3_2
//add wave -position end  sim:/pipeline_tb/DestR_2
//add wave -position end  sim:/pipeline_tb/R2res4
//add wave -position end  sim:/pipeline_tb/R3res4
//add wave -position end  sim:/pipeline_tb/ALURes1
//add wave -position end  sim:/pipeline_tb/R3res5
//add wave -position end  sim:/pipeline_tb/ALUIns
//add wave -position end  sim:/pipeline_tb/ALUIns1
//add wave -position end  sim:/pipeline_tb/ALURes
//add wave -position end  sim:/pipeline_tb/ALURes1
//add wave -position end  sim:/pipeline_tb/clk
//add wave -position end  sim:/pipeline_tb/DestR
//add wave -position end  sim:/pipeline_tb/DestR_2
//add wave -position end  sim:/pipeline_tb/DestR_3
//add wave -position end  sim:/pipeline_tb/DestR_4
//add wave -position end  sim:/pipeline_tb/JmpF
//add wave -position end  sim:/pipeline_tb/JmpF1
//add wave -position end  sim:/pipeline_tb/R2
//add wave -position end  sim:/pipeline_tb/R2_2
//add wave -position end  sim:/pipeline_tb/R2res
//add wave -position end  sim:/pipeline_tb/R2res3
//add wave -position end  sim:/pipeline_tb/R2res4
//add wave -position end  sim:/pipeline_tb/R3
//add wave -position end  sim:/pipeline_tb/R3_2
//add wave -position end  sim:/pipeline_tb/R3res
//add wave -position end  sim:/pipeline_tb/R3res3
//add wave -position end  sim:/pipeline_tb/R3res4
//add wave -position end  sim:/pipeline_tb/R3res5
//add wave -position end  sim:/pipeline_tb/Res
//add wave -position end  sim:/pipeline_tb/Res1
//add wave -position end  sim:/pipeline_tb/Rmem
//add wave -position end  sim:/pipeline_tb/Rmem1
//add wave -position end  sim:/pipeline_tb/Rmem2
//add wave -position end  sim:/pipeline_tb/rst
//add wave -position end  sim:/pipeline_tb/Wmem
//add wave -position end  sim:/pipeline_tb/Wmem1
//add wave -position end  sim:/pipeline_tb/Wmem2
//add wave -position end  sim:/pipeline_tb/Wpc
//add wave -position end  sim:/pipeline_tb/Wpc1
//add wave -position end  sim:/pipeline_tb/Wreg
//add wave -position end  sim:/pipeline_tb/Wreg1
//add wave -position end  sim:/pipeline_tb/Wreg2
//add wave -position end  sim:/pipeline_tb/Wreg3