module condUnit(input [1:0] jmpF, input wpci,Nflag,Zflag,Vflag,Cflag, output logic jmpR);
	logic jmp;
	always begin
		if(jmpF == 2'b00)
			jmp = 1'b1;
		else if((jmpF == 2'b11)&&(Zflag == 1'b1))
			jmp = 1'b1;
		else if((jmpF == 2'b11)&&(~Zflag&~(Nflag^Vflag)))
			jmp = 1'b1;
		else
			jmp = 1'b0;
		end
	assign jmpR = jmp&wpci;
endmodule