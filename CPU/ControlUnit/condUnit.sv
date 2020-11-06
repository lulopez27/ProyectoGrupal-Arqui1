module condUnit(input jmpi, wpci, ALUFZ, output logic jmp);
	assign jmp = (wpci|ALUFZ)&jmpi;
endmodule