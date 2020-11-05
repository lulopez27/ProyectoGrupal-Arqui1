module unidad_logico_aritmetica_test();

	logic[31:0] num1, num2, result;
	logic[1:0] ALUControl;
	logic fNegativo, fCero, fOverflow, fCarry;

	unidad_logico_aritmetica #(32) DUT(num1, num2, ALUControl, result, fNegativo, fCero, fOverflow, fCarry);
	
	initial begin
		
		num1 = 32'd45;
		num2 = 32'd30;
		ALUControl = 2'b00;
		
		#10;
		
		ALUControl = 2'b01;
		
		#10;
		
		ALUControl = 2'b10;
		
		#10;
		
		num2 = 32'd7;
		ALUControl = 2'b11;
	
	end

endmodule 