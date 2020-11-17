module ctrlUnit_tb();
logic[1:0] op, inst;
logic immin;
logic wmem, rmem, wreg, wpc,CondEn;
logic [1:0] jmpF;
logic [2:0] Aluins;
logic [1:0] ExtndSel;
ControlUnit ctrlunit(op,inst, immin,
						wmem, rmem, wreg, wpc,CondEn, jmpF, Aluins, ExtndSel);
	initial begin
	op = 2'b10;
	inst = 2'b00;
	immin = 1'b0;
	#5
	assert( Aluins=== 3'b111) $display("Str check"); else $display("Str fail");
	#5
	op = 2'b10;
	inst = 2'b10;
	immin = 1'b1;
	#5
	assert( Aluins=== 3'b101) $display("MOVI check"); else $display("MOVI  fail");
	#5
	op = 2'b11;
	inst = 2'b00;
	immin = 1'b1;
	#5
	assert( Aluins=== 3'b100) $display("DDR check"); else $display("DDR fail");
	#5
	op = 2'b00;
	inst = 2'b00;
	immin = 1'b1;
	#5
	assert( Aluins=== 3'b000) $display("Jmp check"); else $display("Jmp fail");
	end
endmodule

//do ProyectoGrupal_run_msim_rtl_verilog.do
//vsim work.frwrdUnit_tb
//add wave -position end sim:/frwrdUnit_tb/*
//run -all