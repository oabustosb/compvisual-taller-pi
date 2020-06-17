#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

uniform sampler2D texture;
uniform vec2 texOffset;

varying vec4 vertTexCoord;
varying vec4 vertColor;

void main() {

  vec2 texel1 = vertTexCoord.st + vec2(-texOffset.s, -texOffset.t);
  vec2 texel2 = vertTexCoord.st + vec2(         0.0, -texOffset.t);
  vec2 texel3 = vertTexCoord.st + vec2(texOffset.s, -texOffset.t);
  vec2 texel4 = vertTexCoord.st + vec2(-texOffset.s,          0.0);
  vec2 texel5 = vertTexCoord.st + vec2(         0.0,          0.0);
  vec2 texel6 = vertTexCoord.st + vec2(texOffset.s,          0.0);
  vec2 texel7 = vertTexCoord.st + vec2(-texOffset.s, texOffset.t);
  vec2 texel8 = vertTexCoord.st + vec2(         0.0, texOffset.t);
  vec2 texel9 = vertTexCoord.st + vec2(texOffset.s, texOffset.t);

  vec4 texCol1 = texture2D(texture, texel1);
  vec4 texCol2 = texture2D(texture, texel2);
  vec4 texCol3 = texture2D(texture, texel3);
  vec4 texCol4 = texture2D(texture, texel4);
  vec4 texCol5 = texture2D(texture, texel5);
  vec4 texCol6 = texture2D(texture, texel6);
  vec4 texCol7 = texture2D(texture, texel7);
  vec4 texCol8 = texture2D(texture, texel8);
  vec4 texCol9 = texture2D(texture, texel9);

  vec4 total = 0.1*(texCol1 + texCol2 + texCol3 + texCol4 + texCol5 + texCol6 + texCol7 + texCol8* + texCol9);

  gl_FragColor = vec4(total.rgb, 1) * vertColor;
}