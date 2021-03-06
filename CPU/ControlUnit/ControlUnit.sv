module ControlUnit(input[1:0] op, input[1:0] inst, input immin,
						output wmem, rmem, wreg, wpc,CondEn,output [1:0] jmpF, output[2:0] ALUins, output[1:0] ExtndSel);
	logic[4:0] ALUinst;
	assign ALUinst = {op, inst, immin};
	assign wmem = op[1]&~op[0]&~inst[1]&~inst[0]&~immin;
	assign rmem = op[1]&~op[0]&~inst[1]&inst[0]&~immin;
	assign wreg = (op[1]&op[0])|(op[1]&~op[0]&~(inst[1]&inst[0]));
	assign jmpF[0] = inst[0];
	assign jmpF[1] = inst[1];
	assign wpc = ~op[1]&~op[0]&immin;
	assign CondEn = op[1]&~op[0]&inst[1]&inst[0];
	ControlUnitDeco ALUDeco(ALUinst, ALUins);
	ExtendDeco ExtDeco(ALUinst, ExtndSel);
	
endmodule 