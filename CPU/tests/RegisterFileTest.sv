module RegisterFileTest();

	logic clk, we3;
	logic[3:0] ra1, ra2, wa3;
	logic[31:0] wd3, r0, rd1, rd2;

	RegisterFile DUT(clk, we3, ra1, ra2, wa3, wd3, r0, rd1, rd2);
	
	initial begin
		
		clk = 1'b0;
		we3 = 1'b0;
		ra1 = 4'b0;
		ra2 = 4'b0;
		wa3 = 4'b0;
		wd3 = 32'b0;
		r0 = 32'b0;
		
		#10;
		
		we3 = 1'b1;
		wa3 = 4'd1;
		wd3 = 32'd128;
		clk = 1'b1;
		
		#10;
		
		we3 = 1'b0;
		clk = 1'b0;
		
		#10;
		
		we3 = 1'b1;
		wa3 = 4'd2;
		wd3 = 32'd64;
		clk = 1'b1;
		
		#10;
		
		clk = 1'b0;
		we3 = 1'b0;
		wd3 = 32'b0;
		wa3 = 4'b0;
		
		#10;
		
		ra1 = 4'd1;
		ra2 = 4'd2;
		r0 = 32'd1000;
		
		#10;
		
		ra1 = 4'd0;
		ra2 = 4'd0;
		
		#10;
	
	end

endmodule 