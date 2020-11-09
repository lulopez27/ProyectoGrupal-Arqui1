module condUnit(input clk, rst,input [1:0] jmpF, input wpci,CondEn1,Nflag,Zflag,Vflag,Cflag, output logic jmpR);
	logic jmp;
	logic [3:0] flags,flagso;
	assign flags = Nflag,Zflag,Vflag,Cflag;
	always_comb begin
		if(jmpF == 2'b00)
			jmp = 1'b1;
		else if((jmpF == 2'b11)&&(flagso[2] == 1'b1))
			jmp = 1'b1;
		else if((jmpF == 2'b01)&&(~flagso[2]&~(flagso[3]^flagso[1])))
			jmp = 1'b1;
		else
			jmp = 1'b0;
		end
	assign jmpR = jmp&wpci;
	FLipFlop #(4)flipiflopi(~clk,rst,flags,flagso)
endmodule