#from FantASMSintax import FantASMSintacticAnalizer
from FantASMLexer import FantASMLexicalAnalizer
import codecs
def compile(codigo):
    lexicalAnalisisResult = FantASMLexicalAnalizer(codigo)
    #FantASMSintacticAnalizer(codigo)

    labels = {}

    for token in lexicalAnalisisResult:
        if(token.type == 'LABEL'):
            print('---Nuevo token----')
            labels.update({token.value:token.lineno})
    print(labels)

test = 'D:/Isaac Porras/Semestre 8/Arqui/Proyecto2/FantasmCompiler/TestFiles/test.txt'
fp = codecs.open(test, "r", "utf-8")
cadena = fp.read()
fp.close()
compile(cadena)