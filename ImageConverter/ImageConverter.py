import subprocess
import os
import matplotlib.pyplot as plt
import numpy as np




# To get the dialog box to open when required
from tkinter import filedialog


def get_bytes_from_file():

    mat = plt.imread("./Images/photo.jpg")


    m = mat.shape
    print(m)



    b = []
    for columna in mat:
        for fila in columna:
            b.append(fila)

    print(len(b))
    print(hex(b[10000]))
    print(hex(b[9999]))
    print(len(b[0:10000]))
    base = 10000
    liminf = 0
    limsup = base
    contador = 1
    while limsup < len(b) + base:
        writeFile(b[liminf:limsup], contador )
        liminf += base
        limsup += base
        contador += 1
        print('Cambio de archivo')







def writeFile(b,archNum):
    contador = 0

    with open("./Images/image" + str(archNum) +".txt", "w") as archivos:
        for item in b:
            itemLen = len(hex(item)[2:])
            item = str(hex(item))
            if (itemLen) < 2:
                while itemLen < 2:
                    item = '0' + item[2:]

                    itemLen += 1
                item = '0x' + item

            if(contador == 9999):
                archivos.write( item[2:])
                contador +=1
            else:
                archivos.write("%s\n" % item[2:])
                contador += 1

get_bytes_from_file()

