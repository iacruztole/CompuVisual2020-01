# Computación Visual - Procesamiento de Imagenes
### Tecnologías:
[![N|Solid](https://upload.wikimedia.org/wikipedia/commons/5/59/Processing_Logo_Clipped.svg)](https://processing.org/)
[![N|Solid](https://www.opengl.org/img/opengl_logo.jpg)](https://www.opengl.org/)

## El repositorio tiene las siguientes partes:
##### Kernels de procesamiento de imagenes/videos por Software
Para esta parte se usaron las nociones matemáticas de lo que representa convertir una imágen usando un kernel de transformación: la multiplicación de cada uno de los canales RGB con los valores del kernel dados, para cada pixel usando los pixeles aledaños, y se actualiza así en otra imágen para mostrar lado a lado la diferencia. Todo el proceso de la lectura de pixeles, pasar por cada uno, obtener los valores RGB, multiplicar y sumar el total se hace dentro del motor de procesing directmente, lo cual se ejecuta finalmente en el procesador del computador.
##### Kernels de procesamiento de imagenes/videos por Hardware
Al igual que por software, la metodología es la misma, una multiplicación de los valores de los pixeles aledaños y del propio pixel en cuestión, pero para esta parte se usó OPENGL. La idea, es pasarle al script la imágen cargada en un shape, se le pasa el arreglo de valores del Kernel a usar (en este caso se pasa como un arreglo y no una matriz, pero al final los valores que se multiplican y suman son exactamente los mismos). Dentro del script se crean los objetos de cada pixel, primero se obtienen las cóordenadas de cada pixel, luego se leen dentro de la imagen, luego se multiplican con los del arreglo del kernel y se suman en total (se dividen por la normal si se necesita una) y se asigna esta transformación como el nuevo pixel actual. Todo se hace dentro del script de OPENGL, lo cual significa que se hace dentro del motor gráfico del computador, ya sea una tarjeta gráfica integrada o externa.
##### Conversión de imágenes y video a ASCII
La idea de la conversión a ascii es convertir la imágen o frame de video en escala de grises, obtener un promedio de algunos pixeles cercanos y asignar un símbolo en ASCII que tenga más o menos esa luminosidad, por lo que se crea un arreglo de caracteres de menor a mayor luminosidad y dependiendo de esta se van asignando caracteres por segmentos de imágen o frame. Al final, usando la resolución se decide de qué tamaño son los caracteres y de qué tamaño será el segmento sobre el que se aplica cada uno.

