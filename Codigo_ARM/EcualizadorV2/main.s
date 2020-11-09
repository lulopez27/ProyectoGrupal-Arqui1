; Etiquetas de memoria, donde se inician los arrays del algoritmo

EII    EQU    0x20000000 ;Etiqueta de inicio de la imagen
EFD    EQU    0x20025224 ;Etiqueta de inicio de la frecuencia de distribución
EFA    EQU    0x20025624 ;Etiqueta de inicio de la frecuencia acumulada 
EDUF   EQU    0x20025A24 ;Etiqueta de inicio de la distribución uniforme de la frecuencia acumulada
EFA2   EQU    0x20025E24 ;Etiqueta de la frecuencia acumulada parte 2 (acumulada de la frecuencia distribuida)
EBBM   EQU    0x20026224 ;Etiqueta de inicio del bloque borrador del mapeo
ERM    EQU    0x20026624 ;Etiqueta de inicio del resultado del mapeo
EIF    EQU    0x20026A24 ;Etiqueta de inicio de la imagen final ecualizada



; Código del programa principal
; Ecualizador V2, se trabaja con imágenes de 390x390 (152100 pixeles), donde cada pixel es de 1 byte(rango de 0-255)


		AREA Main, CODE, READONLY
		ENTRY
		EXPORT	__main
		
__main


; Etapa 0: Se carga la imagen en memoria
; En este caso se rellenan los 152100 pixeles con valores random. Se van llenando los campos de manera secuencial con valores de 0-255
; Cuando se alcanzan los 256 valores, se vuelve a comenzar desde cero, y así sucesivamente hasta llenar la imagen completa

		LDR		R1,=EII
		MOV     R2,#0  ;Contador de los valores de 0-255, con  los que se llenará la memoria
		MOV     R3,#0  ;Contador de los pixeles de la imagen
		MOV     R4,#900
		MOV     R5,#169
		MUL     R6,R4,R5 ; R6 almacena el resultado de 900x169=152100. Se hizo de esta manera debido a las limitaciones de ARM para generar los inmediatos
		
;CAI: Ciclo de almacenamiento de la imagen

CAI		CMP     R3,R6      ; El ciclo se termina cuando se llenan los 152100 pixeles de la imagen
		BEQ     IE1
		CMP     R2,#256    ; Cuando se alcanzan los 256 valores, se resetea el contador a cero de nuevo
		BEQ     RRP        ; RRP: Reset de los valores del Rango de Pixeles
CCAI	STR     R2,[R1,R3]
		ADD     R2,R2,#1   ; Se incrementa en 1, el valor del contador de los valores random con que se llenará la imagen
		ADD     R3,R3,#1   ; El contador de la imagen es de 1 en 1, ya que se almacena byte por byte
		B       CAI
		
RRP     MOV     R2,#0
	    B       CCAI      ;CCAI: Continuación del CAI 
		


		
; Etapa 1: Se obtiene la frecuencia de distribución de la imagen

IE1     LDR     R1,=EII
        LDR     R2,=EFD
		MOV     R3,#0   ;Contador de la imagen
		MOV     R4,#0   ;Contador donde se guarda el array de la frecuencia
		MOV     R5,#0   ;Contador de los valores del rango 0-255
		MOV     R7,#0   ;Contador de la frecuencia

;CFD: Ciclo de Frecuencia de Distribución
;Básicamente para cada valor del rango 0-255, se comprueba cuantas veces se repite en toda la imagen

CFD     CMP     R5,#256    ;El ciclo se termina cuando se verificaron los 256 valores del rango
        BEQ     IE2        ;IE2: Inicio de la etapa 2
		B       CVPR
FVP		MOV     R3,#0      ;Se resetea el contador de la imagen, cuando ya se recorrió completa para verificar el valor actual del rango
        STR     R7,[R2,R4] ;Para el valor actual del rango, se almacena la cantidad de veces que se repite en la imagen
		MOV     R7,#0      ;Se resetea R7, que es el resultado de cada conteo
		ADD     R4,R4,#4   ;El contador del array es de 4 en 4
		ADD     R5,R5,#1   ;Se incrementa el contador del rango
		B       CFD

