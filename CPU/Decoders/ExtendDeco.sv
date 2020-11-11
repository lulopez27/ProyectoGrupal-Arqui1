module ExtendDeco(input [4:0] in, output logic [1:0] ALUControl);
	always @(in) begin
		case(in)
			5'b10010 : ALUControl = 2'b01; //19
			5'b10100 : ALUControl = 2'b01; //19
			5'b11001 : ALUControl = 2'b01; //19
			5'b10111 : ALUControl = 2'b01; //19
			5'b01000 : ALUControl = 2'b01; //19
			5'b10101 : ALUControl = 2'b10; //23
			5'b00001 : ALUControl = 2'b11; //27
			5'b00111 : ALUControl = 2'b11; //27
			5'b00011 : ALUControl = 2'b11; //27
			default : ALUControl = 2'b00; //15
		endcase
	end
endmodule 