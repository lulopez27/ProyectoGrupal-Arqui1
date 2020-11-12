module ControlUnitDeco(input [4:0] in, output logic [2:0] ALUControl);
	always @(in) begin
		case(in)
			5'b11000 : ALUControl = 3'b000; //ADD
			5'b00001 : ALUControl = 3'b000; //JMP
			5'b00111 : ALUControl = 3'b000; //JEQ
			5'b00011 : ALUControl = 3'b000; //JGT
			5'b11010 : ALUControl = 3'b001; //SUB
			5'b10110 : ALUControl = 3'b001; //CMPR
			5'b10111 : ALUControl = 3'b001; //CMPI
			5'b11110 : ALUControl = 3'b010; //MUL
			5'b11100 : ALUControl = 3'b011; //MOD
			5'b11001 : ALUControl = 3'b100; //LSR
			5'b10100 : ALUControl = 3'b111; //MOVR
			5'b10101 : ALUControl = 3'b101; //MOVI			
			default  : ALUControl = 3'b111; //NONE
		endcase
	end
endmodule 