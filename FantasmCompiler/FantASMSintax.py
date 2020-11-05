import ply.yacc as yacc

import codecs

from FantASMLexer import tokens
from FantASMLexer import FantASMLexicalAnalizer



def p_Start(p):
    '''
    Start : code
    '''


def p_Code(p):
    '''
    code : INICIO DOSPUNTOS cuerpo FIN
    '''

def p_cuerpo(p):
    '''
    cuerpo : instruccion
            | label

    '''
    p[0] = (p[1])

def p_label(p):
    '''
    label : LABEL DOSPUNTOS cuerpo
            | empty
    '''

    if (p[1] != '$'):
        p[0] = (p[1])
        print(p[0])
    else:
        p[0] = p[1]
def p_instruccion(p):
    '''
    instruccion : arimtethicInstruction
                  | CompareInstruction
                  | memoryInstruction
                  | jumpInstruction
                  | espInstruction
    '''
    p[0] = p[1]


def p_espInstruction(p):
    '''
    espInstruction : ESP PUNTOCOMA cuerpo
                    | empty
    '''
    p[0] = (p[1])
    print(p[0])

def p_CompareInstruction(p):
    '''
    CompareInstruction : CompareInstName REG COMA REG PUNTOCOMA cuerpo
                        | CompareInstName REG COMA IMM PUNTOCOMA cuerpo
                        | empty
    '''
    p[0] = (p[1],p[2],p[4])
    print(p[0])
def p_jumpInstruction(p):
    '''
    jumpInstruction : JumpInstName LABEL PUNTOCOMA cuerpo
    | empty
    '''
    p[0] = (p[1], p[2])
    print(p[0])

def p_memoryInstruction(p):
    '''
    memoryInstruction : MemoryInstName REG COMA REG PUNTOCOMA cuerpo
                        | MemoryInstName REG COMA IMM PUNTOCOMA cuerpo
                        | empty
    '''
    p[0] = (p[1], p[2], p[4])
    print(p[0])

def p_arimtethicInstruction(p):
    '''
    arimtethicInstruction : ArithmeticInstName REG COMA REG COMA REG PUNTOCOMA cuerpo
                | ArithmeticInstName REG COMA REG COMA IMM PUNTOCOMA cuerpo
                | empty
    '''
    if(p[1] != '$'):
            p[0] = (p[1],p[2],p[4],p[6])
            print(p[0])
    else:
        p[0] = p[1]


def p_CompareInstName(p):
    '''
    CompareInstName :  CMPR
                        | CMPI

    '''

    p[0] = p[1]
def p_JumpInstName(p):
    '''
    JumpInstName :  SAL
            | SIG
    '''

    p[0] = p[1]

def p_MemoryInstName(p):
    '''
    MemoryInstName : GDR
            | CAR
            | MOVR
            | MOVI
    '''

    p[0] = p[1]


def p_ArithmeticInstName(p):
    '''
    ArithmeticInstName :  SUM
            | RES
            | MOD
            | MUL
            | DDR
            | SAL
    '''

    p[0] = p[1]

def p_empty(p):
    '''
    empty :
    '''
    p[0] = '$'

def p_error(p):
    print("error de sintaxis " + str(p))
    print("error en la linea " + str(p.lineno))

def FantASMSintacticAnalizer(cadena):
    parser = yacc.yacc()
    parser.parse(cadena)

# documentar esta funcion si va a probar codigo en el GUI


def test():
    # directorio = os.path.dirname(os.getcwd()) + "/Tests/"
    # archivo = buscarFichero(directorio)
    # test = directorio + archivo

    test = 'D:/Isaac Porras/Semestre 8/Arqui/Proyecto2/FantasmCompiler/TestFiles/test.txt'

    fp = codecs.open(test, "r", "utf-8")
    cadena = fp.read()
    fp.close()

    #print(cadena)

    FantASMLexicalAnalizer(cadena)
    FantASMSintacticAnalizer(cadena)
test()