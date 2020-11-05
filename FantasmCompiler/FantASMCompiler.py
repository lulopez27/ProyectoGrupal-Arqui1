from FantASMSintax import FantASMSintacticAnalizer
from FantASMLexer import FantASMLexicalAnalizer
import codecs
def compile(codigo):



    FantASMLexicalAnalizer(codigo)

    sintaxResult = FantASMSintacticAnalizer(codigo)

    jumpLabels = {}

    hexCode = []

    i = 0
    for statement in sintaxResult:
        if type(statement) == type(tuple()): #Si es una tupla significa que es una instruccion norma

            i += 4

        else:


            jumpLabels.update({statement: hex(i)})
            i += 4

    print(jumpLabels)


test = 'D:/Isaac Porras/Semestre 8/Arqui/Proyecto2/FantasmCompiler/TestFiles/test.txt'
fp = codecs.open(test, "r", "utf-8")
cadena = fp.read()
fp.close()
compile(cadena)