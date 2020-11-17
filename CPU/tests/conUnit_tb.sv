module conUnit_tb();
	logic [1:0]jmpF;
	logic wpci,Nflag,Zflag,Vflag,Cflag, jmpR,clk,rst,conEn;
	condUnit condtst(clk,rst,jmpF, wpci,conEn,Nflag,Zflag,Vflag,Cflag,jmpR);
	initial begin
	Nflag = 1'b0;
	Zflag = 1'b0;
	Vflag = 1'b0;
	Cflag = 1'b0;
	wpci = 1'b1;
	conEn = 1'b1;
	clk = 1'b0;
	rst = 1'b0;
	#2
	rst = 1'b1;
	assert( jmpR=== 1'b0) $display("Reset check"); else $display("Reset fail");
	#2
	clk = 1'b1;
	rst = 1'b0;
	#2
	clk = 1'b0;
	#2
	clk = 1'b1;
	jmpF = 	2'b00;
	#2
	clk = 1'b0;
	assert( jmpR=== 1'b1) $display("Jmp check"); else $display("Jmp fail");
	#2
	clk = 1'b1;
	#2
	jmpF = 	2'b11;
	Nflag = 1'b0;
	Zflag = 1'b1;
	Vflag = 1'b0;
	Cflag = 1'b0;
	clk =  1'b0;
	assert( jmpR=== 1'b1) $display("Jeq check"); else $display("Jeq fail");
	#2
	clk =  1'b1;
	#2
	jmpF = 	2'b01;
	Nflag = 1'b0;
	Zflag = 1'b0;
	Vflag = 1'b0;
	Cflag = 1'b0;
	clk =  1'b0;
	assert( jmpR=== 1'b1) $display("Jgt check"); else $display("Jgt fail");	
	#2
	clk = 1'b1;
	jmpF = 	2'b01;
	Nflag = 1'b1;
	Zflag = 1'b0;
	Vflag = 1'b0;
	Cflag = 1'b0;
	#2
	clk = 1'b0;
	#2
	clk = 1'b1;
	#2
	clk =  1'b0;
	assert( jmpR=== 1'b0) $display("Jgt fail check"); else $display("Jgt fail fail");	
	end
endmodule

//do ProyectoGrupal_run_msim_rtl_verilog.do
//vsim work.conUnit_tb
//add wave -position end sim:/conUnit_tb/*
//run -all