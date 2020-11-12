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
		MOV     R4,#4   
		MOV     R5,#0   ;Pixel actual
		MOV     R6,#0   ;Frecuencia del pixel actual
		MOV     R0,#0
		MOV     R7,#0
		
		
LEFD    CMP     R0,#32
        BEQ     CFD
        STR     R7,[R2,R0]
        ADD     R0,R0,#4
        B       LEFD		

;CFD: Ciclo de Frecuencia de Distribución

CFD    CMP      R3,#25
	   BEQ      IE2
	   LDRB     R5,[R1,R3]
	   MUL      R7,R5,R4
	   LDR      R6,[R2,R7]
	   ADD      R6,R6,#1
	   STR      R6,[R2,R7]
	   ADD      R3,R3,#1
	   B        CFD
		
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

IE5    LDR      R1,=EFA  ;CuF
	   LDR      R2,=EFA2 ;CuFeq
	   LDR      R3,=ERM  ;Resultado final del mapeo
	   MOV      R4,#0    ;Contador del CuF y del resultado del mapeo
	   MOV      R5,#0    ;Límite inferior
	   MOV      R6,#7    ;Límite Superior
	   MOV      R7,#0    ;Centro
	   MOV      R8,#0    ;Valor buscado
	   MOV      R9,#0    ;Valor del límite inferior
	   MOV      R10,#0   ;Valor del límite  superior
	   MOV      R11,#0   ;Nuevo pixel mapeado
	   MOV      R12,#0   ;Valor del centro


;CPM: Ciclo principal del mapeo


CPM    CMP      R4,#32
       BEQ      IE6 
	   LDR      R8,[R1,R4]
	   B        BBM
FBBM   STR      R11,[R3,R4]
       ADD      R4,R4,#4
	   MOV      R5,#0
	   MOV      R6,#7
	   B        CPM
	   
;BBM: Búsqueda binaria modificada

BBM    ADD      R7,R5,R6
       ASR      R7,R7,#1
	   MOV      R11,#4
	   MUL      R11,R7,R11
	   LDR      R12,[R2,R11]
	   CMP      R12,R8
	   BEQ      AR1
	   CMP      R7,R5
	   BEQ      EVA1
	   CMP      R12,R8
	   BGT      ALS
	   B        ALI

;AR1: Asignar resultado 1

AR1    MOV      R11,R7
       B        FBBM
	   
;ALS: Asignar límite superior

ALS    MOV      R6,R7
       B        BBM
	   
;ALI: Asignar límite inferior

ALI    MOV      R5,R7
       B        BBM
	   
;EVA1:Etapa del valor absoluto parte 1

EVA1   MOV      R11,#4
       MUL      R11,R5,R11
       LDR      R9,[R2,R11]
       MOV      R11,#4
       MUL      R11,R6,R11
       LDR      R10,[R2,R11]

;EVA2:Etapa del valor absoluto parte 2

EVA2   CMP      R9,R8
       BEQ      AR2
	   CMP      R10,R8
	   BEQ      AR3
	   SUB      R9,R8,R9
	   SUB      R10,R8,R10
	   CMP      R9,#0
	   BGT      CEVA2
	   B        ABS1
CEVA2  CMP      R10,#0
       BGT      FEVA2
	   B        ABS2
FEVA2  CMP      R9,R10
       BGT      AR3
	   B        AR2
	   
;AR2: Asignar resultado 2

AR2    MOV      R11,R5
       B        FBBM
	   
;AR3: Asignar resultado 3

AR3    MOV      R11,R6
       B        FBBM	   
	   
;ABS1: ABS parte 1

ABS1   MOV      R11,#0
       SUB      R9,R11,R9
	   B        CEVA2
	   
;ABS2: ABS parte 2

ABS2   MOV      R11,#0
       SUB      R10,R11,R10
	   B        FEVA2
	   
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
		
STOP   B        STOP


       END