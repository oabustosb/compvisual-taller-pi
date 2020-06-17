#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

uniform sampler2D texture;

varying vec4 vertTexCoord;
varying vec4 vertColor;

const vec4 rgb = vec4(0.333, 0.333, 0.333, 0);

void main() {
  vec4 texCol = texture2D(texture, vertTexCoord.st);
  float newColor = dot(texCol, rgb);
  gl_FragColor = vec4(newColor, newColor, newColor, 1) * vertColor;
}