;CVPR: Ciclo de Verificar el pixel actual con el valor del rango actual

CVPR   MOV      R10,#900
       MOV      R11,#169
	   MUL      R12,R10,R11 ;R12 almacena el valor de 900x169=152100
	   CMP      R3,R12
       BEQ      FVP         ;FVP: Fin de verificar pixeles
	   LDRB     R6,[R1,R3]  ;Se usa LDRB debido a que la imagen se almacena byte por byte, para STR no hay bronca
	   CMP      R6,R5       ;Se compara el valor actual del rango con el valor de la imagen
	   BEQ      SUM1        ;Si son iguales se incrementa en 1 el resultado de la frecuencia de distribución
FS1	   ADD      R3,R3,#1    ;Se incrementa en 1 el contador de la imagen
	   B        CVPR
	   
	   
SUM1   ADD      R7,R7,#1
       B        FS1     ;FS1: Fin de sumar 1
		
; Etapa 2: Se obtiene la frecuencia acumulada

IE2    LDR      R1,=EFA
       MOV      R3,#0      ;Contador del bloque de frecuencia de distribución
	   MOV      R4,#0      ;Contador del bloque de frecuencia acumulada
	   LDR      R5,[R2,R3] ;Se obtiene el primer valor de la frecuencia de distribución
	   STR      R5,[R1,R4] ;Se hace copia directa del primer valor del f(I) en el array del CuF
	   ADD      R3,R3,#4   ;Se incrementa el contador del f(I), ya que se va sumando el valor actual de f(I) con el valor anterior del CuF

; CDSF: Ciclo de sumar frecuencias
;Básicamente para obtener el nuevo valor del CuF, se suma el valor actual del f(I) con el valor anterior del CuF
;Es por esto que el contador del f(I) va adelantado en 1 al del CuF. Como se  mencionó previamente, el primer valor se hace copia directa

