; Etiquetas de memoria, donde se inician los arrays del algoritmo

EII    EQU    0x20000000 ;Etiqueta de inicio de la imagen
EFD    EQU    0x2000001C ;Etiqueta de inicio de la frecuencia de distribución
EFA    EQU    0x2000003C ;Etiqueta de inicio de la frecuencia acumulada 
EDUF   EQU    0x2000005C ;Etiqueta de inicio de la distribución uniforme de la frecuencia acumulada
EFA2   EQU    0x2000007C ;Etiqueta de la frecuencia acumulada parte 2 (acumulada de la frecuencia distribuida)
EBBM   EQU    0x2000009C ;Etiqueta de inicio del bloque borrador del mapeo
ERM    EQU    0x200000BC ;Etiqueta de inicio del resultado del mapeo
EIF    EQU    0x200000DC ;Etiqueta de inicio de la imagen final ecualizada



; Código del programa principal
; Ecualizador V1, se trabaja con imágenes de 5x5, donde cada pixel es de 3 bits (rango de 0-7)


		AREA Main, CODE, READONLY
		ENTRY
		EXPORT	__main
		
__main


; Etapa 0, se carga la imagen en memoria


		MOV     R1,#0
		LDR     R2,=EII
		; Pixel 1
		MOV     R3,#4
		STR     R3,[R2,R1]
		; Pixel 2
		ADD     R1,R1,#1
		STR     R3, [R2,R1]
		; Pixel 3
	    ADD     R1,R1,#1
		STR     R3, [R2,R1]
		; Pixel 4
		ADD     R1,R1,#1
		STR     R3, [R2,R1]
		; Pixel 5
		ADD     R1,R1,#1
		STR     R3, [R2,R1]
		; Pixel 6
		MOV     R3,#3
	    ADD     R1,R1,#1
		STR     R3, [R2,R1]
		; Pixel 7
		MOV     R3,#4
	    ADD     R1,R1,#1
		STR     R3, [R2,R1]
		; Pixel 8
		MOV     R3,#5
	    ADD     R1,R1,#1
		STR     R3, [R2,R1]
		; Pixel 9
		MOV     R3,#4
	    ADD     R1,R1,#1
		STR     R3, [R2,R1]
		; Pixel 10
		MOV     R3,#3
	    ADD     R1,R1,#1
		STR     R3, [R2,R1]
		; Pixel 11
	    ADD     R1,R1,#1
		STR     R3, [R2,R1]
		; Pixel 12
		MOV     R3,#5
	    ADD     R1,R1,#1
		STR     R3, [R2,R1]
		; Pixel 13
	    ADD     R1,R1,#1
		STR     R3, [R2,R1]
		; Pixel 14
		ADD     R1,R1,#1
		STR     R3, [R2,R1]
		; Pixel 15
		MOV     R3,#3
		ADD     R1,R1,#1
		STR     R3, [R2,R1]
		; Pixel 16
		ADD     R1,R1,#1
		STR     R3, [R2,R1]
		; Pixel 17
		MOV     R3,#4
		ADD     R1,R1,#1
		STR     R3, [R2,R1]
		; Pixel 18
		MOV     R3,#5
		ADD     R1,R1,#1
		STR     R3, [R2,R1]
		; Pixel 19
		MOV     R3,#4
		ADD     R1,R1,#1
		STR     R3, [R2,R1]
		; Pixel 20
		MOV     R3,#3
		ADD     R1,R1,#1
		STR     R3, [R2,R1]
		; Pixel 21
		MOV     R3,#4
	    ADD     R1,R1,#1
		STR     R3, [R2,R1]
		; Pixel 22
        ADD     R1,R1,#1
		STR     R3, [R2,R1]
		; Pixel 23
		ADD     R1,R1,#1
		STR     R3, [R2,R1]
		; Pixel 24
		ADD     R1,R1,#1
		STR     R3, [R2,R1]
		; Pixel 25
		ADD     R1,R1,#1
		STR     R3, [R2,R1]
		
; Etapa 1: Se obtiene la frecuencia de distribución de la imagen

        LDR     R1,=EII
        LDR     R2,=EFD
		MOV     R3,#0   ;Contador de la imagen
		MOV     R4,#0   ;Contador donde se guarda el array de la frecuencia
		MOV     R5,#0   ;Contador de los valores del rango 0-7
		MOV     R7,#0   ;Contador de la frecuencia

;CFD: Ciclo de Frecuencia de Distribución

CFD     CMP     R5,#8
        BEQ     IE2   ; IE2: Inicio de la etapa 2
		B       CVPR
FVP		MOV     R3,#0
        STR     R7,[R2,R4]
		MOV     R7,#0
		ADD     R4,R4,#4
		ADD     R5,R5,#1
		B       CFD

;CVPR: Ciclo de Verificar el pixel actual con el valor del rango actual

CVPR   CMP      R3,#25
       BEQ      FVP    ;FVP: Fin de verificar pixeles
	   LDRB     R6,[R1,R3]
	   CMP      R6,R5
	   BEQ      SUM1
FS1	   ADD      R3,R3,#1
	   B        CVPR
	   
	   
SUM1   ADD      R7,R7,#1
       B        FS1     ;FS1: Fin de sumar 1
		
; Etapa 2: Se obtiene la frecuencia acumulada

IE2    LDR      R1,=EFA
       MOV      R3,#0 ; Contador del bloque de frecuencia de distribución
	   MOV      R4,#0 ; Contador del bloque de frecuencia acumulada
	   LDR      R5,[R2,R3]
	   STR      R5,[R1,R4]
	   ADD      R3,R3,#4

