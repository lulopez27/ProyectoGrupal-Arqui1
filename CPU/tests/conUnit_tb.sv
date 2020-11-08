module conUnit_tb();
	logic [1:0]jmpF;
	logic wpci,Nflag,Zflag,Vflag,Cflag, jmpR;
	condUnit condtst(jmpF, wpci,Nflag,Zflag,Vflag,Cflag,jmpR);
	initial begin
	jmpF = 	2'b00;
	wpci = 1'b1;
	Nflag = 1'b0;
	Zflag = 1'b0;
	Vflag = 1'b0;
	Cflag = 1'b0;
	end
endmodule