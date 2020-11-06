from FantASMSintax import FantASMSintacticAnalizer
from FantASMLexer import FantASMLexicalAnalizer
import codecs

registerNumber = {
    'R1' : '0001',
    'R2' : '0010',
    'R3' : '0011',
    'R4' : '0100',
    'R5' : '0101',
    'R6' : '0110',
    'R7' : '0111',
    'R8' : '1000',
    'R9' : '1001',
    'R10': '1010',
    'R11': '1011',
    'R12': '1100',
    'R13': '1101',
    'R14': '1110',
    'R15': '1111'


}

memoryInst = {'GDR': int('10000', 2),
              'CAR': int('10010', 2),
              'MOVR': int('10100', 2),
              'MOVI': int('10101', 2)}
arithmeticInst = {'SUM': int('11000', 2),
                  'RES': int('11010', 2),
                  'MOD': int('11100', 2),
                  'MUL': int('11110', 2),
                  'DDR': int('11001', 2)}

compInst = {'CMPR': int('10110', 2),
            'CMPI': int('10111', 2)}

jumpInst = {'SAL': int('00001', 2),
            'SIG': int('00111', 2)}

stallInst = {'ESP': int('01000', 2)}
bitsBasura19 = '0000000000000000000'

def compile(codigo):
    FantASMLexicalAnalizer(codigo)

    sintaxResult = FantASMSintacticAnalizer(codigo)

    jumpLabels = {}

    hexDirection = []
    instruction = []

    dir = 0
    for statement in sintaxResult:
        if type(statement) == type(tuple()):  # Si es una tupla significa que es una instruccion norma
            hexDirection.append(hex(dir))
            # print(statement[0])
            instruction.append(statement)
            analiceInst(statement)
            dir += 4


        else:

            jumpLabels.update({statement: hex(dir)})

    i = 0
    while i < len(hexDirection):
        # print(hexDirection[i])
        # print(instruction[i])
        i += 1


def analiceInst(inst):
    binCode = ''

    if str(inst[0]) in memoryInst:
        binCode += str(format(memoryInst.get(inst[0]), '#010b'))[5:]

        if inst[1] not in registerNumber:
            print('El registro ' + str(inst[1]) + ' no existe')
            return
        elif inst[2] not in registerNumber and not isinstance(inst[2], int):
            print('El registro ' + str(inst[2]) + ' no existe')
            return
        elif isinstance(inst[2], int):
            print(str(bin(inst[2])))
            binCode += shiftNumber(str(bin(inst[2]))[2:],23) + registerNumber.get(str(inst[1]))

        else:
            binCode += bitsBasura19
            binCode += registerNumber.get(str(inst[2])) + registerNumber.get(str(inst[1]))
            binCode = binCode






    elif str(inst[0]) in arithmeticInst:
        binCode += str(format(arithmeticInst.get(inst[0]), '#010b'))[2:]
    elif str(inst[0]) in compInst:
        binCode += str(format(compInst.get(inst[0]), '#010b'))[2:]
    elif str(inst[0]) in jumpInst:
        binCode += str(format(jumpInst.get(inst[0]), '#010b'))[2:]
    elif str(inst[0]) in stallInst:
        binCode += str(format(stallInst.get(inst[0]), '#010b'))[2:]

    print('El codigo es: ' + binCode)
    print(len(binCode))



def shiftNumber(num,shift):
    largo = len(num)
    if(largo < shift):
        while largo < shift:
            num = '0' + num
            largo +=1
        return num
    else:
        return num
#def getRegNumber(inst):


test = 'D:/Isaac Porras/Semestre 8/Arqui/Proyecto2/FantasmCompiler/TestFiles/test.txt'
fp = codecs.open(test, "r", "utf-8")
cadena = fp.read()
fp.close()
compile(cadena)