; CDSF: Ciclo de sumar frecuencias

CDSF   CMP      R3,#32
       BEQ      IE3
	   LDR      R5,[R2,R3]
	   LDR      R6,[R1,R4]
	   ADD      R7,R5,R6
	   ADD      R4,R4,#4
	   STR      R7,[R1,R4]
	   ADD      R3,R3,#4
	   B        CDSF
       	   
       
; Etapa 3: Se distribuye uniformemente la frecuencia acumulada
      
IE3    LDR      R3,=EDUF
       LDR      R4,[R1,#28]
	   MOV      R5,#8
	  
	   ;Se calcula el módulo del valor máximo de Cuf entre el valor máximo del rango
	   UDIV     R6,R4,R5
	   MUL      R7,R6,R5
	   SUB      R8,R4,R7
	  
	   ;Se calcula la parte entera de el valor máximo de Cuf entre el valor máximo del rango(N = 8 = 2**3)
       ASR      R9,R4,#3

       ;Se utiliza el R6 como contador
	   MOV      R6,#0
	  
	   ;Se toman dos caminos dependiendo del módulo
	   CMP      R8,#0
	   BEQ      CM0   ;CM0: Ciclo cuando el módulo es cero
	   B        CMD0  ;CMDO: Ciclo cuando el módulo es diferente de cero
	  
	  
CM0    CMP      R6,#32
       BEQ      IE4
	   STR      R9,[R3,R6]
	   ADD      R6,R6,#4
	   B        CM0
	  
CMD0   MOV      R7,#7
       MUL      R10,R9,R7
	   SUB      R11,R4,R10
	   STR      R11,[R3,R6]
	   ADD      R6,R6,#4

CMD02  CMP      R6,#32
       BEQ      IE4
	   STR      R9,[R3,R6]
	   ADD      R6,R6,#4
	   B        CMD02

; Etapa 4: Se obtiene la frecuencia acumulada de la frecuencia distribuida

IE4    LDR      R4,=EFA2
       MOV      R5,#0 ; Contador del bloque de frecuencia distribuida
	   MOV      R6,#0 ; Contador del bloque de frecuencia acumulada parte 2
	   LDR      R7,[R3,R5]
	   STR      R7,[R4,R6]
	   ADD      R5,R5,#4

; CDSF2: Ciclo de sumar frecuencias2

CDSF2  CMP      R5,#32
       BEQ      IE5
	   LDR      R7,[R3,R5]
	   LDR      R8,[R4,R6]
	   ADD      R9,R7,R8
	   ADD      R6,R6,#4
	   STR      R9,[R4,R6]
	   ADD      R5,R5,#4
	   B        CDSF2


; Etapa 5: Se obtiene el array del mapeo

IE5    LDR      R1,=EFA
	   LDR      R2,=EFA2
	   LDR      R3,=EBBM
	   LDR      R4,=ERM
	   MOV      R5,#0    ;Contador del CuF y del I prima del mapeo
	   MOV      R6,#0    ;Contador del CuFeq
	   MOV      R7,#0    ;Contador de la posición final
	   MOV      R8,#0    ;Contador del bloque borrador del mapeo
	   
	   
	   
;CPM: Ciclo principal del mapeo

CPM    CMP      R5,#32
	   BEQ      IE6
	   LDR      R9,[R1,R5]
	   B        CCC  
FCPM   STR      R7,[R4,R5]
       ADD      R5,R5,#4
	   MOV      R6,#0
	   MOV      R7,#0
	   MOV      R8,#0
	   B        CPM 

;CCC: Ciclo que hace la copia del CuFeq en el borrador

CCC    CMP      R6,#32
       BEQ      RESET1
	   LDR      R10,[R2,R6]
	   STR      R10,[R3,R8]
	   ADD      R6,R6,#4
	   ADD      R8,R8,#4
	   B        CCC
	   
RESET1 MOV      R8,#0
	   LDR      R10,[R3,R8]
       
;CSM: Ciclo secundario del mapeo

CSM    CMP      R9,R10
       BEQ      FCPM
	   CMP      R9,R10
	   BGT      MS   
	   B        MR           
 
; MS: Mapeo de sumas         
	   
MS     ADD      R10,R10,#1
       STR      R10,[R3,R8]
	   ADD      R8,R8,#4
	   ADD      R7,R7,#1
	   CMP      R8,#32
	   BEQ      RS
RSF	   LDR      R10,[R3,R8]
	   B        CSM
	   
; MR: Mapeo de restas 
	   
MR     SUB      R10,R10,#1
       STR      R10,[R3,R8]
	   ADD      R8,R8,#4
	   ADD      R7,R7,#1
	   CMP      R8,#32
	   BEQ      RR
RRF	   LDR      R10,[R3,R8]
	   B        CSM
	   
; RS: Reset de las sumas

RS     MOV      R7,#0
	   MOV      R8,#0
	   B        RSF
	         
; RR: Reset de las restas

RR     MOV      R7,#0
	   MOV      R8,#0
	   B        RRF
	   
; Etapa 6: Se mapea la imagen original en su forma ecualizada

IE6    LDR      R1,=EII
       LDR      R2,=EIF
	   LDR      R3,=ERM
	   MOV      R4,#0   ;Contador de la imagen
	   MOV      R10,#4

; CE: Ciclo de la ecualización

CE     CMP      R4,#25
       BEQ      STOP
       LDRB     R6,[R1,R4]
	   MUL      R7,R6,R10
	   LDR      R8,[R3,R7]
	   STR      R8,[R2,R4]
       ADD      R4,R4,#1
	   B        CE
		
STOP    B       STOP
	   
        END