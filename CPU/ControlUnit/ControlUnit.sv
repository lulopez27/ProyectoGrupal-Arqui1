module ControlUnit(input[1:0] op, input[1:0] inst, input immin, //input clk, rst, 
						output wmem, rmem, wreg, wpc, jmp, output[2:0] ALUins, output[1:0] ExtndSel);
	logic[4:0] ALUinst;
	assign ALUinst = {op, inst, immin};
	logic[3:0] ExtSel;
	assign ExtSel = {op, inst};
	assign immout = immin;
	assign wmem = op[1]&~op[0]&~inst[1]&~inst[0]&~immin;
	assign rmem = op[1]&~op[0]&~inst[1]&inst[0]&~immin;
	assign wreg = (op[1]&op[0])|(op[1]&~op[0]&~(inst[1]&inst[0]));
	assign jmp = ~op[1]&~op[0];
	assign wpc = ~inst[1]&~inst[0];
	ControlUnitDeco ALUDeco(ALUinst, ALUins);
	ExtendDeco ExtDeco(ExtSel, ExtndSel);
	
endmodule 