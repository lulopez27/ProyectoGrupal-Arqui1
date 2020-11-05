module Desborde (input logic MSBA, MSBB, MSBC,
					  input logic [2:0] Sel, 
					  output logic Res);


	logic Operacion;
	logic SignoOperandos; 
	logic CambioSigno;

	assign Operacion = Sel[2:1] == 2'b00; //verifica que el codigo de la operacion sea de suma o resta y guarda el resultado como un bool
	assign SignoOperandos = !(MSBA ^ Sel[0] ^ MSBB); // verifica si ambos signos son iguales 
	assign CambioSigno = (MSBA ^ MSBC); // verifica que el signo no cambiara en el resultado
	assign Res = Operacion & SignoOperandos & CambioSigno;

endmodule 