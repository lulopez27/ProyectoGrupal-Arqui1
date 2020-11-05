module ExtendDeco(input [3:0] in, output logic [1:0] ALUControl);
	always @(in) begin
		case(in)
			4'b1011 : ALUControl = 2'b01; //19
			4'b1100 : ALUControl = 2'b01; //19
			4'b1010 : ALUControl = 2'b10; //23
			4'b0000 : ALUControl = 2'b11; //28
			4'b0011 : ALUControl = 2'b11; //28
			default : ALUControl = 2'b00; //NONE
		endcase
	end
endmodule 