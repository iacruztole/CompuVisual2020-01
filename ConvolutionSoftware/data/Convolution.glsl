#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

//Variables que se pasan desde processing
uniform float matrix[25];
uniform float size;
uniform float div;

uniform vec2 texOffset;
varying vec4 vertColor;
varying vec4 vertTexCoord;
uniform sampler2D texture;

void main(void)
{
    // float border = float(int(size)/2);
    // vec4 sum = vec4(0.0, 0.0, 0.0, 0.0);
    // for(float i=0.0; i<size; i++){
    //     for(float j=0.0; j<size; j++){
    //         vec2 tempVec2 = vertTexCoord.st + vec2(texOffset.s + i - border, texOffset.t + j - border);
    //         vec4 tempVec4 = texture2D(texture, tempVec2);
    //         sum += tempVec4 * matrix[int((i*size) + j)]/div;
    //         //sum+=(texture2D(texture, c + vec2(texOffset.s + i - border, texOffset.t + j-border )) * matrix[int((i * size) +j)])/div;
    //     }
    // }

    if(size == 3.0)
    {
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

        vec4 sum = (matrix[0]*col0 + matrix[1]*col1 + matrix[2]*col2 + matrix[3]*col3 + matrix[4]*col4 + matrix[5]*col5 + matrix[6]*col6 + matrix[7]*col7 + matrix[8]*col8)/div; 
        gl_FragColor = vec4(sum.rgb, 1.0) * vertColor;
    }

}