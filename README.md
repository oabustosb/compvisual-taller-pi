# compvisual-taller-pi

### Realizado por:
Oscar Alberto Bustos B. - oabustosb@unal.edu.co

## Motivación y Objetivo

En mi opinión, la principal motivación para el taller ha sido la aplicación práctica de los conceptos teóricos vistos en clase. Con esta situación de virtualidad, la estructura práctica de la clase quedó muy disminuida, ya que, creo yo, las reuniones virtuales favorecen más la exposición de conceptos teóricos que la discusión y la práctica constante. 

Así que, para mí, el objetivo principal del taller es poder cubrir la gran mayoría de las temáticas vistas en las clases y en las presentaciones de los repositorios; en particular, con énfasis en los shaders, un tema que vimos con poco detalle de forma teórica, ya que la práctica es más efectiva para comprender cómo funcionan y cómo se integran con los sketch de Processing. Lograr este objetivo se inscribe dentro de un objetivo mayor, el poder comprender y aplicar las temáticas fundamentales dentro de la Computación Visual, un campo que está en auge dentro de la Ingeniería de Sistemas.

## Metodología

Los puntos del taller, en el orden en el que se encuentran en la lista de [Colaboraciones de Visual Computing](http://visualcomputing.github.io/collaborations), fueron abordados desde dos perspectivas diferentes: el _software_ (utilizando solamente los comandos de alto nivel de Processing) y el _hardware_ (incluyendo archivos GLSL para utilizar shaders en conjunto con los sketch de Processing). Para codificar los sketch, se utilizó el IDE de Processing, y para los shaders, la herramienta Visual Code Studio. Los sketch de _software_ están en las carpetas cuyos nombres terminan en _Soft_, y los sketch de _hardware_ están en las carpetas cuyos nombres terminan en _Hard_.

La mayoría de los sketch permite algún grado de interactividad con el usuario, a través de atajos de teclado. Para el punto de promedio RGB y Luma, se puede cambiar entre un efecto y otro mediante las teclas `1` y `0`. Para el punto de filtros de convolución, se puede cambiar entre un filtro BoxBlur y un filtro EdgeDetection mediante las teclas `1` y `0`. Para el quinto punto de eficiencia computacional en video, los efectos pueden cambiarse con las teclas arrow (`UP`, `DOWN`, `LEFT`, `RIGHT`) y la tecla `SHIFT`. Los otros dos puntos (imágenes ASCII e histograma) no son interactivos.

## Resultados

* Para los dos primeros puntos (promedio RGB y Luma, y filtros de convolución) los shaders fueron más eficientes a la hora de renderizar el canvas. Al modificar interactivamente entre uno y otro efecto, el retardo observado fue menor al usar shaders. Esta mejora es visible en imágenes de diferentes tamaños, y para los diferentes efectos implementados. _Los resultados pueden verse al ejecutar los sketch TallerPunto1Soft, TallerPunto1Hard, TallerPunto2Soft_ y _TallerPunto2Hard_.

* En los puntos de imágenes ASCII e histograma, los shaders fueron de hecho menos eficientes para generar el canvas. La diferencia de tiempos fue notable al iniciar el renderizado del canvas, ya que no se modifica de forma interactiva. Creo que esto se debe a la forma en la que codifiqué los sketch para hardware, ya que las texturas que dibujan los shaders son generadas previamente por comandos de alto nivel, lo que retarda mucho su ejecución. _Los resultados pueden verse al ejecutar los sketch TallerPunto3Soft, TallerPunto3Hard, TallerPunto4Soft_ y _TallerPunto4Hard_.

* Las texturas dibujadas en los puntos de imágenes ASCII e histograma son similares tanto en software como en hardware; sin embargo, se pueden percibir algunas diferencias en el canvas. Por ejemplo, algunos caracteres dibujados por los shaders se ven más tenues que los generados por software, y las columnas del histograma tienen un leve cambio de color al ser dibujadas por shaders que no se ve cuando se generan por software. Esto puede deberse a los mecanismos de interpolación que utilizan los shaders para dibujar texturas en los puntos que no son vértices. _Los resultados pueden verse al ejecutar los sketch TallerPunto3Soft, TallerPunto3Hard, TallerPunto4Soft_ y _TallerPunto4Hard_.

* La eficiencia del procesamiento de video (realizada sólo en software) se ve muy afectada por la clase de filtros que se apliquen. Los siguientes `frameRate` promedio se determinaron al tomar diversas muestras de un mismo video al que se aplicaron los diferentes efectos.

Filtro | fps
-------|-----
Video sin filtro | 30 fps
Promedio RGB | 28 fps
Luma | 19 fps
EdgeDetection | 12 fps
BoxBlur | 12 fps
Conversión ASCII | 6 fps


## Conclusiones

* En computadores de mediana gama como el mío (sin mucho poder de procesamiento), la ejecución de los shaders sí hace alguna diferencia (aunque no muy marcada) frente al uso exclusivo de comandos de alto nivel, ya que en algunos casos son mejores, y en otros toman más tiempo. Esto está sujeto tanto al hardware disponible como a la estructura del software y el tipo de información que el sketch comunica a los shaders.
* La disminución de la eficiencia del procesamiento de imagen y video depende mucho de cómo están codificados los filtros que se aplican. Los más eficientes fueron el de promedio RGB, el Luma y el histograma, ya que sólo realizan una operación por cada pixel. Les siguieron los filtros de convolución, que al requerir el análisis de los pixeles vecinos realizan más operaciones, y el más lento fue el de conversión a ASCII, puesto que realiza varias operaciones complejas (re-escalado, cálculo del brillo, búsqueda de los caracteres). 