CDSF   CMP      R3,#1024   ;El límite son 256x4=1024. Cantidad totales de bloques de los arrays
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
       LDR      R4,[R1,#1020] ;El valor de 1020 se obtiene de 255x4. Me permite obtener la última posición del array del CuF
	   MOV      R5,#256       ;El módulo se calcula con 256, que es la cantidad máxima de posibilidades para 1 byte
	  
	   ;Se calcula el módulo del valor máximo de CuF entre el valor máximo del rango
	   UDIV     R6,R4,R5
	   MUL      R7,R6,R5
	   SUB      R8,R4,R7
	  
	   ;Se calcula la parte entera de el valor máximo de CuF entre el valor máximo del rango(N = 256 = 2**8)
	   ;Para hacer esta división se utiliza el corrimiento aritmético a la derecha con 8 bits
       ASR      R9,R4,#8

       ;Se utiliza el R6 como contador del bloque Feq
	   MOV      R6,#0
	  
	   ;Se toman dos caminos dependiendo del módulo
	   CMP      R8,#0
	   BEQ      CM0   ;CM0:  Ciclo cuando el módulo es cero
	   B        CMD0  ;CMDO: Ciclo cuando el módulo es diferente de cero
	  
;Cuando el módulo es cero, se distribuye uniformemente el valor obtenido al dividir el máximo de CuF entre 256

CM0    CMP      R6,#1024
       BEQ      IE4
	   STR      R9,[R3,R6]
	   ADD      R6,R6,#4
	   B        CM0

;Cuando el módulo es diferente de cero, se debe obtener el valor faltante para completar el máximo del CuF a la hora de hacer la distribución
;La ecuación es: X = MaxCuF - (cocienteEntero x 255 )
;Este valor se puede almacenar en cualquier lugar, por simplicidad se almacena de primero

CMD0   MOV      R7,#255
       MUL      R10,R9,R7
	   SUB      R11,R4,R10
	   STR      R11,[R3,R6]
	   ADD      R6,R6,#4

;Ciclo para almacenar el cocienteEntero de MaxCuF/256, en el resto de campos del array del Feq

CMD02  CMP      R6,#1024
       BEQ      IE4
	   STR      R9,[R3,R6]
	   ADD      R6,R6,#4
	   B        CMD02

; Etapa 4: Se obtiene la frecuencia acumulada de la frecuencia distribuida
; Mismo algoritmo de la etapa 2, solo que en este caso se obtiene la frecuencia acumulada del Feq

IE4    LDR      R4,=EFA2
       MOV      R5,#0 ; Contador del bloque de frecuencia distribuida
	   MOV      R6,#0 ; Contador del bloque de frecuencia acumulada parte 2
	   LDR      R7,[R3,R5]
	   STR      R7,[R4,R6]
	   ADD      R5,R5,#4

; CDSF2: Ciclo de sumar frecuencias2

CDSF2  CMP      R5,#1024
       BEQ      IE5
	   LDR      R7,[R3,R5]
	   LDR      R8,[R4,R6]
	   ADD      R9,R7,R8
	   ADD      R6,R6,#4
	   STR      R9,[R4,R6]
	   ADD      R5,R5,#4
	   B        CDSF2


; Etapa 5: Se obtiene el array del mapeo
; La esencia del algoritmo, es encontrar el valor más cercano del CuFeq a CuF
; Para cada valor del CuF, lo comparo con todos los valores del CuFeq, si son iguales se acabó la búsqueda.
; Si no son iguales, se verifica si el número es mayor o menor al de interés , donde el algoritmo tomará dos caminos.
; Si el número es mayor que el de interés, se le restará 1, si es menor se le sumará 1.
; Lo anterior se repite para todos los valores del CuFeq, hasta que se encuentre el primero que sea igual, ya que eso representa el valor más cercano.
; El valor que se lleva como resultado en R7 es de la posición del array, que es lo que se ocupa al final.
; Hay un bloque donde se hace copia del CuFeq (se conserva el original), para cada valor de CuF, esto se debe a que el arreglo se está modificando con sumas y restas hasta encontrar el valor más cercano.


IE5    LDR      R1,=EFA
	   LDR      R2,=EFA2
	   LDR      R3,=EBBM
	   LDR      R4,=ERM
	   MOV      R5,#0    ;Contador del CuF y del I prima del mapeo
	   MOV      R6,#0    ;Contador del CuFeq
	   MOV      R7,#0    ;Contador de la posición final
	   MOV      R8,#0    ;Contador del bloque borrador del mapeo
	   
	   
	   
;CPM: Ciclo principal del mapeo

CPM    CMP      R5,#1024
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

CCC    CMP      R6,#1024
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
	   CMP      R8,#1024
	   BEQ      RS
RSF	   LDR      R10,[R3,R8]
	   B        CSM
	   
; MR: Mapeo de restas 
	   
MR     SUB      R10,R10,#1
       STR      R10,[R3,R8]
	   ADD      R8,R8,#4
	   ADD      R7,R7,#1
	   CMP      R8,#1024
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
; Básicamente para cada valor de la imagen original, se multiplica por 4, para obtener la posición del array del mapeo
; El valor obtenido del array del mapeo, será el nuevo pixel

IE6    LDR      R1,=EII
       LDR      R2,=EIF
	   LDR      R3,=ERM
	   MOV      R4,#0   ;Contador de la imagen
	   MOV      R5,#4

; CE: Ciclo de la ecualización

CE     MOV      R10,#900
	   MOV      R11,#169
	   MUL      R12,R10,R11
	   CMP      R4,R12
       BEQ      STOP
       LDRB     R6,[R1,R4]
	   MUL      R7,R6,R5
	   LDR      R8,[R3,R7]
	   STR      R8,[R2,R4]
       ADD      R4,R4,#1
	   B        CE
		
STOP   B       STOP
	   
       END