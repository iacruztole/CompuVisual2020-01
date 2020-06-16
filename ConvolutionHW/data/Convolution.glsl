#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

uniform sampler2D texture;
uniform vec2 texOffset;

varying vec4 vertColor;
varying vec4 vertTexCoord;

uniform float scalar;
uniform float matrix[25];
uniform int size;

void main() {
  if(size == 3)
  {//Kernel 3x3

    vec2 tc0 = vertTexCoord.st + vec2(-texOffset.s, -texOffset.t);
    vec2 tc1 = vertTexCoord.st + vec2(         0.0, -texOffset.t);
    vec2 tc2 = vertTexCoord.st + vec2(+texOffset.s, -texOffset.t);
    vec2 tc3 = vertTexCoord.st + vec2(-texOffset.s,          0.0);
    vec2 tc4 = vertTexCoord.st + vec2(         0.0,          0.0);
    vec2 tc5 = vertTexCoord.st + vec2(+texOffset.s,          0.0);
    vec2 tc6 = vertTexCoord.st + vec2(-texOffset.s, +texOffset.t);
    vec2 tc7 = vertTexCoord.st + vec2(         0.0, +texOffset.t);
    vec2 tc8 = vertTexCoord.st + vec2(+texOffset.s, +texOffset.t);

    vec4 col0 = texture2D(texture, tc0);
    vec4 col1 = texture2D(texture, tc1);
    vec4 col2 = texture2D(texture, tc2);
    vec4 col3 = texture2D(texture, tc3);
    vec4 col4 = texture2D(texture, tc4);
    vec4 col5 = texture2D(texture, tc5);
    vec4 col6 = texture2D(texture, tc6);
    vec4 col7 = texture2D(texture, tc7);
    vec4 col8 = texture2D(texture, tc8);

    vec4 sum = (matrix[0]*col0 + matrix[1]*col1 + matrix[2]*col2 + matrix[3]*col3 + matrix[4]*col4 + matrix[5]*col5 + matrix[6]*col6 + matrix[7]*col7 + matrix[8]*col8)/scalar;
    gl_FragColor = vec4(sum.rgb, 1.0) * vertColor;
  }
  else //kernels 5x5
  {
    vec2 tc0 = vertTexCoord.st + vec2(-texOffset.s-2.0, -texOffset.t-2.0);
    vec2 tc1 = vertTexCoord.st + vec2(-texOffset.s-2.0, -texOffset.t-1.0);
    vec2 tc2 = vertTexCoord.st + vec2(-texOffset.s-2.0, -texOffset.t);
    vec2 tc3 = vertTexCoord.st + vec2(-texOffset.s-2.0, -texOffset.t+1.0);
    vec2 tc4 = vertTexCoord.st + vec2(-texOffset.s-2.0, -texOffset.t+2.0);

    vec2 tc5 = vertTexCoord.st + vec2(-texOffset.s-1.0, -texOffset.t-2.0);
    vec2 tc6 = vertTexCoord.st + vec2(-texOffset.s-1.0, -texOffset.t-1.0);
    vec2 tc7 = vertTexCoord.st + vec2(-texOffset.s-1.0, -texOffset.t);
    vec2 tc8 = vertTexCoord.st + vec2(-texOffset.s-1.0, -texOffset.t+1.0);
    vec2 tc9 = vertTexCoord.st + vec2(-texOffset.s-1.0, -texOffset.t+2.0);

    vec2 tc10 = vertTexCoord.st + vec2(-texOffset.s, -texOffset.t-2.0);
    vec2 tc11 = vertTexCoord.st + vec2(-texOffset.s, -texOffset.t-1.0);
    vec2 tc12 = vertTexCoord.st + vec2(-texOffset.s, -texOffset.t);
    vec2 tc13 = vertTexCoord.st + vec2(-texOffset.s, -texOffset.t+1.0);
    vec2 tc14 = vertTexCoord.st + vec2(-texOffset.s, -texOffset.t+2.0);

    vec2 tc15 = vertTexCoord.st + vec2(-texOffset.s+1.0, -texOffset.t-2.0);
    vec2 tc16 = vertTexCoord.st + vec2(-texOffset.s+1.0, -texOffset.t-1.0);
    vec2 tc17 = vertTexCoord.st + vec2(-texOffset.s+1.0, -texOffset.t);
    vec2 tc18 = vertTexCoord.st + vec2(-texOffset.s+1.0, -texOffset.t+1.0);
    vec2 tc19 = vertTexCoord.st + vec2(-texOffset.s+1.0, -texOffset.t+2.0);

    vec2 tc20 = vertTexCoord.st + vec2(-texOffset.s+2.0, -texOffset.t-2.0);
    vec2 tc21 = vertTexCoord.st + vec2(-texOffset.s+2.0, -texOffset.t-1.0);
    vec2 tc22 = vertTexCoord.st + vec2(-texOffset.s+2.0, -texOffset.t);
    vec2 tc23 = vertTexCoord.st + vec2(-texOffset.s+2.0, -texOffset.t+1.0);
    vec2 tc24 = vertTexCoord.st + vec2(-texOffset.s+2.0, -texOffset.t+2.0);

    vec4 col0 = texture2D(texture, tc0);
    vec4 col1 = texture2D(texture, tc1);
    vec4 col2 = texture2D(texture, tc2);
    vec4 col3 = texture2D(texture, tc3);
    vec4 col4 = texture2D(texture, tc4);
    vec4 col5 = texture2D(texture, tc5);
    vec4 col6 = texture2D(texture, tc6);
    vec4 col7 = texture2D(texture, tc7);
    vec4 col8 = texture2D(texture, tc8);
    vec4 col9 = texture2D(texture, tc9);
    vec4 col10 = texture2D(texture, tc10);
    vec4 col11 = texture2D(texture, tc11);
    vec4 col12 = texture2D(texture, tc12);
    vec4 col13 = texture2D(texture, tc13);
    vec4 col14 = texture2D(texture, tc14);
    vec4 col15 = texture2D(texture, tc15);
    vec4 col16 = texture2D(texture, tc16);
    vec4 col17 = texture2D(texture, tc17);
    vec4 col18 = texture2D(texture, tc18);
    vec4 col19 = texture2D(texture, tc19);
    vec4 col20 = texture2D(texture, tc20);
    vec4 col21 = texture2D(texture, tc21);
    vec4 col22 = texture2D(texture, tc22);
    vec4 col23 = texture2D(texture, tc23);
    vec4 col24 = texture2D(texture, tc24);

    vec4 sum = (matrix[0]*col0 + matrix[1]*col1 + matrix[2]*col2 + matrix[3]*col3 + matrix[4]*col4 + matrix[5]*col5 + matrix[6]*col6 + matrix[7]*col7 + matrix[8]*col8 + matrix[9]*col9
     + matrix[10]*col10 + matrix[11]*col11 + matrix[12]*col12 + matrix[13]*col13 + matrix[14]*col14 + matrix[15]*col15 + matrix[16]*col16 + matrix[17]*col17 + matrix[18]*col18 + matrix[19]*col19
      + matrix[20]*col20 + matrix[21]*col21 + matrix[22]*col22 + matrix[23]*col23 + matrix[24]*col24)/scalar;
    gl_FragColor = vec4(sum.rgb, 1.0) * vertColor;
  }
}