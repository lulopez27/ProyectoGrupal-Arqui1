import ply.lex as lex
import re
import codecs
import os
import sys

from pip._vendor.distlib.compat import raw_input

tokens = [
    'COMA', 'PUNTOCOMA',
    'REG', 'IMM', 'LABEL'
]


reservadas = {
    'GDR': 'GDR',
    'CAR': 'CAR',
    'MOVR': 'MOVR',
    'MOVI': 'MOVI',
    'SUM': 'SUM',
    'RES': 'RES',
    'MOD': 'MOD',
    'MUL': 'MUL',
    'DDR': 'DDR',
    'CMPR': 'CMPR',
    'CMPI': 'CMPI',
    'SAL': 'SAL',
    'SIG': 'SIG',
    'ESP': 'ESP',
}

tokens = tokens + list(reservadas.values())

t_ignore = ' \t'

t_COMA = r','
t_PUNTOCOMA = r';'

def t_REG(t):
    r'[R][0-9]+'
    if t.value.upper() in reservadas:
        t.value = t.value.upper()
        t.type = t.value
    return t


def t_LABEL(t):
    r'[a-zA-Z_][a-zA-Z0-9_#@]*'
    if t.value.upper() in reservadas:
        t.value = t.value.upper()
        t.type = t.value
    return t



def t_newLine(t):
    r'\n+'
    t.lexer.lineno += len(t.value)


def t_IMM(t):
    r'\d+'
    t.value = int(t.value)
    return t

def t_error(t):
    print("Caracter ilegal '%s'" % t.value[0])
    t.lexer.skip(1)



test = 'D:/Isaac Porras/Semestre 8/Arqui/Proyecto2/FantasmCompiler/TestFiles/test.txt'
def FantASMAnalizer(cadena):
    analizador = lex.lex()
    analizador.input(cadena)