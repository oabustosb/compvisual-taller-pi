# compvisual-taller-pi

## Motivación y Objetivo

En mi opinión, la principal motivación para el taller ha sido la aplicación práctica de los conceptos teóricos vistos en clase. Con esta situación de virtualidad, la estructura práctica de la clase quedó muy disminuida, ya que, creo yo, las reuniones virtuales favorecen más la exposición de conceptos teóricos que la discusión y la práctica constante. Esto es algo que he notado no sólo en esta asignatura. Así que en consonancia, el objetivo básico del taller es poder cubrir la gran mayoría de las temáticas vistas en las clases y en las presentaciones de los repositorios; en particular, con un énfasis en los shaders, un tema que vimos con poco detalle de forma teórica, ya que la práctica es más efectiva para comprender cómo funcionan y cómo se integran con los sketch de Processing.

## Metodología

Cada punto del taller, tal como se encuentran en la lista de Colaboraciones de Visual Computing, fue abordado desde dos perspectivas diferentes, siendo éstas el _software_ (utilizando solamente los comandos de alto nivel de Processing) y el _hardware_ (incluyendo archivos GLSL para utilizar shaders en conjunto con los sketch de Processing). Para codificar los sketch, se utilizó el IDE de Processing, y para los shaders, la herramienta Visual Code Studio.
La mayoría de los sketch permite algún grado de interactividad con el usuario, a través de atajos de teclado. Para los puntos de promedio rgb y luma y filtros de convolución, se puede cambiar entre un efecto y otro mediante las teclas '1' y '0'. Para el quinto punto de eficiencia computacional en video, los efectos pueden cambiarse con las teclas arrow (UP, DOWN, LEFT, RIGHT) y la tecla SHIFT. Los otros dos puntos (imágenes ASCII e histograma) no son interactivos.

## Resultados

A lo largo del desarrollo del taller, quise comprobar si era cierto que, gracias a su capacidad de paralelizar las tareas de rendering, los shaders funcionarían más rápidamente que los comandos de alto nivel de Processing. Sin embargo, al obervar la ejecución de los sketch me di cuenta que (limitándome sólo a mi computador) era difícil decidir si uno era más rápido que el otro. Para los dos primeros puntos (promedio rgb y luma, y filtros de convolución) los shaders fueron un poco más eficientes a la hora de renderizar el canvas. Sin embargo, en los puntos de imágenes ASCII e histograma, los shaders fueron de hecho menos eficientes para generar el canvas. Creo que esto se debe a la forma en la que codifiqué los sketch para hardware, ya que las texturas que dibujan los shaders son de hecho generadas previamente por comandos de alto nivel.

## Conclusiones

* En computadores de mediana gama como el mío (sin mucho poder de procesamiento), la ejecución de los shaders no hace mucha diferencia con el uso exclusivo de comandos de alto nivel, ya que en algunos casos son mejores, y en otros toman más tiempo. Esto está sujeto tanto al hardware disponible como al tipo de información que el sketch comunica a los shaders.
* La eficiencia del procesamiento de video se ve muy afectada por la clase de filtros que se apliquen. Al utilizar un video cuya velocidad es de 30 fps, se notó que el filtro más eficiente fue el de promedio RGB (que corría a un promedio de 25 fps), seguido por el filtro Luma (un promedio de 18 fps), los filtros de convolución (ambos muy similares, con un promedio de 12 fps), y siendo el más lento el de conversión a ASCII (cuya velocidad promedio fue de sólo 6 fps).

