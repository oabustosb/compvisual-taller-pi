#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

uniform sampler2D texture;

varying vec4 vertTexCoord;
varying vec4 vertColor;

const vec4 luma = vec4(0.299, 0.587, 0.114, 0);

void main() {
  vec4 texCol = texture2D(texture, vertTexCoord.st);
  float newColor = dot(texCol, luma);
  gl_FragColor = vec4(newColor, newColor, newColor, 1) * vertColor;
}