module UnidadLogicoAritmetica #(parameter N = 32) (input logic [N-1:0] A, B,
																	input logic [2:0] Sel,
																   output logic [N-1:0] C,
																   output logic banNegativo,
																   output logic banCero,
																   output logic banDesborde,
																   output logic banAcarreo);

			
	logic [N-1:0] CSuma, CResta, CMultiplicacion, CModulo, CDesplazamientoDerecha;
	logic CoutSuma, CoutResta, CoutMultiplicacion;
			
	Suma #(N) Sum(A, B, CSuma, CoutSuma);
	Resta #(N) Res(A, B, CResta, CoutResta);
	Multiplicacion #(N) Mul(A, B, CMultiplicacion, CoutMultiplicacion);
	Modulo #(N) Mod(A, B, CModulo);
	DesplazamientoDerecha #(N) DespDer(A, B, CDesplazamientoDerecha);
	
	Mux8ALU #(N) Mux8(CSuma, CResta, CMultiplicacion, CModulo, CDesplazamientoDerecha, B, A, Sel, C);
			
	Negativo BanNeg(C[N-1], Sel[2], banNegativo);
	Cero #(N) BanCer(C, Sel[2], banCero);
	Desborde BanOve(A[N-1], B[N-1], C[N-1], Sel, banDesborde);
	Acarreo BanCar(CoutSuma, CoutResta, CoutMultiplicacion, Sel, banAcarreo);
					
endmodule 