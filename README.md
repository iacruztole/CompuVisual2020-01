# Procesamiento de Imagenes

### Integrantes:
- Iván Cruz 
- Camilo Beltran
- Iván Delgado
  
### Tecnologías:
[![N|Solid](https://upload.wikimedia.org/wikipedia/commons/5/59/Processing_Logo_Clipped.svg)](https://processing.org/)
[![N|Solid](https://www.opengl.org/img/opengl_logo.jpg)](https://www.opengl.org/)
El procesamiento de imagenes es el uso del computador para la aplicación de algoritmos sobre imágenes digitales, en donde los datos son los pixeles que la representan. Dadas las dimensiones de las imágenes digitales el procesamiento generalmente se pueden hacer en paralelo, lo cual se logra de forma muy eficaz por medio de tarjetas de video.
## El repositorio tiene las siguientes partes:
### KERNELS
Los kernels de transformación de imágenes son un método matemático para resaltar o aislar detalles de una imágen a partir de los pixeles alrededor de cada pixel, pudiendo resaltar los bordes de las figuras, enfocar o desenfocar, etc.

El proceso es un tanto simple: se tiene una matriz, la cual llamaremos kernel, y sobre la imágen se toma cada pixel, el cual será el central en cada paso, se multiplica cada una de las posiciones de la matriz con los que le corresponen al superponerla con este pixel central, se suman todos los valores y se asignan como el nuevo valor del pixel central. Este proceso se tiene que hacer igual por cada canal de color RGB. Algunos kernels funcionan mejor al aplicarlos sobre una imágen en escala de grises. Uno de los problemas claros que se tienen al tratar de aplicar este kernel sobre los pixeles son aquellos que están en los bordes, pero esto se puede superar al extender la imagen como un reflejo de los pixeles internos como si fueran los exteriores para los pixeles del borde, o simplemente ignorar el borde y recortarlos.
Estas matrices conllevan un trabajo matemático por lo que crear nuevas es complejo, además de que se tiene que entender de fondo qué es lo que se hace al asignar ciertos valores a cada posición en la matriz.
![N|Solid](https://www.gsn-lib.org/docs/nodes/images/convolve2d.svg)
### Kernels de procesamiento de imagenes/videos por Software
Para esta parte se usaron las nociones matemáticas de lo que representa convertir una imágen usando un kernel de transformación: la multiplicación de cada uno de los canales RGB con los valores del kernel dados, para cada pixel usando los pixeles aledaños, y se actualiza así en otra imágen para mostrar lado a lado la diferencia. Todo el proceso de la lectura de pixeles, pasar por cada uno, obtener los valores RGB, multiplicar y sumar el total se hace dentro del motor de procesing directmente, lo cual se ejecuta finalmente en el procesador del computador.
### Kernels de procesamiento de imagenes/videos por Hardware
Al igual que por software, la metodología es la misma, una multiplicación de los valores de los pixeles aledaños y del propio pixel en cuestión, pero para esta parte se usó OPENGL. La idea, es pasarle al script la imágen cargada en un shape, se le pasa el arreglo de valores del Kernel a usar (en este caso se pasa como un arreglo y no una matriz, pero al final los valores que se multiplican y suman son exactamente los mismos y aplican a las posiciones difinidas por el kernel). Dentro del script se crean los objetos de cada pixel, primero se obtienen las cóordenadas de cada pixel, luego se leen dentro de la imagen, luego se multiplican con los del arreglo del kernel y se suman en total (se dividen por la normal si se necesita una) y se asigna esta transformación como el nuevo pixel actual. Todo se hace dentro del script de OPENGL, lo cual significa que se hace dentro del motor gráfico del computador, ya sea una tarjeta gráfica integrada o externa.
### Conversión de imágenes y video a ASCII
La idea de la conversión a ascii es convertir la imágen o frame de video en escala de grises, obtener un promedio de algunos pixeles cercanos y asignar un símbolo en ASCII que tenga más o menos esa luminosidad, por lo que se crea un arreglo de caracteres de menor a mayor luminosidad y dependiendo de esta se van asignando caracteres por segmentos de imágen o frame. Al final, usando la resolución se decide de qué tamaño son los caracteres y de qué tamaño será el segmento sobre el que se aplica cada uno.
[![N|Solid](https://github.com/iacruztole/CompuVisual2020-01/blob/master/Ascii/ascii.gif)]

### Conversion a escala de grises de imagenes y videos 

- **Método: Promedio de los canales:**
En este metodo se promediaron los valores de color de cada pixel de la imagen. Escala de grises = (R + G + B / 3).

    Ejemplo:
![image ](./img/rgb.png)

- **Método ponderado o método de luminosidad:** Dado que el rojo es el que tiene mas longitud de onda de los tres colores y el verde no solo es el color que tiene menor longitud de onda y da un efecto mas relajante a la vista. Se debe disminuir la contribucion del color rojo y aumentar la contribucion del color verde para conseguir una conversion a escala de grises apropiada.  Tenemos entonces:   Escala de grises = ((0.3 * R) + (0.59 * G) + (0.11 * B)).

    Ejemplo:
![image ](./img/Luma.png)
