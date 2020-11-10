

import subprocess
import os


# To get the dialog box to open when required
from tkinter import filedialog


def get_bytes_from_file():
    with open("./Images/photo.jpg", "rb") as image:
        f = image.read()
        b = bytearray(f)

    for byte in b:
        print(byte)



    with open("./Images/byteFile.txt", "w") as archivos:
        for item in b:
            itemLen = len(hex(item)[2:])
            item = str(hex(item))
            if (itemLen) < 2:
                while itemLen < 2:
                    item = '0' + item[2:]

                    itemLen += 1
                item = '0x' + item


            archivos.write("%s\n" % item[2:])










get_bytes_from_file()