import sys
import numpy as np
import matplotlib.pyplot as plt
byte =0;
i = 0;
j = 0;
A= np.zeros((390,390));
fig, (ax1,ax2) = plt.subplots(1, 2)
file = open('output.txt','r')
for line in file:
    j+=1;
    if(j > 389):
        i+=1;
        j=0;
    for character in line:
        byte = byte*10;
        #print(i,j)
        if(character != '\n'):
            byte = byte +int(character, 16);
        else:
            A[i,j] = byte;
            byte = 0;
B = plt.imread("photo.png")
ax1.imshow(B,cmap='gray');
ax1.set_title("Imagen Original")
ax2.imshow (A,cmap='gray');
ax2.set_title("Imagen Ecualizada")
plt.show();
