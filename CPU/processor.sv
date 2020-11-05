module processor(input clk, rst);
	logic [1:0] op, inst;
	logic immediatei;
	logic immediateo, wmem, rmem, wreg;
	logic [2:0] ALUins;
	logic [1:0] ExtndSel
	ControlUnit ctrlunit(op, inst, immin,
						immout, wmem, rmem, wreg,ALUins,ExtndSel);
endmodule