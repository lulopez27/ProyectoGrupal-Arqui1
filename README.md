# Diseño e implementación de una aplicación de un ASIP de mejora de contraste
FANTARQ
Este proyecto consiste en la implementación de un ISA (FANTASM), microarquitectura( FANTARQ) y un programa en alto nivel el cual permite la captura y conversión de la imágenes procesadas para mejorar su calidad de contraste.

## Comenzando 🚀

Para instalar el sistema en su máquina debe ir al siguiente link y clonar el repositorio en su dispositivo. En caso de que no tenga acceso comuníquese con el correo lulopez@itcr.cr 

Repositorio : https://github.com/lulopez27/ProyectoGrupal-Arqui1

### Pre-requisitos 📋

Debe tener instalado Pycharm 2018.3, Quartus Prime Lite 18.0 y Modelsim 10.b. Puede dirigirse a los siguientes links para obtenerlos:

* https://www.google.com/url?sa=t&rct=j&q=&esrc=s&source=web&cd=&ved=2ahUKEwj966S394ftAhXNzlkKHYrKCqIQFjAAegQIChAD&url=https%3A%2F%2Ffpgasoftware.intel.com%2F%3Fedition%3Dlite&usg=AOvVaw2cQRj7qmTpRWP9G8cI1Pa7

* https://www.jetbrains.com/es-es/pycharm/download/

### Instalación 🔧

Diríjase a al repositorio previamente mencionado y descargue el archivo con el botón llamado Code->Download Zip.
Esto le descargara un archivo comprimido, el cual debe de descomprimir. 

### Librerias utilizadas 🔩
Las librerías utilizadas son:
* cv2
* numpy
* codecs
* ply.lex
* plu.yacc
* Matplotlib
* subprocess

## Despliegue 📦

Primero posicione la imagen en la carpeta ImageConverter/Images con el nombre photo.jpg. Una vez haya posicionado la imagen que desea mejorar el contraste, abra el proyecto llamado ImageConverter con Pycharm y presione el botón Run. Esto le generará 16 archivos distintos los cuales va a utilizar para el procesamiento mediante Quartus. Seguidamente, abra el proyecto de Quartus, llamado “ProyectoGrupal”. Una vez abierto, verificar que en el top se encuentre el archivo “processor_tb”. Realizar la sintesis de RTL para poder simularlo en modelsim. Una vez sintetizado y abierto modelsim se debe cambiar el switch de inicio para que comience a ejecutarse el código. Una vez que está corriendo se debe dejar correr por alrededor de 8 minutos. 
Una vez que termina de ejecutarse la simulacion, se puede visualizar la nueva imagen imagen (“output.txt”) ubicándola dentro del archivo “ImReader”. La imagen original se debe llamar photo.png y la salida del modelsim “output.txt”.

## Construido con 🛠️
Las herramientas utilizadas para el desarrollo de este proyecto son:

* Quartus Prime Lite 18.0
* Pycharm 2018.3
* Sublime Text

## Autores ✒️

* **Oscar Isaac Porras Pérez** - *Estudiante* - [isaacporras](https://github.com/isaacporras)
* **Luis Daniel López Salas** - *Estudiante* - [lulopez27](https://github.com/lulopez27)
* **Kevin Cordero Zúñiga** - *Estudiante* - [Skryfall](https://github.com/Skryfall)
* **Fabricio Elizondo ** - *Estudiante* - [Faberlifer2797](https://github.com/Faberlifer2797)





