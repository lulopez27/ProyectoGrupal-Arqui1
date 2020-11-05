module processor_tb_ctrunit();
	logic [1:0] op, inst;
	logic immediatei;
	logic immediateo, wmem, rmem, wreg;
	logic [2:0] ALUins;
	logic [1:0] ExtndSel
	ControlUnit ctrlunit(op, inst, immin,
						immout, wmem, rmem, wreg,ALUins,ExtndSel);
	initial begin
	clk=0;
	rst=0;
	#1
	rst=1;
	#1
	rst=0;
	end
	always
	#5 clk=!clk;
	
	begin
	assign op =s;
	assign inst =;
	assign immediatei=;
	#5
	assign op =;
	assign inst =;
	assign immediatei=;
	#5
	assign op =;
	assign inst =;
	assign immediatei=;
	#5
	assign op =;
	assign inst =;
	assign immediatei=;
	#5
	assign op =;
	assign inst =;
	assign immediatei=;
	#5
	assign op =;
	assign inst =;
	assign immediatei=;
	#5
	assign op =;
	assign inst =;
	assign immediatei=;
	#5
	assign op =;
	assign inst =;
	assign immediatei=;
	#5
	assign op =;
	assign inst =;
	assign immediatei=;
	#5
	assign op =;
	assign inst =;
	assign immediatei=;
	#5
	assign op =;
	assign inst =;
	assign immediatei=;
	#5
	assign op =;
	assign inst =;
	assign immediatei=;
	#5
	assign op =;
	assign inst =;
	assign immediatei=;
	#5
	end
endmodule