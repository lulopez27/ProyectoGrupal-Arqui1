import ply.yacc as yacc

import codecs

from FantASMLexer import tokens
from FantASMLexer import FantASMAnalizer



def p_Start(p):
    '''
    Start : code
    '''
    print(p[0])

def p_Code(p):
    '''
    code : INICIO DOSPUNTOS cuerpo FIN
    '''
    

    print(p[0])

def p_cuerpo(p):
    '''
    cuerpo : instruccion
            | label

    '''
    p[0] = p[1]

def p_label(p):
    '''
    label : LABEL DOSPUNTOS cuerpo
            | empty
    '''
    p[0] = p[1]
def p_instruccion(p):
    '''
    instruccion : instName REG COMA REG COMA REG PUNTOCOMA cuerpo
                | instName REG COMA REG COMA IMM PUNTOCOMA cuerpo
                | empty
    '''
    p[0] = (p[1],p[2],p[4],p[6])
    print(p[0])

def p_instName(p):
    '''
    instName : GDR
            | CAR
            | MOVR
            | MOVI
            | SUM
            | RES
            | MOD
            | MUL
            | DDR
            | CMPR
            | CMPI
            | SAL
            | SIG
            | ESP
    '''

    p[0] = p[1]

def p_empty(p):
    '''
    empty :
    '''
    pass


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

    FantASMAnalizer(cadena)
    FantASMSintacticAnalizer(cadena)
test()