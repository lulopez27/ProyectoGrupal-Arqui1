module ctrlunit_tb();
	logic [1:0] op, inst;
	logic immediatei;
<<<<<<< HEAD
	logic immediateo, wmem, rmem, wreg,wpc,jmp;
=======
	logic immediateo, wmem, rmem, wreg;
>>>>>>> main
	logic [2:0] ALUins;
	logic [1:0] ExtndSel;
	logic [8:0]ans;
	assign ans = {immediateo,wmem,rmem,wreg,ALUins,ExtndSel};
	ControlUnit ctrlunit(op, inst, immediatei,
<<<<<<< HEAD
					immediateo,wmem,rmem,wreg,wpc,jmp,ALUins,ExtndSel);
=======
					immediateo, wmem, rmem, wreg,ALUins,ExtndSel);
>>>>>>> main
	
	initial begin
	op =2'b10; //GDR
	inst =2'b00;
	immediatei=1'b0;
	#5
	 op =2'b10; //CAR
	 inst =2'b01;
	 immediatei=1'b0;
	#5
	 op =2'b10; //MOVR
	 inst =2'b10;
	 immediatei=1'b0;
	#5
	 op =2'b10; //MOVI
	 inst =2'b10;
	 immediatei=1'b1;
	#5
	 op =2'b11; //SUM
	 inst =2'b00;
	 immediatei=1'b0;
	#5
	 op =2'b11; //RES
	 inst =2'b01;
	 immediatei=1'b0;
	#5
	 op =2'b11; //MOD
	 inst =2'b10;
	 immediatei=1'b0;
	#5
	 op =2'b11; //MUL
	 inst =2'b11;
	 immediatei=1'b0;
	#5
	 op =2'b11; //DDR
	 inst =2'b00;
	 immediatei=1'b1;
	#5
	 op =2'b10; //CMPR
	 inst =2'b11;
	 immediatei=1'b0;
	#5
	 op =2'b10; //CMPI
	 inst =2'b11;
	 immediatei=1'b1;
	#5
	 op =2'b00; //SAL
	 inst =2'b00;
	 immediatei=1'b1;
	#5
	 op =2'b00; //SIG
	 inst =2'b11;
	 immediatei=1'b1;
	#5
	 op =2'b01; //ESP
	 inst =2'b00;
	 immediatei=1'b0;
	end
endmodule