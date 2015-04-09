//like HIGH but without FLAKES

Shader "RedDotGames/Mobile/Light Probes Support/Car Paint Medium Detail" {
   Properties {
   
	  _Color ("Diffuse Material Color (RGB)", Color) = (1,1,1,1) 
	  _SpecColor ("Specular Material Color (RGB)", Color) = (1,1,1,1) 
	  _Shininess ("Shininess", Range (0.01, 10)) = 1
	  _Gloss ("Gloss", Range (0.0, 10)) = 1
	  _MainTex ("Diffuse Texture", 2D) = "white" {} 
	  _Cube("Reflection Map", Cube) = "" {}
	  _Reflection("Reflection Power", Range (0.00, 1)) = 0
	  _FrezPow("Fresnel Power",Range(0,2)) = .25
	  _FrezFalloff("Fresnal Falloff",Range(0,10)) = 4	  
	  _SHLightingScale("LightProbe influence scale",Range(0,1)) = 1
  
   }
SubShader {
   Tags { "QUEUE"="Geometry" "RenderType"="Opaque" " IgnoreProjector"="True"}	  
      Pass {  
      
         Tags { "LightMode" = "ForwardBase" } // pass for 
            // 4 vertex lights, ambient light & first pixel light
 
         Program "vp" {
// Vertex combos: 8
//   opengl - ALU: 37 to 69
//   d3d9 - ALU: 37 to 69
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Vector 13 [_WorldSpaceCameraPos]
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Vector 14 [unity_SHAr]
Vector 15 [unity_SHAg]
Vector 16 [unity_SHAb]
Vector 17 [unity_SHBr]
Vector 18 [unity_SHBg]
Vector 19 [unity_SHBb]
Vector 20 [unity_SHC]
Float 21 [_SHLightingScale]
"!!ARBvp1.0
# 37 ALU
PARAM c[22] = { { 0, 1 },
		state.matrix.mvp,
		program.local[5..21] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
MUL R0.xyz, vertex.normal.y, c[10];
MAD R0.xyz, vertex.normal.x, c[9], R0;
MAD R0.xyz, vertex.normal.z, c[11], R0;
ADD R0.xyz, R0, c[0].x;
DP3 R0.w, R0, R0;
RSQ R0.w, R0.w;
MUL R2.xyz, R0.w, R0;
MUL R0.x, R2.y, R2.y;
MAD R0.x, R2, R2, -R0;
MUL R3.xyz, R0.x, c[20];
MOV R0.xyz, R2;
MOV R0.w, c[0].y;
DP4 R4.z, R0, c[16];
DP4 R4.y, R0, c[15];
DP4 R4.x, R0, c[14];
MUL R1, R2.xyzz, R2.yzzx;
DP4 R0.z, R1, c[19];
DP4 R0.x, R1, c[17];
DP4 R0.y, R1, c[18];
ADD R0.xyz, R4, R0;
ADD R0.xyz, R0, R3;
MUL result.texcoord[2].xyz, R0, c[21].x;
DP4 R0.x, vertex.position, c[5];
DP4 R0.z, vertex.position, c[7];
DP4 R0.y, vertex.position, c[6];
DP4 R0.w, vertex.position, c[8];
ADD R1.xyz, R0, -c[13];
MOV result.texcoord[0], R0;
DP3 R0.x, R1, R1;
RSQ R0.x, R0.x;
MOV result.texcoord[1].xyz, R2;
MOV result.texcoord[3], vertex.texcoord[0];
MUL result.texcoord[4].xyz, R0.x, R1;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 37 instructions, 5 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 12 [_WorldSpaceCameraPos]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Vector 13 [unity_SHAr]
Vector 14 [unity_SHAg]
Vector 15 [unity_SHAb]
Vector 16 [unity_SHBr]
Vector 17 [unity_SHBg]
Vector 18 [unity_SHBb]
Vector 19 [unity_SHC]
Float 20 [_SHLightingScale]
"vs_2_0
; 37 ALU
def c21, 0.00000000, 1.00000000, 0, 0
dcl_position0 v0
dcl_normal0 v1
dcl_texcoord0 v2
mul r0.xyz, v1.y, c9
mad r0.xyz, v1.x, c8, r0
mad r0.xyz, v1.z, c10, r0
add r0.xyz, r0, c21.x
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul r2.xyz, r0.w, r0
mul r0.x, r2.y, r2.y
mad r0.x, r2, r2, -r0
mul r3.xyz, r0.x, c19
mov r0.xyz, r2
mov r0.w, c21.y
dp4 r4.z, r0, c15
dp4 r4.y, r0, c14
dp4 r4.x, r0, c13
mul r1, r2.xyzz, r2.yzzx
dp4 r0.z, r1, c18
dp4 r0.x, r1, c16
dp4 r0.y, r1, c17
add r0.xyz, r4, r0
add r0.xyz, r0, r3
mul oT2.xyz, r0, c20.x
dp4 r0.x, v0, c4
dp4 r0.z, v0, c6
dp4 r0.y, v0, c5
dp4 r0.w, v0, c7
add r1.xyz, r0, -c12
mov oT0, r0
dp3 r0.x, r1, r1
rsq r0.x, r0.x
mov oT1.xyz, r2
mov oT3, v2
mul oT4.xyz, r0.x, r1
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
"!!GLES
#define SHADER_API_GLES 1
#define tex2D texture2D


#ifdef VERTEX
#define gl_ModelViewProjectionMatrix glstate_matrix_mvp
uniform mat4 glstate_matrix_mvp;

varying lowp vec3 xlv_TEXCOORD4;
varying mediump vec4 xlv_TEXCOORD3;
varying lowp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 unity_SHC;
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;

uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 _World2Object;
uniform lowp float _SHLightingScale;
uniform highp mat4 _Object2World;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  highp vec3 shl;
  lowp vec3 tmpvar_1;
  lowp vec3 tmpvar_2;
  lowp mat4 modelMatrixInverse;
  lowp mat4 modelMatrix;
  modelMatrix = (_Object2World);
  modelMatrixInverse = (_World2Object);
  lowp vec4 tmpvar_3;
  tmpvar_3.w = 0.0;
  tmpvar_3.xyz = normalize (_glesNormal);
  lowp vec3 tmpvar_4;
  tmpvar_4 = normalize ((tmpvar_3 * modelMatrixInverse).xyz);
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize (((modelMatrix * _glesVertex) - tmpvar_5).xyz);
  tmpvar_2 = tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = tmpvar_4;
  mediump vec3 tmpvar_8;
  mediump vec4 normal;
  normal = tmpvar_7;
  mediump vec3 x3;
  highp float vC;
  mediump vec3 x2;
  mediump vec3 x1;
  highp float tmpvar_9;
  tmpvar_9 = dot (unity_SHAr, normal);
  x1.x = tmpvar_9;
  highp float tmpvar_10;
  tmpvar_10 = dot (unity_SHAg, normal);
  x1.y = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = dot (unity_SHAb, normal);
  x1.z = tmpvar_11;
  mediump vec4 tmpvar_12;
  tmpvar_12 = (normal.xyzz * normal.yzzx);
  highp float tmpvar_13;
  tmpvar_13 = dot (unity_SHBr, tmpvar_12);
  x2.x = tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = dot (unity_SHBg, tmpvar_12);
  x2.y = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = dot (unity_SHBb, tmpvar_12);
  x2.z = tmpvar_15;
  mediump float tmpvar_16;
  tmpvar_16 = ((normal.x * normal.x) - (normal.y * normal.y));
  vC = tmpvar_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = (unity_SHC.xyz * vC);
  x3 = tmpvar_17;
  tmpvar_8 = ((x1 + x2) + x3);
  shl = tmpvar_8;
  highp vec3 tmpvar_18;
  tmpvar_18 = (shl * _SHLightingScale);
  tmpvar_1 = tmpvar_18;
  gl_Position = (gl_ModelViewProjectionMatrix * _glesVertex);
  xlv_TEXCOORD0 = (modelMatrix * _glesVertex);
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_1;
  xlv_TEXCOORD3 = _glesMultiTexCoord0;
  xlv_TEXCOORD4 = tmpvar_2;
}



#endif
#ifdef FRAGMENT
#define unity_LightColor0 _glesLightSource[0].diffuse
#define unity_LightColor1 _glesLightSource[1].diffuse
#define unity_LightColor2 _glesLightSource[2].diffuse
#define unity_LightColor3 _glesLightSource[3].diffuse
#define unity_LightPosition0 _glesLightSource[0].position
#define unity_LightPosition1 _glesLightSource[1].position
#define unity_LightPosition2 _glesLightSource[2].position
#define unity_LightPosition3 _glesLightSource[3].position
#define glstate_light0_spotDirection _glesLightSource[0].spotDirection
#define glstate_light1_spotDirection _glesLightSource[1].spotDirection
#define glstate_light2_spotDirection _glesLightSource[2].spotDirection
#define glstate_light3_spotDirection _glesLightSource[3].spotDirection
#define unity_LightAtten0 _glesLightSource[0].atten
#define unity_LightAtten1 _glesLightSource[1].atten
#define unity_LightAtten2 _glesLightSource[2].atten
#define unity_LightAtten3 _glesLightSource[3].atten
#define glstate_lightmodel_ambient _glesLightModel.ambient
#define gl_LightSource _glesLightSource
#define gl_LightSourceParameters _glesLightSourceParameters
struct _glesLightSourceParameters {
  vec4 diffuse;
  vec4 position;
  vec3 spotDirection;
  vec4 atten;
};
uniform _glesLightSourceParameters _glesLightSource[4];
#define gl_LightModel _glesLightModel
#define gl_LightModelParameters _glesLightModelParameters
struct _glesLightModelParameters {
  vec4 ambient;
};
uniform _glesLightModelParameters _glesLightModel;
#define gl_FrontMaterial _glesFrontMaterial
#define gl_BackMaterial _glesFrontMaterial
#define gl_MaterialParameters _glesMaterialParameters
struct _glesMaterialParameters {
  vec4 emission;
  vec4 ambient;
  vec4 diffuse;
  vec4 specular;
  float shininess;
};
uniform _glesMaterialParameters _glesFrontMaterial;

varying lowp vec3 xlv_TEXCOORD4;
varying mediump vec4 xlv_TEXCOORD3;
varying lowp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform lowp float _Reflection;

uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform lowp vec4 _SpecColor;
uniform mediump float _Shininess;
uniform sampler2D _MainTex;
uniform lowp vec4 _LightColor0;
uniform mediump float _Gloss;
uniform lowp float _FrezPow;
uniform mediump float _FrezFalloff;
uniform samplerCube _Cube;
uniform lowp vec4 _Color;
void main ()
{
  lowp float frez;
  lowp vec4 reflTex;
  lowp vec3 specularReflection;
  lowp vec3 ambientLighting;
  lowp vec3 vertexToLightSource;
  lowp vec3 lightDirection;
  lowp float attenuation;
  lowp vec3 viewDirection;
  lowp vec3 tmpvar_1;
  tmpvar_1 = normalize (xlv_TEXCOORD1);
  highp vec3 tmpvar_2;
  tmpvar_2 = normalize ((_WorldSpaceCameraPos - xlv_TEXCOORD0.xyz));
  viewDirection = tmpvar_2;
  mediump vec2 tmpvar_3;
  tmpvar_3 = xlv_TEXCOORD3.xy;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, tmpvar_3);
  if ((0.0 == _WorldSpaceLightPos0.w)) {
    attenuation = 1.0;
    lightDirection = normalize (_WorldSpaceLightPos0.xyz);
  } else {
    highp vec3 tmpvar_5;
    tmpvar_5 = (_WorldSpaceLightPos0 - xlv_TEXCOORD0).xyz;
    vertexToLightSource = tmpvar_5;
    attenuation = (1.0/(length (vertexToLightSource)));
    lightDirection = normalize (vertexToLightSource);
  };
  highp vec3 tmpvar_6;
  tmpvar_6 = (gl_LightModel.ambient.xyz * _Color.xyz);
  ambientLighting = tmpvar_6;
  lowp vec3 tmpvar_7;
  tmpvar_7 = (((attenuation * _LightColor0.xyz) * _Color.xyz) * max (0.0, dot (tmpvar_1, lightDirection)));
  lowp float tmpvar_8;
  tmpvar_8 = dot (tmpvar_1, lightDirection);
  if ((tmpvar_8 < 0.0)) {
    specularReflection = vec3(0.0, 0.0, 0.0);
  } else {
    lowp float tmpvar_9;
    tmpvar_9 = max (0.0, dot (reflect (-(lightDirection), tmpvar_1), viewDirection));
    mediump vec3 tmpvar_10;
    tmpvar_10 = (((attenuation * _LightColor0.xyz) * _SpecColor.xyz) * pow (tmpvar_9, _Shininess));
    specularReflection = tmpvar_10;
  };
  mediump vec3 tmpvar_11;
  tmpvar_11 = (specularReflection * _Gloss);
  specularReflection = tmpvar_11;
  lowp vec3 tmpvar_12;
  tmpvar_12 = reflect (xlv_TEXCOORD4, normalize (xlv_TEXCOORD1));
  lowp vec4 tmpvar_13;
  tmpvar_13 = textureCube (_Cube, tmpvar_12);
  reflTex = tmpvar_13;
  lowp float tmpvar_14;
  tmpvar_14 = clamp (abs (dot (tmpvar_12, xlv_TEXCOORD1)), 0.0, 1.0);
  mediump float tmpvar_15;
  tmpvar_15 = pow ((1.0 - tmpvar_14), _FrezFalloff);
  frez = tmpvar_15;
  lowp float tmpvar_16;
  tmpvar_16 = (frez * _FrezPow);
  frez = tmpvar_16;
  reflTex.xyz = (tmpvar_13.xyz * clamp ((_Reflection + tmpvar_16), 0.0, 1.0));
  lowp vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = ((tmpvar_4.xyz * clamp (((xlv_TEXCOORD2 + ambientLighting) + tmpvar_7), 0.0, 1.0)) + specularReflection);
  gl_FragData[0] = ((tmpvar_17 + reflTex) + (tmpvar_16 * reflTex));
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
"!!GLES
#define SHADER_API_GLES 1
#define tex2D texture2D


#ifdef VERTEX
#define gl_ModelViewProjectionMatrix glstate_matrix_mvp
uniform mat4 glstate_matrix_mvp;

varying lowp vec3 xlv_TEXCOORD4;
varying mediump vec4 xlv_TEXCOORD3;
varying lowp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 unity_SHC;
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;

uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 _World2Object;
uniform lowp float _SHLightingScale;
uniform highp mat4 _Object2World;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  highp vec3 shl;
  lowp vec3 tmpvar_1;
  lowp vec3 tmpvar_2;
  lowp mat4 modelMatrixInverse;
  lowp mat4 modelMatrix;
  modelMatrix = (_Object2World);
  modelMatrixInverse = (_World2Object);
  lowp vec4 tmpvar_3;
  tmpvar_3.w = 0.0;
  tmpvar_3.xyz = normalize (_glesNormal);
  lowp vec3 tmpvar_4;
  tmpvar_4 = normalize ((tmpvar_3 * modelMatrixInverse).xyz);
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize (((modelMatrix * _glesVertex) - tmpvar_5).xyz);
  tmpvar_2 = tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = tmpvar_4;
  mediump vec3 tmpvar_8;
  mediump vec4 normal;
  normal = tmpvar_7;
  mediump vec3 x3;
  highp float vC;
  mediump vec3 x2;
  mediump vec3 x1;
  highp float tmpvar_9;
  tmpvar_9 = dot (unity_SHAr, normal);
  x1.x = tmpvar_9;
  highp float tmpvar_10;
  tmpvar_10 = dot (unity_SHAg, normal);
  x1.y = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = dot (unity_SHAb, normal);
  x1.z = tmpvar_11;
  mediump vec4 tmpvar_12;
  tmpvar_12 = (normal.xyzz * normal.yzzx);
  highp float tmpvar_13;
  tmpvar_13 = dot (unity_SHBr, tmpvar_12);
  x2.x = tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = dot (unity_SHBg, tmpvar_12);
  x2.y = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = dot (unity_SHBb, tmpvar_12);
  x2.z = tmpvar_15;
  mediump float tmpvar_16;
  tmpvar_16 = ((normal.x * normal.x) - (normal.y * normal.y));
  vC = tmpvar_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = (unity_SHC.xyz * vC);
  x3 = tmpvar_17;
  tmpvar_8 = ((x1 + x2) + x3);
  shl = tmpvar_8;
  highp vec3 tmpvar_18;
  tmpvar_18 = (shl * _SHLightingScale);
  tmpvar_1 = tmpvar_18;
  gl_Position = (gl_ModelViewProjectionMatrix * _glesVertex);
  xlv_TEXCOORD0 = (modelMatrix * _glesVertex);
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_1;
  xlv_TEXCOORD3 = _glesMultiTexCoord0;
  xlv_TEXCOORD4 = tmpvar_2;
}



#endif
#ifdef FRAGMENT
#define unity_LightColor0 _glesLightSource[0].diffuse
#define unity_LightColor1 _glesLightSource[1].diffuse
#define unity_LightColor2 _glesLightSource[2].diffuse
#define unity_LightColor3 _glesLightSource[3].diffuse
#define unity_LightPosition0 _glesLightSource[0].position
#define unity_LightPosition1 _glesLightSource[1].position
#define unity_LightPosition2 _glesLightSource[2].position
#define unity_LightPosition3 _glesLightSource[3].position
#define glstate_light0_spotDirection _glesLightSource[0].spotDirection
#define glstate_light1_spotDirection _glesLightSource[1].spotDirection
#define glstate_light2_spotDirection _glesLightSource[2].spotDirection
#define glstate_light3_spotDirection _glesLightSource[3].spotDirection
#define unity_LightAtten0 _glesLightSource[0].atten
#define unity_LightAtten1 _glesLightSource[1].atten
#define unity_LightAtten2 _glesLightSource[2].atten
#define unity_LightAtten3 _glesLightSource[3].atten
#define glstate_lightmodel_ambient _glesLightModel.ambient
#define gl_LightSource _glesLightSource
#define gl_LightSourceParameters _glesLightSourceParameters
struct _glesLightSourceParameters {
  vec4 diffuse;
  vec4 position;
  vec3 spotDirection;
  vec4 atten;
};
uniform _glesLightSourceParameters _glesLightSource[4];
#define gl_LightModel _glesLightModel
#define gl_LightModelParameters _glesLightModelParameters
struct _glesLightModelParameters {
  vec4 ambient;
};
uniform _glesLightModelParameters _glesLightModel;
#define gl_FrontMaterial _glesFrontMaterial
#define gl_BackMaterial _glesFrontMaterial
#define gl_MaterialParameters _glesMaterialParameters
struct _glesMaterialParameters {
  vec4 emission;
  vec4 ambient;
  vec4 diffuse;
  vec4 specular;
  float shininess;
};
uniform _glesMaterialParameters _glesFrontMaterial;

varying lowp vec3 xlv_TEXCOORD4;
varying mediump vec4 xlv_TEXCOORD3;
varying lowp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform lowp float _Reflection;

uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform lowp vec4 _SpecColor;
uniform mediump float _Shininess;
uniform sampler2D _MainTex;
uniform lowp vec4 _LightColor0;
uniform mediump float _Gloss;
uniform lowp float _FrezPow;
uniform mediump float _FrezFalloff;
uniform samplerCube _Cube;
uniform lowp vec4 _Color;
void main ()
{
  lowp float frez;
  lowp vec4 reflTex;
  lowp vec3 specularReflection;
  lowp vec3 ambientLighting;
  lowp vec3 vertexToLightSource;
  lowp vec3 lightDirection;
  lowp float attenuation;
  lowp vec3 viewDirection;
  lowp vec3 tmpvar_1;
  tmpvar_1 = normalize (xlv_TEXCOORD1);
  highp vec3 tmpvar_2;
  tmpvar_2 = normalize ((_WorldSpaceCameraPos - xlv_TEXCOORD0.xyz));
  viewDirection = tmpvar_2;
  mediump vec2 tmpvar_3;
  tmpvar_3 = xlv_TEXCOORD3.xy;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, tmpvar_3);
  if ((0.0 == _WorldSpaceLightPos0.w)) {
    attenuation = 1.0;
    lightDirection = normalize (_WorldSpaceLightPos0.xyz);
  } else {
    highp vec3 tmpvar_5;
    tmpvar_5 = (_WorldSpaceLightPos0 - xlv_TEXCOORD0).xyz;
    vertexToLightSource = tmpvar_5;
    attenuation = (1.0/(length (vertexToLightSource)));
    lightDirection = normalize (vertexToLightSource);
  };
  highp vec3 tmpvar_6;
  tmpvar_6 = (gl_LightModel.ambient.xyz * _Color.xyz);
  ambientLighting = tmpvar_6;
  lowp vec3 tmpvar_7;
  tmpvar_7 = (((attenuation * _LightColor0.xyz) * _Color.xyz) * max (0.0, dot (tmpvar_1, lightDirection)));
  lowp float tmpvar_8;
  tmpvar_8 = dot (tmpvar_1, lightDirection);
  if ((tmpvar_8 < 0.0)) {
    specularReflection = vec3(0.0, 0.0, 0.0);
  } else {
    lowp float tmpvar_9;
    tmpvar_9 = max (0.0, dot (reflect (-(lightDirection), tmpvar_1), viewDirection));
    mediump vec3 tmpvar_10;
    tmpvar_10 = (((attenuation * _LightColor0.xyz) * _SpecColor.xyz) * pow (tmpvar_9, _Shininess));
    specularReflection = tmpvar_10;
  };
  mediump vec3 tmpvar_11;
  tmpvar_11 = (specularReflection * _Gloss);
  specularReflection = tmpvar_11;
  lowp vec3 tmpvar_12;
  tmpvar_12 = reflect (xlv_TEXCOORD4, normalize (xlv_TEXCOORD1));
  lowp vec4 tmpvar_13;
  tmpvar_13 = textureCube (_Cube, tmpvar_12);
  reflTex = tmpvar_13;
  lowp float tmpvar_14;
  tmpvar_14 = clamp (abs (dot (tmpvar_12, xlv_TEXCOORD1)), 0.0, 1.0);
  mediump float tmpvar_15;
  tmpvar_15 = pow ((1.0 - tmpvar_14), _FrezFalloff);
  frez = tmpvar_15;
  lowp float tmpvar_16;
  tmpvar_16 = (frez * _FrezPow);
  frez = tmpvar_16;
  reflTex.xyz = (tmpvar_13.xyz * clamp ((_Reflection + tmpvar_16), 0.0, 1.0));
  lowp vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = ((tmpvar_4.xyz * clamp (((xlv_TEXCOORD2 + ambientLighting) + tmpvar_7), 0.0, 1.0)) + specularReflection);
  gl_FragData[0] = ((tmpvar_17 + reflTex) + (tmpvar_16 * reflTex));
}



#endif"
}

SubProgram "flash " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 12 [_WorldSpaceCameraPos]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Vector 13 [unity_SHAr]
Vector 14 [unity_SHAg]
Vector 15 [unity_SHAb]
Vector 16 [unity_SHBr]
Vector 17 [unity_SHBg]
Vector 18 [unity_SHBb]
Vector 19 [unity_SHC]
Float 20 [_SHLightingScale]
"agal_vs
c21 0.0 1.0 0.0 0.0
[bc]
adaaaaaaaaaaahacabaaaaffaaaaaaaaajaaaaoeabaaaaaa mul r0.xyz, a1.y, c9
adaaaaaaabaaahacabaaaaaaaaaaaaaaaiaaaaoeabaaaaaa mul r1.xyz, a1.x, c8
abaaaaaaaaaaahacabaaaakeacaaaaaaaaaaaakeacaaaaaa add r0.xyz, r1.xyzz, r0.xyzz
adaaaaaaacaaahacabaaaakkaaaaaaaaakaaaaoeabaaaaaa mul r2.xyz, a1.z, c10
abaaaaaaaaaaahacacaaaakeacaaaaaaaaaaaakeacaaaaaa add r0.xyz, r2.xyzz, r0.xyzz
abaaaaaaaaaaahacaaaaaakeacaaaaaabfaaaaaaabaaaaaa add r0.xyz, r0.xyzz, c21.x
bcaaaaaaaaaaaiacaaaaaakeacaaaaaaaaaaaakeacaaaaaa dp3 r0.w, r0.xyzz, r0.xyzz
akaaaaaaaaaaaiacaaaaaappacaaaaaaaaaaaaaaaaaaaaaa rsq r0.w, r0.w
adaaaaaaacaaahacaaaaaappacaaaaaaaaaaaakeacaaaaaa mul r2.xyz, r0.w, r0.xyzz
adaaaaaaaaaaabacacaaaaffacaaaaaaacaaaaffacaaaaaa mul r0.x, r2.y, r2.y
adaaaaaaacaaaiacacaaaaaaacaaaaaaacaaaaaaacaaaaaa mul r2.w, r2.x, r2.x
acaaaaaaaaaaabacacaaaappacaaaaaaaaaaaaaaacaaaaaa sub r0.x, r2.w, r0.x
adaaaaaaadaaahacaaaaaaaaacaaaaaabdaaaaoeabaaaaaa mul r3.xyz, r0.x, c19
aaaaaaaaaaaaahacacaaaakeacaaaaaaaaaaaaaaaaaaaaaa mov r0.xyz, r2.xyzz
aaaaaaaaaaaaaiacbfaaaaffabaaaaaaaaaaaaaaaaaaaaaa mov r0.w, c21.y
bdaaaaaaaeaaaeacaaaaaaoeacaaaaaaapaaaaoeabaaaaaa dp4 r4.z, r0, c15
bdaaaaaaaeaaacacaaaaaaoeacaaaaaaaoaaaaoeabaaaaaa dp4 r4.y, r0, c14
bdaaaaaaaeaaabacaaaaaaoeacaaaaaaanaaaaoeabaaaaaa dp4 r4.x, r0, c13
adaaaaaaabaaapacacaaaakeacaaaaaaacaaaacjacaaaaaa mul r1, r2.xyzz, r2.yzzx
bdaaaaaaaaaaaeacabaaaaoeacaaaaaabcaaaaoeabaaaaaa dp4 r0.z, r1, c18
bdaaaaaaaaaaabacabaaaaoeacaaaaaabaaaaaoeabaaaaaa dp4 r0.x, r1, c16
bdaaaaaaaaaaacacabaaaaoeacaaaaaabbaaaaoeabaaaaaa dp4 r0.y, r1, c17
abaaaaaaaaaaahacaeaaaakeacaaaaaaaaaaaakeacaaaaaa add r0.xyz, r4.xyzz, r0.xyzz
abaaaaaaaaaaahacaaaaaakeacaaaaaaadaaaakeacaaaaaa add r0.xyz, r0.xyzz, r3.xyzz
adaaaaaaacaaahaeaaaaaakeacaaaaaabeaaaaaaabaaaaaa mul v2.xyz, r0.xyzz, c20.x
bdaaaaaaaaaaabacaaaaaaoeaaaaaaaaaeaaaaoeabaaaaaa dp4 r0.x, a0, c4
bdaaaaaaaaaaaeacaaaaaaoeaaaaaaaaagaaaaoeabaaaaaa dp4 r0.z, a0, c6
bdaaaaaaaaaaacacaaaaaaoeaaaaaaaaafaaaaoeabaaaaaa dp4 r0.y, a0, c5
bdaaaaaaaaaaaiacaaaaaaoeaaaaaaaaahaaaaoeabaaaaaa dp4 r0.w, a0, c7
acaaaaaaabaaahacaaaaaakeacaaaaaaamaaaaoeabaaaaaa sub r1.xyz, r0.xyzz, c12
aaaaaaaaaaaaapaeaaaaaaoeacaaaaaaaaaaaaaaaaaaaaaa mov v0, r0
bcaaaaaaaaaaabacabaaaakeacaaaaaaabaaaakeacaaaaaa dp3 r0.x, r1.xyzz, r1.xyzz
akaaaaaaaaaaabacaaaaaaaaacaaaaaaaaaaaaaaaaaaaaaa rsq r0.x, r0.x
aaaaaaaaabaaahaeacaaaakeacaaaaaaaaaaaaaaaaaaaaaa mov v1.xyz, r2.xyzz
aaaaaaaaadaaapaeadaaaaoeaaaaaaaaaaaaaaaaaaaaaaaa mov v3, a3
adaaaaaaaeaaahaeaaaaaaaaacaaaaaaabaaaakeacaaaaaa mul v4.xyz, r0.x, r1.xyzz
bdaaaaaaaaaaaiadaaaaaaoeaaaaaaaaadaaaaoeabaaaaaa dp4 o0.w, a0, c3
bdaaaaaaaaaaaeadaaaaaaoeaaaaaaaaacaaaaoeabaaaaaa dp4 o0.z, a0, c2
bdaaaaaaaaaaacadaaaaaaoeaaaaaaaaabaaaaoeabaaaaaa dp4 o0.y, a0, c1
bdaaaaaaaaaaabadaaaaaaoeaaaaaaaaaaaaaaoeabaaaaaa dp4 o0.x, a0, c0
aaaaaaaaabaaaiaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v1.w, c0
aaaaaaaaacaaaiaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v2.w, c0
aaaaaaaaaeaaaiaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v4.w, c0
"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Vector 13 [_WorldSpaceCameraPos]
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Vector 14 [unity_SHAr]
Vector 15 [unity_SHAg]
Vector 16 [unity_SHAb]
Vector 17 [unity_SHBr]
Vector 18 [unity_SHBg]
Vector 19 [unity_SHBb]
Vector 20 [unity_SHC]
Float 21 [_SHLightingScale]
"!!ARBvp1.0
# 37 ALU
PARAM c[22] = { { 0, 1 },
		state.matrix.mvp,
		program.local[5..21] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
MUL R0.xyz, vertex.normal.y, c[10];
MAD R0.xyz, vertex.normal.x, c[9], R0;
MAD R0.xyz, vertex.normal.z, c[11], R0;
ADD R0.xyz, R0, c[0].x;
DP3 R0.w, R0, R0;
RSQ R0.w, R0.w;
MUL R2.xyz, R0.w, R0;
MUL R0.x, R2.y, R2.y;
MAD R0.x, R2, R2, -R0;
MUL R3.xyz, R0.x, c[20];
MOV R0.xyz, R2;
MOV R0.w, c[0].y;
DP4 R4.z, R0, c[16];
DP4 R4.y, R0, c[15];
DP4 R4.x, R0, c[14];
MUL R1, R2.xyzz, R2.yzzx;
DP4 R0.z, R1, c[19];
DP4 R0.x, R1, c[17];
DP4 R0.y, R1, c[18];
ADD R0.xyz, R4, R0;
ADD R0.xyz, R0, R3;
MUL result.texcoord[2].xyz, R0, c[21].x;
DP4 R0.x, vertex.position, c[5];
DP4 R0.z, vertex.position, c[7];
DP4 R0.y, vertex.position, c[6];
DP4 R0.w, vertex.position, c[8];
ADD R1.xyz, R0, -c[13];
MOV result.texcoord[0], R0;
DP3 R0.x, R1, R1;
RSQ R0.x, R0.x;
MOV result.texcoord[1].xyz, R2;
MOV result.texcoord[3], vertex.texcoord[0];
MUL result.texcoord[4].xyz, R0.x, R1;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 37 instructions, 5 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 12 [_WorldSpaceCameraPos]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Vector 13 [unity_SHAr]
Vector 14 [unity_SHAg]
Vector 15 [unity_SHAb]
Vector 16 [unity_SHBr]
Vector 17 [unity_SHBg]
Vector 18 [unity_SHBb]
Vector 19 [unity_SHC]
Float 20 [_SHLightingScale]
"vs_2_0
; 37 ALU
def c21, 0.00000000, 1.00000000, 0, 0
dcl_position0 v0
dcl_normal0 v1
dcl_texcoord0 v2
mul r0.xyz, v1.y, c9
mad r0.xyz, v1.x, c8, r0
mad r0.xyz, v1.z, c10, r0
add r0.xyz, r0, c21.x
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul r2.xyz, r0.w, r0
mul r0.x, r2.y, r2.y
mad r0.x, r2, r2, -r0
mul r3.xyz, r0.x, c19
mov r0.xyz, r2
mov r0.w, c21.y
dp4 r4.z, r0, c15
dp4 r4.y, r0, c14
dp4 r4.x, r0, c13
mul r1, r2.xyzz, r2.yzzx
dp4 r0.z, r1, c18
dp4 r0.x, r1, c16
dp4 r0.y, r1, c17
add r0.xyz, r4, r0
add r0.xyz, r0, r3
mul oT2.xyz, r0, c20.x
dp4 r0.x, v0, c4
dp4 r0.z, v0, c6
dp4 r0.y, v0, c5
dp4 r0.w, v0, c7
add r1.xyz, r0, -c12
mov oT0, r0
dp3 r0.x, r1, r1
rsq r0.x, r0.x
mov oT1.xyz, r2
mov oT3, v2
mul oT4.xyz, r0.x, r1
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
"!!GLES
#define SHADER_API_GLES 1
#define tex2D texture2D


#ifdef VERTEX
#define gl_ModelViewProjectionMatrix glstate_matrix_mvp
uniform mat4 glstate_matrix_mvp;

varying lowp vec3 xlv_TEXCOORD4;
varying mediump vec4 xlv_TEXCOORD3;
varying lowp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 unity_SHC;
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;

uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 _World2Object;
uniform lowp float _SHLightingScale;
uniform highp mat4 _Object2World;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  highp vec3 shl;
  lowp vec3 tmpvar_1;
  lowp vec3 tmpvar_2;
  lowp mat4 modelMatrixInverse;
  lowp mat4 modelMatrix;
  modelMatrix = (_Object2World);
  modelMatrixInverse = (_World2Object);
  lowp vec4 tmpvar_3;
  tmpvar_3.w = 0.0;
  tmpvar_3.xyz = normalize (_glesNormal);
  lowp vec3 tmpvar_4;
  tmpvar_4 = normalize ((tmpvar_3 * modelMatrixInverse).xyz);
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize (((modelMatrix * _glesVertex) - tmpvar_5).xyz);
  tmpvar_2 = tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = tmpvar_4;
  mediump vec3 tmpvar_8;
  mediump vec4 normal;
  normal = tmpvar_7;
  mediump vec3 x3;
  highp float vC;
  mediump vec3 x2;
  mediump vec3 x1;
  highp float tmpvar_9;
  tmpvar_9 = dot (unity_SHAr, normal);
  x1.x = tmpvar_9;
  highp float tmpvar_10;
  tmpvar_10 = dot (unity_SHAg, normal);
  x1.y = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = dot (unity_SHAb, normal);
  x1.z = tmpvar_11;
  mediump vec4 tmpvar_12;
  tmpvar_12 = (normal.xyzz * normal.yzzx);
  highp float tmpvar_13;
  tmpvar_13 = dot (unity_SHBr, tmpvar_12);
  x2.x = tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = dot (unity_SHBg, tmpvar_12);
  x2.y = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = dot (unity_SHBb, tmpvar_12);
  x2.z = tmpvar_15;
  mediump float tmpvar_16;
  tmpvar_16 = ((normal.x * normal.x) - (normal.y * normal.y));
  vC = tmpvar_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = (unity_SHC.xyz * vC);
  x3 = tmpvar_17;
  tmpvar_8 = ((x1 + x2) + x3);
  shl = tmpvar_8;
  highp vec3 tmpvar_18;
  tmpvar_18 = (shl * _SHLightingScale);
  tmpvar_1 = tmpvar_18;
  gl_Position = (gl_ModelViewProjectionMatrix * _glesVertex);
  xlv_TEXCOORD0 = (modelMatrix * _glesVertex);
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_1;
  xlv_TEXCOORD3 = _glesMultiTexCoord0;
  xlv_TEXCOORD4 = tmpvar_2;
}



#endif
#ifdef FRAGMENT
#define unity_LightColor0 _glesLightSource[0].diffuse
#define unity_LightColor1 _glesLightSource[1].diffuse
#define unity_LightColor2 _glesLightSource[2].diffuse
#define unity_LightColor3 _glesLightSource[3].diffuse
#define unity_LightPosition0 _glesLightSource[0].position
#define unity_LightPosition1 _glesLightSource[1].position
#define unity_LightPosition2 _glesLightSource[2].position
#define unity_LightPosition3 _glesLightSource[3].position
#define glstate_light0_spotDirection _glesLightSource[0].spotDirection
#define glstate_light1_spotDirection _glesLightSource[1].spotDirection
#define glstate_light2_spotDirection _glesLightSource[2].spotDirection
#define glstate_light3_spotDirection _glesLightSource[3].spotDirection
#define unity_LightAtten0 _glesLightSource[0].atten
#define unity_LightAtten1 _glesLightSource[1].atten
#define unity_LightAtten2 _glesLightSource[2].atten
#define unity_LightAtten3 _glesLightSource[3].atten
#define glstate_lightmodel_ambient _glesLightModel.ambient
#define gl_LightSource _glesLightSource
#define gl_LightSourceParameters _glesLightSourceParameters
struct _glesLightSourceParameters {
  vec4 diffuse;
  vec4 position;
  vec3 spotDirection;
  vec4 atten;
};
uniform _glesLightSourceParameters _glesLightSource[4];
#define gl_LightModel _glesLightModel
#define gl_LightModelParameters _glesLightModelParameters
struct _glesLightModelParameters {
  vec4 ambient;
};
uniform _glesLightModelParameters _glesLightModel;
#define gl_FrontMaterial _glesFrontMaterial
#define gl_BackMaterial _glesFrontMaterial
#define gl_MaterialParameters _glesMaterialParameters
struct _glesMaterialParameters {
  vec4 emission;
  vec4 ambient;
  vec4 diffuse;
  vec4 specular;
  float shininess;
};
uniform _glesMaterialParameters _glesFrontMaterial;

varying lowp vec3 xlv_TEXCOORD4;
varying mediump vec4 xlv_TEXCOORD3;
varying lowp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform lowp float _Reflection;

uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform lowp vec4 _SpecColor;
uniform mediump float _Shininess;
uniform sampler2D _MainTex;
uniform lowp vec4 _LightColor0;
uniform mediump float _Gloss;
uniform lowp float _FrezPow;
uniform mediump float _FrezFalloff;
uniform samplerCube _Cube;
uniform lowp vec4 _Color;
void main ()
{
  lowp float frez;
  lowp vec4 reflTex;
  lowp vec3 specularReflection;
  lowp vec3 ambientLighting;
  lowp vec3 vertexToLightSource;
  lowp vec3 lightDirection;
  lowp float attenuation;
  lowp vec3 viewDirection;
  lowp vec3 tmpvar_1;
  tmpvar_1 = normalize (xlv_TEXCOORD1);
  highp vec3 tmpvar_2;
  tmpvar_2 = normalize ((_WorldSpaceCameraPos - xlv_TEXCOORD0.xyz));
  viewDirection = tmpvar_2;
  mediump vec2 tmpvar_3;
  tmpvar_3 = xlv_TEXCOORD3.xy;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, tmpvar_3);
  if ((0.0 == _WorldSpaceLightPos0.w)) {
    attenuation = 1.0;
    lightDirection = normalize (_WorldSpaceLightPos0.xyz);
  } else {
    highp vec3 tmpvar_5;
    tmpvar_5 = (_WorldSpaceLightPos0 - xlv_TEXCOORD0).xyz;
    vertexToLightSource = tmpvar_5;
    attenuation = (1.0/(length (vertexToLightSource)));
    lightDirection = normalize (vertexToLightSource);
  };
  highp vec3 tmpvar_6;
  tmpvar_6 = (gl_LightModel.ambient.xyz * _Color.xyz);
  ambientLighting = tmpvar_6;
  lowp vec3 tmpvar_7;
  tmpvar_7 = (((attenuation * _LightColor0.xyz) * _Color.xyz) * max (0.0, dot (tmpvar_1, lightDirection)));
  lowp float tmpvar_8;
  tmpvar_8 = dot (tmpvar_1, lightDirection);
  if ((tmpvar_8 < 0.0)) {
    specularReflection = vec3(0.0, 0.0, 0.0);
  } else {
    lowp float tmpvar_9;
    tmpvar_9 = max (0.0, dot (reflect (-(lightDirection), tmpvar_1), viewDirection));
    mediump vec3 tmpvar_10;
    tmpvar_10 = (((attenuation * _LightColor0.xyz) * _SpecColor.xyz) * pow (tmpvar_9, _Shininess));
    specularReflection = tmpvar_10;
  };
  mediump vec3 tmpvar_11;
  tmpvar_11 = (specularReflection * _Gloss);
  specularReflection = tmpvar_11;
  lowp vec3 tmpvar_12;
  tmpvar_12 = reflect (xlv_TEXCOORD4, normalize (xlv_TEXCOORD1));
  lowp vec4 tmpvar_13;
  tmpvar_13 = textureCube (_Cube, tmpvar_12);
  reflTex = tmpvar_13;
  lowp float tmpvar_14;
  tmpvar_14 = clamp (abs (dot (tmpvar_12, xlv_TEXCOORD1)), 0.0, 1.0);
  mediump float tmpvar_15;
  tmpvar_15 = pow ((1.0 - tmpvar_14), _FrezFalloff);
  frez = tmpvar_15;
  lowp float tmpvar_16;
  tmpvar_16 = (frez * _FrezPow);
  frez = tmpvar_16;
  reflTex.xyz = (tmpvar_13.xyz * clamp ((_Reflection + tmpvar_16), 0.0, 1.0));
  lowp vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = ((tmpvar_4.xyz * clamp (((xlv_TEXCOORD2 + ambientLighting) + tmpvar_7), 0.0, 1.0)) + specularReflection);
  gl_FragData[0] = ((tmpvar_17 + reflTex) + (tmpvar_16 * reflTex));
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
"!!GLES
#define SHADER_API_GLES 1
#define tex2D texture2D


#ifdef VERTEX
#define gl_ModelViewProjectionMatrix glstate_matrix_mvp
uniform mat4 glstate_matrix_mvp;

varying lowp vec3 xlv_TEXCOORD4;
varying mediump vec4 xlv_TEXCOORD3;
varying lowp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 unity_SHC;
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;

uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 _World2Object;
uniform lowp float _SHLightingScale;
uniform highp mat4 _Object2World;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  highp vec3 shl;
  lowp vec3 tmpvar_1;
  lowp vec3 tmpvar_2;
  lowp mat4 modelMatrixInverse;
  lowp mat4 modelMatrix;
  modelMatrix = (_Object2World);
  modelMatrixInverse = (_World2Object);
  lowp vec4 tmpvar_3;
  tmpvar_3.w = 0.0;
  tmpvar_3.xyz = normalize (_glesNormal);
  lowp vec3 tmpvar_4;
  tmpvar_4 = normalize ((tmpvar_3 * modelMatrixInverse).xyz);
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize (((modelMatrix * _glesVertex) - tmpvar_5).xyz);
  tmpvar_2 = tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = tmpvar_4;
  mediump vec3 tmpvar_8;
  mediump vec4 normal;
  normal = tmpvar_7;
  mediump vec3 x3;
  highp float vC;
  mediump vec3 x2;
  mediump vec3 x1;
  highp float tmpvar_9;
  tmpvar_9 = dot (unity_SHAr, normal);
  x1.x = tmpvar_9;
  highp float tmpvar_10;
  tmpvar_10 = dot (unity_SHAg, normal);
  x1.y = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = dot (unity_SHAb, normal);
  x1.z = tmpvar_11;
  mediump vec4 tmpvar_12;
  tmpvar_12 = (normal.xyzz * normal.yzzx);
  highp float tmpvar_13;
  tmpvar_13 = dot (unity_SHBr, tmpvar_12);
  x2.x = tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = dot (unity_SHBg, tmpvar_12);
  x2.y = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = dot (unity_SHBb, tmpvar_12);
  x2.z = tmpvar_15;
  mediump float tmpvar_16;
  tmpvar_16 = ((normal.x * normal.x) - (normal.y * normal.y));
  vC = tmpvar_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = (unity_SHC.xyz * vC);
  x3 = tmpvar_17;
  tmpvar_8 = ((x1 + x2) + x3);
  shl = tmpvar_8;
  highp vec3 tmpvar_18;
  tmpvar_18 = (shl * _SHLightingScale);
  tmpvar_1 = tmpvar_18;
  gl_Position = (gl_ModelViewProjectionMatrix * _glesVertex);
  xlv_TEXCOORD0 = (modelMatrix * _glesVertex);
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_1;
  xlv_TEXCOORD3 = _glesMultiTexCoord0;
  xlv_TEXCOORD4 = tmpvar_2;
}



#endif
#ifdef FRAGMENT
#define unity_LightColor0 _glesLightSource[0].diffuse
#define unity_LightColor1 _glesLightSource[1].diffuse
#define unity_LightColor2 _glesLightSource[2].diffuse
#define unity_LightColor3 _glesLightSource[3].diffuse
#define unity_LightPosition0 _glesLightSource[0].position
#define unity_LightPosition1 _glesLightSource[1].position
#define unity_LightPosition2 _glesLightSource[2].position
#define unity_LightPosition3 _glesLightSource[3].position
#define glstate_light0_spotDirection _glesLightSource[0].spotDirection
#define glstate_light1_spotDirection _glesLightSource[1].spotDirection
#define glstate_light2_spotDirection _glesLightSource[2].spotDirection
#define glstate_light3_spotDirection _glesLightSource[3].spotDirection
#define unity_LightAtten0 _glesLightSource[0].atten
#define unity_LightAtten1 _glesLightSource[1].atten
#define unity_LightAtten2 _glesLightSource[2].atten
#define unity_LightAtten3 _glesLightSource[3].atten
#define glstate_lightmodel_ambient _glesLightModel.ambient
#define gl_LightSource _glesLightSource
#define gl_LightSourceParameters _glesLightSourceParameters
struct _glesLightSourceParameters {
  vec4 diffuse;
  vec4 position;
  vec3 spotDirection;
  vec4 atten;
};
uniform _glesLightSourceParameters _glesLightSource[4];
#define gl_LightModel _glesLightModel
#define gl_LightModelParameters _glesLightModelParameters
struct _glesLightModelParameters {
  vec4 ambient;
};
uniform _glesLightModelParameters _glesLightModel;
#define gl_FrontMaterial _glesFrontMaterial
#define gl_BackMaterial _glesFrontMaterial
#define gl_MaterialParameters _glesMaterialParameters
struct _glesMaterialParameters {
  vec4 emission;
  vec4 ambient;
  vec4 diffuse;
  vec4 specular;
  float shininess;
};
uniform _glesMaterialParameters _glesFrontMaterial;

varying lowp vec3 xlv_TEXCOORD4;
varying mediump vec4 xlv_TEXCOORD3;
varying lowp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform lowp float _Reflection;

uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform lowp vec4 _SpecColor;
uniform mediump float _Shininess;
uniform sampler2D _MainTex;
uniform lowp vec4 _LightColor0;
uniform mediump float _Gloss;
uniform lowp float _FrezPow;
uniform mediump float _FrezFalloff;
uniform samplerCube _Cube;
uniform lowp vec4 _Color;
void main ()
{
  lowp float frez;
  lowp vec4 reflTex;
  lowp vec3 specularReflection;
  lowp vec3 ambientLighting;
  lowp vec3 vertexToLightSource;
  lowp vec3 lightDirection;
  lowp float attenuation;
  lowp vec3 viewDirection;
  lowp vec3 tmpvar_1;
  tmpvar_1 = normalize (xlv_TEXCOORD1);
  highp vec3 tmpvar_2;
  tmpvar_2 = normalize ((_WorldSpaceCameraPos - xlv_TEXCOORD0.xyz));
  viewDirection = tmpvar_2;
  mediump vec2 tmpvar_3;
  tmpvar_3 = xlv_TEXCOORD3.xy;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, tmpvar_3);
  if ((0.0 == _WorldSpaceLightPos0.w)) {
    attenuation = 1.0;
    lightDirection = normalize (_WorldSpaceLightPos0.xyz);
  } else {
    highp vec3 tmpvar_5;
    tmpvar_5 = (_WorldSpaceLightPos0 - xlv_TEXCOORD0).xyz;
    vertexToLightSource = tmpvar_5;
    attenuation = (1.0/(length (vertexToLightSource)));
    lightDirection = normalize (vertexToLightSource);
  };
  highp vec3 tmpvar_6;
  tmpvar_6 = (gl_LightModel.ambient.xyz * _Color.xyz);
  ambientLighting = tmpvar_6;
  lowp vec3 tmpvar_7;
  tmpvar_7 = (((attenuation * _LightColor0.xyz) * _Color.xyz) * max (0.0, dot (tmpvar_1, lightDirection)));
  lowp float tmpvar_8;
  tmpvar_8 = dot (tmpvar_1, lightDirection);
  if ((tmpvar_8 < 0.0)) {
    specularReflection = vec3(0.0, 0.0, 0.0);
  } else {
    lowp float tmpvar_9;
    tmpvar_9 = max (0.0, dot (reflect (-(lightDirection), tmpvar_1), viewDirection));
    mediump vec3 tmpvar_10;
    tmpvar_10 = (((attenuation * _LightColor0.xyz) * _SpecColor.xyz) * pow (tmpvar_9, _Shininess));
    specularReflection = tmpvar_10;
  };
  mediump vec3 tmpvar_11;
  tmpvar_11 = (specularReflection * _Gloss);
  specularReflection = tmpvar_11;
  lowp vec3 tmpvar_12;
  tmpvar_12 = reflect (xlv_TEXCOORD4, normalize (xlv_TEXCOORD1));
  lowp vec4 tmpvar_13;
  tmpvar_13 = textureCube (_Cube, tmpvar_12);
  reflTex = tmpvar_13;
  lowp float tmpvar_14;
  tmpvar_14 = clamp (abs (dot (tmpvar_12, xlv_TEXCOORD1)), 0.0, 1.0);
  mediump float tmpvar_15;
  tmpvar_15 = pow ((1.0 - tmpvar_14), _FrezFalloff);
  frez = tmpvar_15;
  lowp float tmpvar_16;
  tmpvar_16 = (frez * _FrezPow);
  frez = tmpvar_16;
  reflTex.xyz = (tmpvar_13.xyz * clamp ((_Reflection + tmpvar_16), 0.0, 1.0));
  lowp vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = ((tmpvar_4.xyz * clamp (((xlv_TEXCOORD2 + ambientLighting) + tmpvar_7), 0.0, 1.0)) + specularReflection);
  gl_FragData[0] = ((tmpvar_17 + reflTex) + (tmpvar_16 * reflTex));
}



#endif"
}

SubProgram "flash " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 12 [_WorldSpaceCameraPos]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Vector 13 [unity_SHAr]
Vector 14 [unity_SHAg]
Vector 15 [unity_SHAb]
Vector 16 [unity_SHBr]
Vector 17 [unity_SHBg]
Vector 18 [unity_SHBb]
Vector 19 [unity_SHC]
Float 20 [_SHLightingScale]
"agal_vs
c21 0.0 1.0 0.0 0.0
[bc]
adaaaaaaaaaaahacabaaaaffaaaaaaaaajaaaaoeabaaaaaa mul r0.xyz, a1.y, c9
adaaaaaaabaaahacabaaaaaaaaaaaaaaaiaaaaoeabaaaaaa mul r1.xyz, a1.x, c8
abaaaaaaaaaaahacabaaaakeacaaaaaaaaaaaakeacaaaaaa add r0.xyz, r1.xyzz, r0.xyzz
adaaaaaaacaaahacabaaaakkaaaaaaaaakaaaaoeabaaaaaa mul r2.xyz, a1.z, c10
abaaaaaaaaaaahacacaaaakeacaaaaaaaaaaaakeacaaaaaa add r0.xyz, r2.xyzz, r0.xyzz
abaaaaaaaaaaahacaaaaaakeacaaaaaabfaaaaaaabaaaaaa add r0.xyz, r0.xyzz, c21.x
bcaaaaaaaaaaaiacaaaaaakeacaaaaaaaaaaaakeacaaaaaa dp3 r0.w, r0.xyzz, r0.xyzz
akaaaaaaaaaaaiacaaaaaappacaaaaaaaaaaaaaaaaaaaaaa rsq r0.w, r0.w
adaaaaaaacaaahacaaaaaappacaaaaaaaaaaaakeacaaaaaa mul r2.xyz, r0.w, r0.xyzz
adaaaaaaaaaaabacacaaaaffacaaaaaaacaaaaffacaaaaaa mul r0.x, r2.y, r2.y
adaaaaaaacaaaiacacaaaaaaacaaaaaaacaaaaaaacaaaaaa mul r2.w, r2.x, r2.x
acaaaaaaaaaaabacacaaaappacaaaaaaaaaaaaaaacaaaaaa sub r0.x, r2.w, r0.x
adaaaaaaadaaahacaaaaaaaaacaaaaaabdaaaaoeabaaaaaa mul r3.xyz, r0.x, c19
aaaaaaaaaaaaahacacaaaakeacaaaaaaaaaaaaaaaaaaaaaa mov r0.xyz, r2.xyzz
aaaaaaaaaaaaaiacbfaaaaffabaaaaaaaaaaaaaaaaaaaaaa mov r0.w, c21.y
bdaaaaaaaeaaaeacaaaaaaoeacaaaaaaapaaaaoeabaaaaaa dp4 r4.z, r0, c15
bdaaaaaaaeaaacacaaaaaaoeacaaaaaaaoaaaaoeabaaaaaa dp4 r4.y, r0, c14
bdaaaaaaaeaaabacaaaaaaoeacaaaaaaanaaaaoeabaaaaaa dp4 r4.x, r0, c13
adaaaaaaabaaapacacaaaakeacaaaaaaacaaaacjacaaaaaa mul r1, r2.xyzz, r2.yzzx
bdaaaaaaaaaaaeacabaaaaoeacaaaaaabcaaaaoeabaaaaaa dp4 r0.z, r1, c18
bdaaaaaaaaaaabacabaaaaoeacaaaaaabaaaaaoeabaaaaaa dp4 r0.x, r1, c16
bdaaaaaaaaaaacacabaaaaoeacaaaaaabbaaaaoeabaaaaaa dp4 r0.y, r1, c17
abaaaaaaaaaaahacaeaaaakeacaaaaaaaaaaaakeacaaaaaa add r0.xyz, r4.xyzz, r0.xyzz
abaaaaaaaaaaahacaaaaaakeacaaaaaaadaaaakeacaaaaaa add r0.xyz, r0.xyzz, r3.xyzz
adaaaaaaacaaahaeaaaaaakeacaaaaaabeaaaaaaabaaaaaa mul v2.xyz, r0.xyzz, c20.x
bdaaaaaaaaaaabacaaaaaaoeaaaaaaaaaeaaaaoeabaaaaaa dp4 r0.x, a0, c4
bdaaaaaaaaaaaeacaaaaaaoeaaaaaaaaagaaaaoeabaaaaaa dp4 r0.z, a0, c6
bdaaaaaaaaaaacacaaaaaaoeaaaaaaaaafaaaaoeabaaaaaa dp4 r0.y, a0, c5
bdaaaaaaaaaaaiacaaaaaaoeaaaaaaaaahaaaaoeabaaaaaa dp4 r0.w, a0, c7
acaaaaaaabaaahacaaaaaakeacaaaaaaamaaaaoeabaaaaaa sub r1.xyz, r0.xyzz, c12
aaaaaaaaaaaaapaeaaaaaaoeacaaaaaaaaaaaaaaaaaaaaaa mov v0, r0
bcaaaaaaaaaaabacabaaaakeacaaaaaaabaaaakeacaaaaaa dp3 r0.x, r1.xyzz, r1.xyzz
akaaaaaaaaaaabacaaaaaaaaacaaaaaaaaaaaaaaaaaaaaaa rsq r0.x, r0.x
aaaaaaaaabaaahaeacaaaakeacaaaaaaaaaaaaaaaaaaaaaa mov v1.xyz, r2.xyzz
aaaaaaaaadaaapaeadaaaaoeaaaaaaaaaaaaaaaaaaaaaaaa mov v3, a3
adaaaaaaaeaaahaeaaaaaaaaacaaaaaaabaaaakeacaaaaaa mul v4.xyz, r0.x, r1.xyzz
bdaaaaaaaaaaaiadaaaaaaoeaaaaaaaaadaaaaoeabaaaaaa dp4 o0.w, a0, c3
bdaaaaaaaaaaaeadaaaaaaoeaaaaaaaaacaaaaoeabaaaaaa dp4 o0.z, a0, c2
bdaaaaaaaaaaacadaaaaaaoeaaaaaaaaabaaaaoeabaaaaaa dp4 o0.y, a0, c1
bdaaaaaaaaaaabadaaaaaaoeaaaaaaaaaaaaaaoeabaaaaaa dp4 o0.x, a0, c0
aaaaaaaaabaaaiaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v1.w, c0
aaaaaaaaacaaaiaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v2.w, c0
aaaaaaaaaeaaaiaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v4.w, c0
"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Vector 13 [_WorldSpaceCameraPos]
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Vector 14 [unity_SHAr]
Vector 15 [unity_SHAg]
Vector 16 [unity_SHAb]
Vector 17 [unity_SHBr]
Vector 18 [unity_SHBg]
Vector 19 [unity_SHBb]
Vector 20 [unity_SHC]
Float 21 [_SHLightingScale]
"!!ARBvp1.0
# 37 ALU
PARAM c[22] = { { 0, 1 },
		state.matrix.mvp,
		program.local[5..21] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
MUL R0.xyz, vertex.normal.y, c[10];
MAD R0.xyz, vertex.normal.x, c[9], R0;
MAD R0.xyz, vertex.normal.z, c[11], R0;
ADD R0.xyz, R0, c[0].x;
DP3 R0.w, R0, R0;
RSQ R0.w, R0.w;
MUL R2.xyz, R0.w, R0;
MUL R0.x, R2.y, R2.y;
MAD R0.x, R2, R2, -R0;
MUL R3.xyz, R0.x, c[20];
MOV R0.xyz, R2;
MOV R0.w, c[0].y;
DP4 R4.z, R0, c[16];
DP4 R4.y, R0, c[15];
DP4 R4.x, R0, c[14];
MUL R1, R2.xyzz, R2.yzzx;
DP4 R0.z, R1, c[19];
DP4 R0.x, R1, c[17];
DP4 R0.y, R1, c[18];
ADD R0.xyz, R4, R0;
ADD R0.xyz, R0, R3;
MUL result.texcoord[2].xyz, R0, c[21].x;
DP4 R0.x, vertex.position, c[5];
DP4 R0.z, vertex.position, c[7];
DP4 R0.y, vertex.position, c[6];
DP4 R0.w, vertex.position, c[8];
ADD R1.xyz, R0, -c[13];
MOV result.texcoord[0], R0;
DP3 R0.x, R1, R1;
RSQ R0.x, R0.x;
MOV result.texcoord[1].xyz, R2;
MOV result.texcoord[3], vertex.texcoord[0];
MUL result.texcoord[4].xyz, R0.x, R1;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 37 instructions, 5 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 12 [_WorldSpaceCameraPos]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Vector 13 [unity_SHAr]
Vector 14 [unity_SHAg]
Vector 15 [unity_SHAb]
Vector 16 [unity_SHBr]
Vector 17 [unity_SHBg]
Vector 18 [unity_SHBb]
Vector 19 [unity_SHC]
Float 20 [_SHLightingScale]
"vs_2_0
; 37 ALU
def c21, 0.00000000, 1.00000000, 0, 0
dcl_position0 v0
dcl_normal0 v1
dcl_texcoord0 v2
mul r0.xyz, v1.y, c9
mad r0.xyz, v1.x, c8, r0
mad r0.xyz, v1.z, c10, r0
add r0.xyz, r0, c21.x
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul r2.xyz, r0.w, r0
mul r0.x, r2.y, r2.y
mad r0.x, r2, r2, -r0
mul r3.xyz, r0.x, c19
mov r0.xyz, r2
mov r0.w, c21.y
dp4 r4.z, r0, c15
dp4 r4.y, r0, c14
dp4 r4.x, r0, c13
mul r1, r2.xyzz, r2.yzzx
dp4 r0.z, r1, c18
dp4 r0.x, r1, c16
dp4 r0.y, r1, c17
add r0.xyz, r4, r0
add r0.xyz, r0, r3
mul oT2.xyz, r0, c20.x
dp4 r0.x, v0, c4
dp4 r0.z, v0, c6
dp4 r0.y, v0, c5
dp4 r0.w, v0, c7
add r1.xyz, r0, -c12
mov oT0, r0
dp3 r0.x, r1, r1
rsq r0.x, r0.x
mov oT1.xyz, r2
mov oT3, v2
mul oT4.xyz, r0.x, r1
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_OFF" }
"!!GLES
#define SHADER_API_GLES 1
#define tex2D texture2D


#ifdef VERTEX
#define gl_ModelViewProjectionMatrix glstate_matrix_mvp
uniform mat4 glstate_matrix_mvp;

varying lowp vec3 xlv_TEXCOORD4;
varying mediump vec4 xlv_TEXCOORD3;
varying lowp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 unity_SHC;
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;

uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 _World2Object;
uniform lowp float _SHLightingScale;
uniform highp mat4 _Object2World;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  highp vec3 shl;
  lowp vec3 tmpvar_1;
  lowp vec3 tmpvar_2;
  lowp mat4 modelMatrixInverse;
  lowp mat4 modelMatrix;
  modelMatrix = (_Object2World);
  modelMatrixInverse = (_World2Object);
  lowp vec4 tmpvar_3;
  tmpvar_3.w = 0.0;
  tmpvar_3.xyz = normalize (_glesNormal);
  lowp vec3 tmpvar_4;
  tmpvar_4 = normalize ((tmpvar_3 * modelMatrixInverse).xyz);
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize (((modelMatrix * _glesVertex) - tmpvar_5).xyz);
  tmpvar_2 = tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = tmpvar_4;
  mediump vec3 tmpvar_8;
  mediump vec4 normal;
  normal = tmpvar_7;
  mediump vec3 x3;
  highp float vC;
  mediump vec3 x2;
  mediump vec3 x1;
  highp float tmpvar_9;
  tmpvar_9 = dot (unity_SHAr, normal);
  x1.x = tmpvar_9;
  highp float tmpvar_10;
  tmpvar_10 = dot (unity_SHAg, normal);
  x1.y = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = dot (unity_SHAb, normal);
  x1.z = tmpvar_11;
  mediump vec4 tmpvar_12;
  tmpvar_12 = (normal.xyzz * normal.yzzx);
  highp float tmpvar_13;
  tmpvar_13 = dot (unity_SHBr, tmpvar_12);
  x2.x = tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = dot (unity_SHBg, tmpvar_12);
  x2.y = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = dot (unity_SHBb, tmpvar_12);
  x2.z = tmpvar_15;
  mediump float tmpvar_16;
  tmpvar_16 = ((normal.x * normal.x) - (normal.y * normal.y));
  vC = tmpvar_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = (unity_SHC.xyz * vC);
  x3 = tmpvar_17;
  tmpvar_8 = ((x1 + x2) + x3);
  shl = tmpvar_8;
  highp vec3 tmpvar_18;
  tmpvar_18 = (shl * _SHLightingScale);
  tmpvar_1 = tmpvar_18;
  gl_Position = (gl_ModelViewProjectionMatrix * _glesVertex);
  xlv_TEXCOORD0 = (modelMatrix * _glesVertex);
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_1;
  xlv_TEXCOORD3 = _glesMultiTexCoord0;
  xlv_TEXCOORD4 = tmpvar_2;
}



#endif
#ifdef FRAGMENT
#define unity_LightColor0 _glesLightSource[0].diffuse
#define unity_LightColor1 _glesLightSource[1].diffuse
#define unity_LightColor2 _glesLightSource[2].diffuse
#define unity_LightColor3 _glesLightSource[3].diffuse
#define unity_LightPosition0 _glesLightSource[0].position
#define unity_LightPosition1 _glesLightSource[1].position
#define unity_LightPosition2 _glesLightSource[2].position
#define unity_LightPosition3 _glesLightSource[3].position
#define glstate_light0_spotDirection _glesLightSource[0].spotDirection
#define glstate_light1_spotDirection _glesLightSource[1].spotDirection
#define glstate_light2_spotDirection _glesLightSource[2].spotDirection
#define glstate_light3_spotDirection _glesLightSource[3].spotDirection
#define unity_LightAtten0 _glesLightSource[0].atten
#define unity_LightAtten1 _glesLightSource[1].atten
#define unity_LightAtten2 _glesLightSource[2].atten
#define unity_LightAtten3 _glesLightSource[3].atten
#define glstate_lightmodel_ambient _glesLightModel.ambient
#define gl_LightSource _glesLightSource
#define gl_LightSourceParameters _glesLightSourceParameters
struct _glesLightSourceParameters {
  vec4 diffuse;
  vec4 position;
  vec3 spotDirection;
  vec4 atten;
};
uniform _glesLightSourceParameters _glesLightSource[4];
#define gl_LightModel _glesLightModel
#define gl_LightModelParameters _glesLightModelParameters
struct _glesLightModelParameters {
  vec4 ambient;
};
uniform _glesLightModelParameters _glesLightModel;
#define gl_FrontMaterial _glesFrontMaterial
#define gl_BackMaterial _glesFrontMaterial
#define gl_MaterialParameters _glesMaterialParameters
struct _glesMaterialParameters {
  vec4 emission;
  vec4 ambient;
  vec4 diffuse;
  vec4 specular;
  float shininess;
};
uniform _glesMaterialParameters _glesFrontMaterial;

varying lowp vec3 xlv_TEXCOORD4;
varying mediump vec4 xlv_TEXCOORD3;
varying lowp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform lowp float _Reflection;

uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform lowp vec4 _SpecColor;
uniform mediump float _Shininess;
uniform sampler2D _MainTex;
uniform lowp vec4 _LightColor0;
uniform mediump float _Gloss;
uniform lowp float _FrezPow;
uniform mediump float _FrezFalloff;
uniform samplerCube _Cube;
uniform lowp vec4 _Color;
void main ()
{
  lowp float frez;
  lowp vec4 reflTex;
  lowp vec3 specularReflection;
  lowp vec3 ambientLighting;
  lowp vec3 vertexToLightSource;
  lowp vec3 lightDirection;
  lowp float attenuation;
  lowp vec3 viewDirection;
  lowp vec3 tmpvar_1;
  tmpvar_1 = normalize (xlv_TEXCOORD1);
  highp vec3 tmpvar_2;
  tmpvar_2 = normalize ((_WorldSpaceCameraPos - xlv_TEXCOORD0.xyz));
  viewDirection = tmpvar_2;
  mediump vec2 tmpvar_3;
  tmpvar_3 = xlv_TEXCOORD3.xy;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, tmpvar_3);
  if ((0.0 == _WorldSpaceLightPos0.w)) {
    attenuation = 1.0;
    lightDirection = normalize (_WorldSpaceLightPos0.xyz);
  } else {
    highp vec3 tmpvar_5;
    tmpvar_5 = (_WorldSpaceLightPos0 - xlv_TEXCOORD0).xyz;
    vertexToLightSource = tmpvar_5;
    attenuation = (1.0/(length (vertexToLightSource)));
    lightDirection = normalize (vertexToLightSource);
  };
  highp vec3 tmpvar_6;
  tmpvar_6 = (gl_LightModel.ambient.xyz * _Color.xyz);
  ambientLighting = tmpvar_6;
  lowp vec3 tmpvar_7;
  tmpvar_7 = (((attenuation * _LightColor0.xyz) * _Color.xyz) * max (0.0, dot (tmpvar_1, lightDirection)));
  lowp float tmpvar_8;
  tmpvar_8 = dot (tmpvar_1, lightDirection);
  if ((tmpvar_8 < 0.0)) {
    specularReflection = vec3(0.0, 0.0, 0.0);
  } else {
    lowp float tmpvar_9;
    tmpvar_9 = max (0.0, dot (reflect (-(lightDirection), tmpvar_1), viewDirection));
    mediump vec3 tmpvar_10;
    tmpvar_10 = (((attenuation * _LightColor0.xyz) * _SpecColor.xyz) * pow (tmpvar_9, _Shininess));
    specularReflection = tmpvar_10;
  };
  mediump vec3 tmpvar_11;
  tmpvar_11 = (specularReflection * _Gloss);
  specularReflection = tmpvar_11;
  lowp vec3 tmpvar_12;
  tmpvar_12 = reflect (xlv_TEXCOORD4, normalize (xlv_TEXCOORD1));
  lowp vec4 tmpvar_13;
  tmpvar_13 = textureCube (_Cube, tmpvar_12);
  reflTex = tmpvar_13;
  lowp float tmpvar_14;
  tmpvar_14 = clamp (abs (dot (tmpvar_12, xlv_TEXCOORD1)), 0.0, 1.0);
  mediump float tmpvar_15;
  tmpvar_15 = pow ((1.0 - tmpvar_14), _FrezFalloff);
  frez = tmpvar_15;
  lowp float tmpvar_16;
  tmpvar_16 = (frez * _FrezPow);
  frez = tmpvar_16;
  reflTex.xyz = (tmpvar_13.xyz * clamp ((_Reflection + tmpvar_16), 0.0, 1.0));
  lowp vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = ((tmpvar_4.xyz * clamp (((xlv_TEXCOORD2 + ambientLighting) + tmpvar_7), 0.0, 1.0)) + specularReflection);
  gl_FragData[0] = ((tmpvar_17 + reflTex) + (tmpvar_16 * reflTex));
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_OFF" }
"!!GLES
#define SHADER_API_GLES 1
#define tex2D texture2D


#ifdef VERTEX
#define gl_ModelViewProjectionMatrix glstate_matrix_mvp
uniform mat4 glstate_matrix_mvp;

varying lowp vec3 xlv_TEXCOORD4;
varying mediump vec4 xlv_TEXCOORD3;
varying lowp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 unity_SHC;
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;

uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 _World2Object;
uniform lowp float _SHLightingScale;
uniform highp mat4 _Object2World;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  highp vec3 shl;
  lowp vec3 tmpvar_1;
  lowp vec3 tmpvar_2;
  lowp mat4 modelMatrixInverse;
  lowp mat4 modelMatrix;
  modelMatrix = (_Object2World);
  modelMatrixInverse = (_World2Object);
  lowp vec4 tmpvar_3;
  tmpvar_3.w = 0.0;
  tmpvar_3.xyz = normalize (_glesNormal);
  lowp vec3 tmpvar_4;
  tmpvar_4 = normalize ((tmpvar_3 * modelMatrixInverse).xyz);
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize (((modelMatrix * _glesVertex) - tmpvar_5).xyz);
  tmpvar_2 = tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = tmpvar_4;
  mediump vec3 tmpvar_8;
  mediump vec4 normal;
  normal = tmpvar_7;
  mediump vec3 x3;
  highp float vC;
  mediump vec3 x2;
  mediump vec3 x1;
  highp float tmpvar_9;
  tmpvar_9 = dot (unity_SHAr, normal);
  x1.x = tmpvar_9;
  highp float tmpvar_10;
  tmpvar_10 = dot (unity_SHAg, normal);
  x1.y = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = dot (unity_SHAb, normal);
  x1.z = tmpvar_11;
  mediump vec4 tmpvar_12;
  tmpvar_12 = (normal.xyzz * normal.yzzx);
  highp float tmpvar_13;
  tmpvar_13 = dot (unity_SHBr, tmpvar_12);
  x2.x = tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = dot (unity_SHBg, tmpvar_12);
  x2.y = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = dot (unity_SHBb, tmpvar_12);
  x2.z = tmpvar_15;
  mediump float tmpvar_16;
  tmpvar_16 = ((normal.x * normal.x) - (normal.y * normal.y));
  vC = tmpvar_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = (unity_SHC.xyz * vC);
  x3 = tmpvar_17;
  tmpvar_8 = ((x1 + x2) + x3);
  shl = tmpvar_8;
  highp vec3 tmpvar_18;
  tmpvar_18 = (shl * _SHLightingScale);
  tmpvar_1 = tmpvar_18;
  gl_Position = (gl_ModelViewProjectionMatrix * _glesVertex);
  xlv_TEXCOORD0 = (modelMatrix * _glesVertex);
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_1;
  xlv_TEXCOORD3 = _glesMultiTexCoord0;
  xlv_TEXCOORD4 = tmpvar_2;
}



#endif
#ifdef FRAGMENT
#define unity_LightColor0 _glesLightSource[0].diffuse
#define unity_LightColor1 _glesLightSource[1].diffuse
#define unity_LightColor2 _glesLightSource[2].diffuse
#define unity_LightColor3 _glesLightSource[3].diffuse
#define unity_LightPosition0 _glesLightSource[0].position
#define unity_LightPosition1 _glesLightSource[1].position
#define unity_LightPosition2 _glesLightSource[2].position
#define unity_LightPosition3 _glesLightSource[3].position
#define glstate_light0_spotDirection _glesLightSource[0].spotDirection
#define glstate_light1_spotDirection _glesLightSource[1].spotDirection
#define glstate_light2_spotDirection _glesLightSource[2].spotDirection
#define glstate_light3_spotDirection _glesLightSource[3].spotDirection
#define unity_LightAtten0 _glesLightSource[0].atten
#define unity_LightAtten1 _glesLightSource[1].atten
#define unity_LightAtten2 _glesLightSource[2].atten
#define unity_LightAtten3 _glesLightSource[3].atten
#define glstate_lightmodel_ambient _glesLightModel.ambient
#define gl_LightSource _glesLightSource
#define gl_LightSourceParameters _glesLightSourceParameters
struct _glesLightSourceParameters {
  vec4 diffuse;
  vec4 position;
  vec3 spotDirection;
  vec4 atten;
};
uniform _glesLightSourceParameters _glesLightSource[4];
#define gl_LightModel _glesLightModel
#define gl_LightModelParameters _glesLightModelParameters
struct _glesLightModelParameters {
  vec4 ambient;
};
uniform _glesLightModelParameters _glesLightModel;
#define gl_FrontMaterial _glesFrontMaterial
#define gl_BackMaterial _glesFrontMaterial
#define gl_MaterialParameters _glesMaterialParameters
struct _glesMaterialParameters {
  vec4 emission;
  vec4 ambient;
  vec4 diffuse;
  vec4 specular;
  float shininess;
};
uniform _glesMaterialParameters _glesFrontMaterial;

varying lowp vec3 xlv_TEXCOORD4;
varying mediump vec4 xlv_TEXCOORD3;
varying lowp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform lowp float _Reflection;

uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform lowp vec4 _SpecColor;
uniform mediump float _Shininess;
uniform sampler2D _MainTex;
uniform lowp vec4 _LightColor0;
uniform mediump float _Gloss;
uniform lowp float _FrezPow;
uniform mediump float _FrezFalloff;
uniform samplerCube _Cube;
uniform lowp vec4 _Color;
void main ()
{
  lowp float frez;
  lowp vec4 reflTex;
  lowp vec3 specularReflection;
  lowp vec3 ambientLighting;
  lowp vec3 vertexToLightSource;
  lowp vec3 lightDirection;
  lowp float attenuation;
  lowp vec3 viewDirection;
  lowp vec3 tmpvar_1;
  tmpvar_1 = normalize (xlv_TEXCOORD1);
  highp vec3 tmpvar_2;
  tmpvar_2 = normalize ((_WorldSpaceCameraPos - xlv_TEXCOORD0.xyz));
  viewDirection = tmpvar_2;
  mediump vec2 tmpvar_3;
  tmpvar_3 = xlv_TEXCOORD3.xy;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, tmpvar_3);
  if ((0.0 == _WorldSpaceLightPos0.w)) {
    attenuation = 1.0;
    lightDirection = normalize (_WorldSpaceLightPos0.xyz);
  } else {
    highp vec3 tmpvar_5;
    tmpvar_5 = (_WorldSpaceLightPos0 - xlv_TEXCOORD0).xyz;
    vertexToLightSource = tmpvar_5;
    attenuation = (1.0/(length (vertexToLightSource)));
    lightDirection = normalize (vertexToLightSource);
  };
  highp vec3 tmpvar_6;
  tmpvar_6 = (gl_LightModel.ambient.xyz * _Color.xyz);
  ambientLighting = tmpvar_6;
  lowp vec3 tmpvar_7;
  tmpvar_7 = (((attenuation * _LightColor0.xyz) * _Color.xyz) * max (0.0, dot (tmpvar_1, lightDirection)));
  lowp float tmpvar_8;
  tmpvar_8 = dot (tmpvar_1, lightDirection);
  if ((tmpvar_8 < 0.0)) {
    specularReflection = vec3(0.0, 0.0, 0.0);
  } else {
    lowp float tmpvar_9;
    tmpvar_9 = max (0.0, dot (reflect (-(lightDirection), tmpvar_1), viewDirection));
    mediump vec3 tmpvar_10;
    tmpvar_10 = (((attenuation * _LightColor0.xyz) * _SpecColor.xyz) * pow (tmpvar_9, _Shininess));
    specularReflection = tmpvar_10;
  };
  mediump vec3 tmpvar_11;
  tmpvar_11 = (specularReflection * _Gloss);
  specularReflection = tmpvar_11;
  lowp vec3 tmpvar_12;
  tmpvar_12 = reflect (xlv_TEXCOORD4, normalize (xlv_TEXCOORD1));
  lowp vec4 tmpvar_13;
  tmpvar_13 = textureCube (_Cube, tmpvar_12);
  reflTex = tmpvar_13;
  lowp float tmpvar_14;
  tmpvar_14 = clamp (abs (dot (tmpvar_12, xlv_TEXCOORD1)), 0.0, 1.0);
  mediump float tmpvar_15;
  tmpvar_15 = pow ((1.0 - tmpvar_14), _FrezFalloff);
  frez = tmpvar_15;
  lowp float tmpvar_16;
  tmpvar_16 = (frez * _FrezPow);
  frez = tmpvar_16;
  reflTex.xyz = (tmpvar_13.xyz * clamp ((_Reflection + tmpvar_16), 0.0, 1.0));
  lowp vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = ((tmpvar_4.xyz * clamp (((xlv_TEXCOORD2 + ambientLighting) + tmpvar_7), 0.0, 1.0)) + specularReflection);
  gl_FragData[0] = ((tmpvar_17 + reflTex) + (tmpvar_16 * reflTex));
}



#endif"
}

SubProgram "flash " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 12 [_WorldSpaceCameraPos]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Vector 13 [unity_SHAr]
Vector 14 [unity_SHAg]
Vector 15 [unity_SHAb]
Vector 16 [unity_SHBr]
Vector 17 [unity_SHBg]
Vector 18 [unity_SHBb]
Vector 19 [unity_SHC]
Float 20 [_SHLightingScale]
"agal_vs
c21 0.0 1.0 0.0 0.0
[bc]
adaaaaaaaaaaahacabaaaaffaaaaaaaaajaaaaoeabaaaaaa mul r0.xyz, a1.y, c9
adaaaaaaabaaahacabaaaaaaaaaaaaaaaiaaaaoeabaaaaaa mul r1.xyz, a1.x, c8
abaaaaaaaaaaahacabaaaakeacaaaaaaaaaaaakeacaaaaaa add r0.xyz, r1.xyzz, r0.xyzz
adaaaaaaacaaahacabaaaakkaaaaaaaaakaaaaoeabaaaaaa mul r2.xyz, a1.z, c10
abaaaaaaaaaaahacacaaaakeacaaaaaaaaaaaakeacaaaaaa add r0.xyz, r2.xyzz, r0.xyzz
abaaaaaaaaaaahacaaaaaakeacaaaaaabfaaaaaaabaaaaaa add r0.xyz, r0.xyzz, c21.x
bcaaaaaaaaaaaiacaaaaaakeacaaaaaaaaaaaakeacaaaaaa dp3 r0.w, r0.xyzz, r0.xyzz
akaaaaaaaaaaaiacaaaaaappacaaaaaaaaaaaaaaaaaaaaaa rsq r0.w, r0.w
adaaaaaaacaaahacaaaaaappacaaaaaaaaaaaakeacaaaaaa mul r2.xyz, r0.w, r0.xyzz
adaaaaaaaaaaabacacaaaaffacaaaaaaacaaaaffacaaaaaa mul r0.x, r2.y, r2.y
adaaaaaaacaaaiacacaaaaaaacaaaaaaacaaaaaaacaaaaaa mul r2.w, r2.x, r2.x
acaaaaaaaaaaabacacaaaappacaaaaaaaaaaaaaaacaaaaaa sub r0.x, r2.w, r0.x
adaaaaaaadaaahacaaaaaaaaacaaaaaabdaaaaoeabaaaaaa mul r3.xyz, r0.x, c19
aaaaaaaaaaaaahacacaaaakeacaaaaaaaaaaaaaaaaaaaaaa mov r0.xyz, r2.xyzz
aaaaaaaaaaaaaiacbfaaaaffabaaaaaaaaaaaaaaaaaaaaaa mov r0.w, c21.y
bdaaaaaaaeaaaeacaaaaaaoeacaaaaaaapaaaaoeabaaaaaa dp4 r4.z, r0, c15
bdaaaaaaaeaaacacaaaaaaoeacaaaaaaaoaaaaoeabaaaaaa dp4 r4.y, r0, c14
bdaaaaaaaeaaabacaaaaaaoeacaaaaaaanaaaaoeabaaaaaa dp4 r4.x, r0, c13
adaaaaaaabaaapacacaaaakeacaaaaaaacaaaacjacaaaaaa mul r1, r2.xyzz, r2.yzzx
bdaaaaaaaaaaaeacabaaaaoeacaaaaaabcaaaaoeabaaaaaa dp4 r0.z, r1, c18
bdaaaaaaaaaaabacabaaaaoeacaaaaaabaaaaaoeabaaaaaa dp4 r0.x, r1, c16
bdaaaaaaaaaaacacabaaaaoeacaaaaaabbaaaaoeabaaaaaa dp4 r0.y, r1, c17
abaaaaaaaaaaahacaeaaaakeacaaaaaaaaaaaakeacaaaaaa add r0.xyz, r4.xyzz, r0.xyzz
abaaaaaaaaaaahacaaaaaakeacaaaaaaadaaaakeacaaaaaa add r0.xyz, r0.xyzz, r3.xyzz
adaaaaaaacaaahaeaaaaaakeacaaaaaabeaaaaaaabaaaaaa mul v2.xyz, r0.xyzz, c20.x
bdaaaaaaaaaaabacaaaaaaoeaaaaaaaaaeaaaaoeabaaaaaa dp4 r0.x, a0, c4
bdaaaaaaaaaaaeacaaaaaaoeaaaaaaaaagaaaaoeabaaaaaa dp4 r0.z, a0, c6
bdaaaaaaaaaaacacaaaaaaoeaaaaaaaaafaaaaoeabaaaaaa dp4 r0.y, a0, c5
bdaaaaaaaaaaaiacaaaaaaoeaaaaaaaaahaaaaoeabaaaaaa dp4 r0.w, a0, c7
acaaaaaaabaaahacaaaaaakeacaaaaaaamaaaaoeabaaaaaa sub r1.xyz, r0.xyzz, c12
aaaaaaaaaaaaapaeaaaaaaoeacaaaaaaaaaaaaaaaaaaaaaa mov v0, r0
bcaaaaaaaaaaabacabaaaakeacaaaaaaabaaaakeacaaaaaa dp3 r0.x, r1.xyzz, r1.xyzz
akaaaaaaaaaaabacaaaaaaaaacaaaaaaaaaaaaaaaaaaaaaa rsq r0.x, r0.x
aaaaaaaaabaaahaeacaaaakeacaaaaaaaaaaaaaaaaaaaaaa mov v1.xyz, r2.xyzz
aaaaaaaaadaaapaeadaaaaoeaaaaaaaaaaaaaaaaaaaaaaaa mov v3, a3
adaaaaaaaeaaahaeaaaaaaaaacaaaaaaabaaaakeacaaaaaa mul v4.xyz, r0.x, r1.xyzz
bdaaaaaaaaaaaiadaaaaaaoeaaaaaaaaadaaaaoeabaaaaaa dp4 o0.w, a0, c3
bdaaaaaaaaaaaeadaaaaaaoeaaaaaaaaacaaaaoeabaaaaaa dp4 o0.z, a0, c2
bdaaaaaaaaaaacadaaaaaaoeaaaaaaaaabaaaaoeabaaaaaa dp4 o0.y, a0, c1
bdaaaaaaaaaaabadaaaaaaoeaaaaaaaaaaaaaaoeabaaaaaa dp4 o0.x, a0, c0
aaaaaaaaabaaaiaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v1.w, c0
aaaaaaaaacaaaiaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v2.w, c0
aaaaaaaaaeaaaiaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v4.w, c0
"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Vector 13 [_WorldSpaceCameraPos]
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Vector 14 [unity_SHAr]
Vector 15 [unity_SHAg]
Vector 16 [unity_SHAb]
Vector 17 [unity_SHBr]
Vector 18 [unity_SHBg]
Vector 19 [unity_SHBb]
Vector 20 [unity_SHC]
Float 21 [_SHLightingScale]
"!!ARBvp1.0
# 37 ALU
PARAM c[22] = { { 0, 1 },
		state.matrix.mvp,
		program.local[5..21] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
MUL R0.xyz, vertex.normal.y, c[10];
MAD R0.xyz, vertex.normal.x, c[9], R0;
MAD R0.xyz, vertex.normal.z, c[11], R0;
ADD R0.xyz, R0, c[0].x;
DP3 R0.w, R0, R0;
RSQ R0.w, R0.w;
MUL R2.xyz, R0.w, R0;
MUL R0.x, R2.y, R2.y;
MAD R0.x, R2, R2, -R0;
MUL R3.xyz, R0.x, c[20];
MOV R0.xyz, R2;
MOV R0.w, c[0].y;
DP4 R4.z, R0, c[16];
DP4 R4.y, R0, c[15];
DP4 R4.x, R0, c[14];
MUL R1, R2.xyzz, R2.yzzx;
DP4 R0.z, R1, c[19];
DP4 R0.x, R1, c[17];
DP4 R0.y, R1, c[18];
ADD R0.xyz, R4, R0;
ADD R0.xyz, R0, R3;
MUL result.texcoord[2].xyz, R0, c[21].x;
DP4 R0.x, vertex.position, c[5];
DP4 R0.z, vertex.position, c[7];
DP4 R0.y, vertex.position, c[6];
DP4 R0.w, vertex.position, c[8];
ADD R1.xyz, R0, -c[13];
MOV result.texcoord[0], R0;
DP3 R0.x, R1, R1;
RSQ R0.x, R0.x;
MOV result.texcoord[1].xyz, R2;
MOV result.texcoord[3], vertex.texcoord[0];
MUL result.texcoord[4].xyz, R0.x, R1;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 37 instructions, 5 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 12 [_WorldSpaceCameraPos]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Vector 13 [unity_SHAr]
Vector 14 [unity_SHAg]
Vector 15 [unity_SHAb]
Vector 16 [unity_SHBr]
Vector 17 [unity_SHBg]
Vector 18 [unity_SHBb]
Vector 19 [unity_SHC]
Float 20 [_SHLightingScale]
"vs_2_0
; 37 ALU
def c21, 0.00000000, 1.00000000, 0, 0
dcl_position0 v0
dcl_normal0 v1
dcl_texcoord0 v2
mul r0.xyz, v1.y, c9
mad r0.xyz, v1.x, c8, r0
mad r0.xyz, v1.z, c10, r0
add r0.xyz, r0, c21.x
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul r2.xyz, r0.w, r0
mul r0.x, r2.y, r2.y
mad r0.x, r2, r2, -r0
mul r3.xyz, r0.x, c19
mov r0.xyz, r2
mov r0.w, c21.y
dp4 r4.z, r0, c15
dp4 r4.y, r0, c14
dp4 r4.x, r0, c13
mul r1, r2.xyzz, r2.yzzx
dp4 r0.z, r1, c18
dp4 r0.x, r1, c16
dp4 r0.y, r1, c17
add r0.xyz, r4, r0
add r0.xyz, r0, r3
mul oT2.xyz, r0, c20.x
dp4 r0.x, v0, c4
dp4 r0.z, v0, c6
dp4 r0.y, v0, c5
dp4 r0.w, v0, c7
add r1.xyz, r0, -c12
mov oT0, r0
dp3 r0.x, r1, r1
rsq r0.x, r0.x
mov oT1.xyz, r2
mov oT3, v2
mul oT4.xyz, r0.x, r1
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
"!!GLES
#define SHADER_API_GLES 1
#define tex2D texture2D


#ifdef VERTEX
#define gl_ModelViewProjectionMatrix glstate_matrix_mvp
uniform mat4 glstate_matrix_mvp;

varying lowp vec3 xlv_TEXCOORD4;
varying mediump vec4 xlv_TEXCOORD3;
varying lowp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 unity_SHC;
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;

uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 _World2Object;
uniform lowp float _SHLightingScale;
uniform highp mat4 _Object2World;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  highp vec3 shl;
  lowp vec3 tmpvar_1;
  lowp vec3 tmpvar_2;
  lowp mat4 modelMatrixInverse;
  lowp mat4 modelMatrix;
  modelMatrix = (_Object2World);
  modelMatrixInverse = (_World2Object);
  lowp vec4 tmpvar_3;
  tmpvar_3.w = 0.0;
  tmpvar_3.xyz = normalize (_glesNormal);
  lowp vec3 tmpvar_4;
  tmpvar_4 = normalize ((tmpvar_3 * modelMatrixInverse).xyz);
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize (((modelMatrix * _glesVertex) - tmpvar_5).xyz);
  tmpvar_2 = tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = tmpvar_4;
  mediump vec3 tmpvar_8;
  mediump vec4 normal;
  normal = tmpvar_7;
  mediump vec3 x3;
  highp float vC;
  mediump vec3 x2;
  mediump vec3 x1;
  highp float tmpvar_9;
  tmpvar_9 = dot (unity_SHAr, normal);
  x1.x = tmpvar_9;
  highp float tmpvar_10;
  tmpvar_10 = dot (unity_SHAg, normal);
  x1.y = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = dot (unity_SHAb, normal);
  x1.z = tmpvar_11;
  mediump vec4 tmpvar_12;
  tmpvar_12 = (normal.xyzz * normal.yzzx);
  highp float tmpvar_13;
  tmpvar_13 = dot (unity_SHBr, tmpvar_12);
  x2.x = tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = dot (unity_SHBg, tmpvar_12);
  x2.y = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = dot (unity_SHBb, tmpvar_12);
  x2.z = tmpvar_15;
  mediump float tmpvar_16;
  tmpvar_16 = ((normal.x * normal.x) - (normal.y * normal.y));
  vC = tmpvar_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = (unity_SHC.xyz * vC);
  x3 = tmpvar_17;
  tmpvar_8 = ((x1 + x2) + x3);
  shl = tmpvar_8;
  highp vec3 tmpvar_18;
  tmpvar_18 = (shl * _SHLightingScale);
  tmpvar_1 = tmpvar_18;
  gl_Position = (gl_ModelViewProjectionMatrix * _glesVertex);
  xlv_TEXCOORD0 = (modelMatrix * _glesVertex);
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_1;
  xlv_TEXCOORD3 = _glesMultiTexCoord0;
  xlv_TEXCOORD4 = tmpvar_2;
}



#endif
#ifdef FRAGMENT
#define unity_LightColor0 _glesLightSource[0].diffuse
#define unity_LightColor1 _glesLightSource[1].diffuse
#define unity_LightColor2 _glesLightSource[2].diffuse
#define unity_LightColor3 _glesLightSource[3].diffuse
#define unity_LightPosition0 _glesLightSource[0].position
#define unity_LightPosition1 _glesLightSource[1].position
#define unity_LightPosition2 _glesLightSource[2].position
#define unity_LightPosition3 _glesLightSource[3].position
#define glstate_light0_spotDirection _glesLightSource[0].spotDirection
#define glstate_light1_spotDirection _glesLightSource[1].spotDirection
#define glstate_light2_spotDirection _glesLightSource[2].spotDirection
#define glstate_light3_spotDirection _glesLightSource[3].spotDirection
#define unity_LightAtten0 _glesLightSource[0].atten
#define unity_LightAtten1 _glesLightSource[1].atten
#define unity_LightAtten2 _glesLightSource[2].atten
#define unity_LightAtten3 _glesLightSource[3].atten
#define glstate_lightmodel_ambient _glesLightModel.ambient
#define gl_LightSource _glesLightSource
#define gl_LightSourceParameters _glesLightSourceParameters
struct _glesLightSourceParameters {
  vec4 diffuse;
  vec4 position;
  vec3 spotDirection;
  vec4 atten;
};
uniform _glesLightSourceParameters _glesLightSource[4];
#define gl_LightModel _glesLightModel
#define gl_LightModelParameters _glesLightModelParameters
struct _glesLightModelParameters {
  vec4 ambient;
};
uniform _glesLightModelParameters _glesLightModel;
#define gl_FrontMaterial _glesFrontMaterial
#define gl_BackMaterial _glesFrontMaterial
#define gl_MaterialParameters _glesMaterialParameters
struct _glesMaterialParameters {
  vec4 emission;
  vec4 ambient;
  vec4 diffuse;
  vec4 specular;
  float shininess;
};
uniform _glesMaterialParameters _glesFrontMaterial;

varying lowp vec3 xlv_TEXCOORD4;
varying mediump vec4 xlv_TEXCOORD3;
varying lowp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform lowp float _Reflection;

uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform lowp vec4 _SpecColor;
uniform mediump float _Shininess;
uniform sampler2D _MainTex;
uniform lowp vec4 _LightColor0;
uniform mediump float _Gloss;
uniform lowp float _FrezPow;
uniform mediump float _FrezFalloff;
uniform samplerCube _Cube;
uniform lowp vec4 _Color;
void main ()
{
  lowp float frez;
  lowp vec4 reflTex;
  lowp vec3 specularReflection;
  lowp vec3 ambientLighting;
  lowp vec3 vertexToLightSource;
  lowp vec3 lightDirection;
  lowp float attenuation;
  lowp vec3 viewDirection;
  lowp vec3 tmpvar_1;
  tmpvar_1 = normalize (xlv_TEXCOORD1);
  highp vec3 tmpvar_2;
  tmpvar_2 = normalize ((_WorldSpaceCameraPos - xlv_TEXCOORD0.xyz));
  viewDirection = tmpvar_2;
  mediump vec2 tmpvar_3;
  tmpvar_3 = xlv_TEXCOORD3.xy;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, tmpvar_3);
  if ((0.0 == _WorldSpaceLightPos0.w)) {
    attenuation = 1.0;
    lightDirection = normalize (_WorldSpaceLightPos0.xyz);
  } else {
    highp vec3 tmpvar_5;
    tmpvar_5 = (_WorldSpaceLightPos0 - xlv_TEXCOORD0).xyz;
    vertexToLightSource = tmpvar_5;
    attenuation = (1.0/(length (vertexToLightSource)));
    lightDirection = normalize (vertexToLightSource);
  };
  highp vec3 tmpvar_6;
  tmpvar_6 = (gl_LightModel.ambient.xyz * _Color.xyz);
  ambientLighting = tmpvar_6;
  lowp vec3 tmpvar_7;
  tmpvar_7 = (((attenuation * _LightColor0.xyz) * _Color.xyz) * max (0.0, dot (tmpvar_1, lightDirection)));
  lowp float tmpvar_8;
  tmpvar_8 = dot (tmpvar_1, lightDirection);
  if ((tmpvar_8 < 0.0)) {
    specularReflection = vec3(0.0, 0.0, 0.0);
  } else {
    lowp float tmpvar_9;
    tmpvar_9 = max (0.0, dot (reflect (-(lightDirection), tmpvar_1), viewDirection));
    mediump vec3 tmpvar_10;
    tmpvar_10 = (((attenuation * _LightColor0.xyz) * _SpecColor.xyz) * pow (tmpvar_9, _Shininess));
    specularReflection = tmpvar_10;
  };
  mediump vec3 tmpvar_11;
  tmpvar_11 = (specularReflection * _Gloss);
  specularReflection = tmpvar_11;
  lowp vec3 tmpvar_12;
  tmpvar_12 = reflect (xlv_TEXCOORD4, normalize (xlv_TEXCOORD1));
  lowp vec4 tmpvar_13;
  tmpvar_13 = textureCube (_Cube, tmpvar_12);
  reflTex = tmpvar_13;
  lowp float tmpvar_14;
  tmpvar_14 = clamp (abs (dot (tmpvar_12, xlv_TEXCOORD1)), 0.0, 1.0);
  mediump float tmpvar_15;
  tmpvar_15 = pow ((1.0 - tmpvar_14), _FrezFalloff);
  frez = tmpvar_15;
  lowp float tmpvar_16;
  tmpvar_16 = (frez * _FrezPow);
  frez = tmpvar_16;
  reflTex.xyz = (tmpvar_13.xyz * clamp ((_Reflection + tmpvar_16), 0.0, 1.0));
  lowp vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = ((tmpvar_4.xyz * clamp (((xlv_TEXCOORD2 + ambientLighting) + tmpvar_7), 0.0, 1.0)) + specularReflection);
  gl_FragData[0] = ((tmpvar_17 + reflTex) + (tmpvar_16 * reflTex));
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
"!!GLES
#define SHADER_API_GLES 1
#define tex2D texture2D


#ifdef VERTEX
#define gl_ModelViewProjectionMatrix glstate_matrix_mvp
uniform mat4 glstate_matrix_mvp;

varying lowp vec3 xlv_TEXCOORD4;
varying mediump vec4 xlv_TEXCOORD3;
varying lowp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 unity_SHC;
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;

uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 _World2Object;
uniform lowp float _SHLightingScale;
uniform highp mat4 _Object2World;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  highp vec3 shl;
  lowp vec3 tmpvar_1;
  lowp vec3 tmpvar_2;
  lowp mat4 modelMatrixInverse;
  lowp mat4 modelMatrix;
  modelMatrix = (_Object2World);
  modelMatrixInverse = (_World2Object);
  lowp vec4 tmpvar_3;
  tmpvar_3.w = 0.0;
  tmpvar_3.xyz = normalize (_glesNormal);
  lowp vec3 tmpvar_4;
  tmpvar_4 = normalize ((tmpvar_3 * modelMatrixInverse).xyz);
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize (((modelMatrix * _glesVertex) - tmpvar_5).xyz);
  tmpvar_2 = tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = tmpvar_4;
  mediump vec3 tmpvar_8;
  mediump vec4 normal;
  normal = tmpvar_7;
  mediump vec3 x3;
  highp float vC;
  mediump vec3 x2;
  mediump vec3 x1;
  highp float tmpvar_9;
  tmpvar_9 = dot (unity_SHAr, normal);
  x1.x = tmpvar_9;
  highp float tmpvar_10;
  tmpvar_10 = dot (unity_SHAg, normal);
  x1.y = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = dot (unity_SHAb, normal);
  x1.z = tmpvar_11;
  mediump vec4 tmpvar_12;
  tmpvar_12 = (normal.xyzz * normal.yzzx);
  highp float tmpvar_13;
  tmpvar_13 = dot (unity_SHBr, tmpvar_12);
  x2.x = tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = dot (unity_SHBg, tmpvar_12);
  x2.y = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = dot (unity_SHBb, tmpvar_12);
  x2.z = tmpvar_15;
  mediump float tmpvar_16;
  tmpvar_16 = ((normal.x * normal.x) - (normal.y * normal.y));
  vC = tmpvar_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = (unity_SHC.xyz * vC);
  x3 = tmpvar_17;
  tmpvar_8 = ((x1 + x2) + x3);
  shl = tmpvar_8;
  highp vec3 tmpvar_18;
  tmpvar_18 = (shl * _SHLightingScale);
  tmpvar_1 = tmpvar_18;
  gl_Position = (gl_ModelViewProjectionMatrix * _glesVertex);
  xlv_TEXCOORD0 = (modelMatrix * _glesVertex);
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_1;
  xlv_TEXCOORD3 = _glesMultiTexCoord0;
  xlv_TEXCOORD4 = tmpvar_2;
}



#endif
#ifdef FRAGMENT
#define unity_LightColor0 _glesLightSource[0].diffuse
#define unity_LightColor1 _glesLightSource[1].diffuse
#define unity_LightColor2 _glesLightSource[2].diffuse
#define unity_LightColor3 _glesLightSource[3].diffuse
#define unity_LightPosition0 _glesLightSource[0].position
#define unity_LightPosition1 _glesLightSource[1].position
#define unity_LightPosition2 _glesLightSource[2].position
#define unity_LightPosition3 _glesLightSource[3].position
#define glstate_light0_spotDirection _glesLightSource[0].spotDirection
#define glstate_light1_spotDirection _glesLightSource[1].spotDirection
#define glstate_light2_spotDirection _glesLightSource[2].spotDirection
#define glstate_light3_spotDirection _glesLightSource[3].spotDirection
#define unity_LightAtten0 _glesLightSource[0].atten
#define unity_LightAtten1 _glesLightSource[1].atten
#define unity_LightAtten2 _glesLightSource[2].atten
#define unity_LightAtten3 _glesLightSource[3].atten
#define glstate_lightmodel_ambient _glesLightModel.ambient
#define gl_LightSource _glesLightSource
#define gl_LightSourceParameters _glesLightSourceParameters
struct _glesLightSourceParameters {
  vec4 diffuse;
  vec4 position;
  vec3 spotDirection;
  vec4 atten;
};
uniform _glesLightSourceParameters _glesLightSource[4];
#define gl_LightModel _glesLightModel
#define gl_LightModelParameters _glesLightModelParameters
struct _glesLightModelParameters {
  vec4 ambient;
};
uniform _glesLightModelParameters _glesLightModel;
#define gl_FrontMaterial _glesFrontMaterial
#define gl_BackMaterial _glesFrontMaterial
#define gl_MaterialParameters _glesMaterialParameters
struct _glesMaterialParameters {
  vec4 emission;
  vec4 ambient;
  vec4 diffuse;
  vec4 specular;
  float shininess;
};
uniform _glesMaterialParameters _glesFrontMaterial;

varying lowp vec3 xlv_TEXCOORD4;
varying mediump vec4 xlv_TEXCOORD3;
varying lowp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform lowp float _Reflection;

uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform lowp vec4 _SpecColor;
uniform mediump float _Shininess;
uniform sampler2D _MainTex;
uniform lowp vec4 _LightColor0;
uniform mediump float _Gloss;
uniform lowp float _FrezPow;
uniform mediump float _FrezFalloff;
uniform samplerCube _Cube;
uniform lowp vec4 _Color;
void main ()
{
  lowp float frez;
  lowp vec4 reflTex;
  lowp vec3 specularReflection;
  lowp vec3 ambientLighting;
  lowp vec3 vertexToLightSource;
  lowp vec3 lightDirection;
  lowp float attenuation;
  lowp vec3 viewDirection;
  lowp vec3 tmpvar_1;
  tmpvar_1 = normalize (xlv_TEXCOORD1);
  highp vec3 tmpvar_2;
  tmpvar_2 = normalize ((_WorldSpaceCameraPos - xlv_TEXCOORD0.xyz));
  viewDirection = tmpvar_2;
  mediump vec2 tmpvar_3;
  tmpvar_3 = xlv_TEXCOORD3.xy;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, tmpvar_3);
  if ((0.0 == _WorldSpaceLightPos0.w)) {
    attenuation = 1.0;
    lightDirection = normalize (_WorldSpaceLightPos0.xyz);
  } else {
    highp vec3 tmpvar_5;
    tmpvar_5 = (_WorldSpaceLightPos0 - xlv_TEXCOORD0).xyz;
    vertexToLightSource = tmpvar_5;
    attenuation = (1.0/(length (vertexToLightSource)));
    lightDirection = normalize (vertexToLightSource);
  };
  highp vec3 tmpvar_6;
  tmpvar_6 = (gl_LightModel.ambient.xyz * _Color.xyz);
  ambientLighting = tmpvar_6;
  lowp vec3 tmpvar_7;
  tmpvar_7 = (((attenuation * _LightColor0.xyz) * _Color.xyz) * max (0.0, dot (tmpvar_1, lightDirection)));
  lowp float tmpvar_8;
  tmpvar_8 = dot (tmpvar_1, lightDirection);
  if ((tmpvar_8 < 0.0)) {
    specularReflection = vec3(0.0, 0.0, 0.0);
  } else {
    lowp float tmpvar_9;
    tmpvar_9 = max (0.0, dot (reflect (-(lightDirection), tmpvar_1), viewDirection));
    mediump vec3 tmpvar_10;
    tmpvar_10 = (((attenuation * _LightColor0.xyz) * _SpecColor.xyz) * pow (tmpvar_9, _Shininess));
    specularReflection = tmpvar_10;
  };
  mediump vec3 tmpvar_11;
  tmpvar_11 = (specularReflection * _Gloss);
  specularReflection = tmpvar_11;
  lowp vec3 tmpvar_12;
  tmpvar_12 = reflect (xlv_TEXCOORD4, normalize (xlv_TEXCOORD1));
  lowp vec4 tmpvar_13;
  tmpvar_13 = textureCube (_Cube, tmpvar_12);
  reflTex = tmpvar_13;
  lowp float tmpvar_14;
  tmpvar_14 = clamp (abs (dot (tmpvar_12, xlv_TEXCOORD1)), 0.0, 1.0);
  mediump float tmpvar_15;
  tmpvar_15 = pow ((1.0 - tmpvar_14), _FrezFalloff);
  frez = tmpvar_15;
  lowp float tmpvar_16;
  tmpvar_16 = (frez * _FrezPow);
  frez = tmpvar_16;
  reflTex.xyz = (tmpvar_13.xyz * clamp ((_Reflection + tmpvar_16), 0.0, 1.0));
  lowp vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = ((tmpvar_4.xyz * clamp (((xlv_TEXCOORD2 + ambientLighting) + tmpvar_7), 0.0, 1.0)) + specularReflection);
  gl_FragData[0] = ((tmpvar_17 + reflTex) + (tmpvar_16 * reflTex));
}



#endif"
}

SubProgram "flash " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 12 [_WorldSpaceCameraPos]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Vector 13 [unity_SHAr]
Vector 14 [unity_SHAg]
Vector 15 [unity_SHAb]
Vector 16 [unity_SHBr]
Vector 17 [unity_SHBg]
Vector 18 [unity_SHBb]
Vector 19 [unity_SHC]
Float 20 [_SHLightingScale]
"agal_vs
c21 0.0 1.0 0.0 0.0
[bc]
adaaaaaaaaaaahacabaaaaffaaaaaaaaajaaaaoeabaaaaaa mul r0.xyz, a1.y, c9
adaaaaaaabaaahacabaaaaaaaaaaaaaaaiaaaaoeabaaaaaa mul r1.xyz, a1.x, c8
abaaaaaaaaaaahacabaaaakeacaaaaaaaaaaaakeacaaaaaa add r0.xyz, r1.xyzz, r0.xyzz
adaaaaaaacaaahacabaaaakkaaaaaaaaakaaaaoeabaaaaaa mul r2.xyz, a1.z, c10
abaaaaaaaaaaahacacaaaakeacaaaaaaaaaaaakeacaaaaaa add r0.xyz, r2.xyzz, r0.xyzz
abaaaaaaaaaaahacaaaaaakeacaaaaaabfaaaaaaabaaaaaa add r0.xyz, r0.xyzz, c21.x
bcaaaaaaaaaaaiacaaaaaakeacaaaaaaaaaaaakeacaaaaaa dp3 r0.w, r0.xyzz, r0.xyzz
akaaaaaaaaaaaiacaaaaaappacaaaaaaaaaaaaaaaaaaaaaa rsq r0.w, r0.w
adaaaaaaacaaahacaaaaaappacaaaaaaaaaaaakeacaaaaaa mul r2.xyz, r0.w, r0.xyzz
adaaaaaaaaaaabacacaaaaffacaaaaaaacaaaaffacaaaaaa mul r0.x, r2.y, r2.y
adaaaaaaacaaaiacacaaaaaaacaaaaaaacaaaaaaacaaaaaa mul r2.w, r2.x, r2.x
acaaaaaaaaaaabacacaaaappacaaaaaaaaaaaaaaacaaaaaa sub r0.x, r2.w, r0.x
adaaaaaaadaaahacaaaaaaaaacaaaaaabdaaaaoeabaaaaaa mul r3.xyz, r0.x, c19
aaaaaaaaaaaaahacacaaaakeacaaaaaaaaaaaaaaaaaaaaaa mov r0.xyz, r2.xyzz
aaaaaaaaaaaaaiacbfaaaaffabaaaaaaaaaaaaaaaaaaaaaa mov r0.w, c21.y
bdaaaaaaaeaaaeacaaaaaaoeacaaaaaaapaaaaoeabaaaaaa dp4 r4.z, r0, c15
bdaaaaaaaeaaacacaaaaaaoeacaaaaaaaoaaaaoeabaaaaaa dp4 r4.y, r0, c14
bdaaaaaaaeaaabacaaaaaaoeacaaaaaaanaaaaoeabaaaaaa dp4 r4.x, r0, c13
adaaaaaaabaaapacacaaaakeacaaaaaaacaaaacjacaaaaaa mul r1, r2.xyzz, r2.yzzx
bdaaaaaaaaaaaeacabaaaaoeacaaaaaabcaaaaoeabaaaaaa dp4 r0.z, r1, c18
bdaaaaaaaaaaabacabaaaaoeacaaaaaabaaaaaoeabaaaaaa dp4 r0.x, r1, c16
bdaaaaaaaaaaacacabaaaaoeacaaaaaabbaaaaoeabaaaaaa dp4 r0.y, r1, c17
abaaaaaaaaaaahacaeaaaakeacaaaaaaaaaaaakeacaaaaaa add r0.xyz, r4.xyzz, r0.xyzz
abaaaaaaaaaaahacaaaaaakeacaaaaaaadaaaakeacaaaaaa add r0.xyz, r0.xyzz, r3.xyzz
adaaaaaaacaaahaeaaaaaakeacaaaaaabeaaaaaaabaaaaaa mul v2.xyz, r0.xyzz, c20.x
bdaaaaaaaaaaabacaaaaaaoeaaaaaaaaaeaaaaoeabaaaaaa dp4 r0.x, a0, c4
bdaaaaaaaaaaaeacaaaaaaoeaaaaaaaaagaaaaoeabaaaaaa dp4 r0.z, a0, c6
bdaaaaaaaaaaacacaaaaaaoeaaaaaaaaafaaaaoeabaaaaaa dp4 r0.y, a0, c5
bdaaaaaaaaaaaiacaaaaaaoeaaaaaaaaahaaaaoeabaaaaaa dp4 r0.w, a0, c7
acaaaaaaabaaahacaaaaaakeacaaaaaaamaaaaoeabaaaaaa sub r1.xyz, r0.xyzz, c12
aaaaaaaaaaaaapaeaaaaaaoeacaaaaaaaaaaaaaaaaaaaaaa mov v0, r0
bcaaaaaaaaaaabacabaaaakeacaaaaaaabaaaakeacaaaaaa dp3 r0.x, r1.xyzz, r1.xyzz
akaaaaaaaaaaabacaaaaaaaaacaaaaaaaaaaaaaaaaaaaaaa rsq r0.x, r0.x
aaaaaaaaabaaahaeacaaaakeacaaaaaaaaaaaaaaaaaaaaaa mov v1.xyz, r2.xyzz
aaaaaaaaadaaapaeadaaaaoeaaaaaaaaaaaaaaaaaaaaaaaa mov v3, a3
adaaaaaaaeaaahaeaaaaaaaaacaaaaaaabaaaakeacaaaaaa mul v4.xyz, r0.x, r1.xyzz
bdaaaaaaaaaaaiadaaaaaaoeaaaaaaaaadaaaaoeabaaaaaa dp4 o0.w, a0, c3
bdaaaaaaaaaaaeadaaaaaaoeaaaaaaaaacaaaaoeabaaaaaa dp4 o0.z, a0, c2
bdaaaaaaaaaaacadaaaaaaoeaaaaaaaaabaaaaoeabaaaaaa dp4 o0.y, a0, c1
bdaaaaaaaaaaabadaaaaaaoeaaaaaaaaaaaaaaoeabaaaaaa dp4 o0.x, a0, c0
aaaaaaaaabaaaiaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v1.w, c0
aaaaaaaaacaaaiaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v2.w, c0
aaaaaaaaaeaaaiaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v4.w, c0
"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Vector 13 [_WorldSpaceCameraPos]
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Vector 14 [unity_SHAr]
Vector 15 [unity_SHAg]
Vector 16 [unity_SHAb]
Vector 17 [unity_SHBr]
Vector 18 [unity_SHBg]
Vector 19 [unity_SHBb]
Vector 20 [unity_SHC]
Float 21 [_SHLightingScale]
"!!ARBvp1.0
# 37 ALU
PARAM c[22] = { { 0, 1 },
		state.matrix.mvp,
		program.local[5..21] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
MUL R0.xyz, vertex.normal.y, c[10];
MAD R0.xyz, vertex.normal.x, c[9], R0;
MAD R0.xyz, vertex.normal.z, c[11], R0;
ADD R0.xyz, R0, c[0].x;
DP3 R0.w, R0, R0;
RSQ R0.w, R0.w;
MUL R2.xyz, R0.w, R0;
MUL R0.x, R2.y, R2.y;
MAD R0.x, R2, R2, -R0;
MUL R3.xyz, R0.x, c[20];
MOV R0.xyz, R2;
MOV R0.w, c[0].y;
DP4 R4.z, R0, c[16];
DP4 R4.y, R0, c[15];
DP4 R4.x, R0, c[14];
MUL R1, R2.xyzz, R2.yzzx;
DP4 R0.z, R1, c[19];
DP4 R0.x, R1, c[17];
DP4 R0.y, R1, c[18];
ADD R0.xyz, R4, R0;
ADD R0.xyz, R0, R3;
MUL result.texcoord[2].xyz, R0, c[21].x;
DP4 R0.x, vertex.position, c[5];
DP4 R0.z, vertex.position, c[7];
DP4 R0.y, vertex.position, c[6];
DP4 R0.w, vertex.position, c[8];
ADD R1.xyz, R0, -c[13];
MOV result.texcoord[0], R0;
DP3 R0.x, R1, R1;
RSQ R0.x, R0.x;
MOV result.texcoord[1].xyz, R2;
MOV result.texcoord[3], vertex.texcoord[0];
MUL result.texcoord[4].xyz, R0.x, R1;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 37 instructions, 5 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 12 [_WorldSpaceCameraPos]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Vector 13 [unity_SHAr]
Vector 14 [unity_SHAg]
Vector 15 [unity_SHAb]
Vector 16 [unity_SHBr]
Vector 17 [unity_SHBg]
Vector 18 [unity_SHBb]
Vector 19 [unity_SHC]
Float 20 [_SHLightingScale]
"vs_2_0
; 37 ALU
def c21, 0.00000000, 1.00000000, 0, 0
dcl_position0 v0
dcl_normal0 v1
dcl_texcoord0 v2
mul r0.xyz, v1.y, c9
mad r0.xyz, v1.x, c8, r0
mad r0.xyz, v1.z, c10, r0
add r0.xyz, r0, c21.x
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul r2.xyz, r0.w, r0
mul r0.x, r2.y, r2.y
mad r0.x, r2, r2, -r0
mul r3.xyz, r0.x, c19
mov r0.xyz, r2
mov r0.w, c21.y
dp4 r4.z, r0, c15
dp4 r4.y, r0, c14
dp4 r4.x, r0, c13
mul r1, r2.xyzz, r2.yzzx
dp4 r0.z, r1, c18
dp4 r0.x, r1, c16
dp4 r0.y, r1, c17
add r0.xyz, r4, r0
add r0.xyz, r0, r3
mul oT2.xyz, r0, c20.x
dp4 r0.x, v0, c4
dp4 r0.z, v0, c6
dp4 r0.y, v0, c5
dp4 r0.w, v0, c7
add r1.xyz, r0, -c12
mov oT0, r0
dp3 r0.x, r1, r1
rsq r0.x, r0.x
mov oT1.xyz, r2
mov oT3, v2
mul oT4.xyz, r0.x, r1
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
"!!GLES
#define SHADER_API_GLES 1
#define tex2D texture2D


#ifdef VERTEX
#define gl_ModelViewProjectionMatrix glstate_matrix_mvp
uniform mat4 glstate_matrix_mvp;

varying lowp vec3 xlv_TEXCOORD4;
varying mediump vec4 xlv_TEXCOORD3;
varying lowp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 unity_SHC;
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;

uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 _World2Object;
uniform lowp float _SHLightingScale;
uniform highp mat4 _Object2World;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  highp vec3 shl;
  lowp vec3 tmpvar_1;
  lowp vec3 tmpvar_2;
  lowp mat4 modelMatrixInverse;
  lowp mat4 modelMatrix;
  modelMatrix = (_Object2World);
  modelMatrixInverse = (_World2Object);
  lowp vec4 tmpvar_3;
  tmpvar_3.w = 0.0;
  tmpvar_3.xyz = normalize (_glesNormal);
  lowp vec3 tmpvar_4;
  tmpvar_4 = normalize ((tmpvar_3 * modelMatrixInverse).xyz);
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize (((modelMatrix * _glesVertex) - tmpvar_5).xyz);
  tmpvar_2 = tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = tmpvar_4;
  mediump vec3 tmpvar_8;
  mediump vec4 normal;
  normal = tmpvar_7;
  mediump vec3 x3;
  highp float vC;
  mediump vec3 x2;
  mediump vec3 x1;
  highp float tmpvar_9;
  tmpvar_9 = dot (unity_SHAr, normal);
  x1.x = tmpvar_9;
  highp float tmpvar_10;
  tmpvar_10 = dot (unity_SHAg, normal);
  x1.y = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = dot (unity_SHAb, normal);
  x1.z = tmpvar_11;
  mediump vec4 tmpvar_12;
  tmpvar_12 = (normal.xyzz * normal.yzzx);
  highp float tmpvar_13;
  tmpvar_13 = dot (unity_SHBr, tmpvar_12);
  x2.x = tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = dot (unity_SHBg, tmpvar_12);
  x2.y = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = dot (unity_SHBb, tmpvar_12);
  x2.z = tmpvar_15;
  mediump float tmpvar_16;
  tmpvar_16 = ((normal.x * normal.x) - (normal.y * normal.y));
  vC = tmpvar_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = (unity_SHC.xyz * vC);
  x3 = tmpvar_17;
  tmpvar_8 = ((x1 + x2) + x3);
  shl = tmpvar_8;
  highp vec3 tmpvar_18;
  tmpvar_18 = (shl * _SHLightingScale);
  tmpvar_1 = tmpvar_18;
  gl_Position = (gl_ModelViewProjectionMatrix * _glesVertex);
  xlv_TEXCOORD0 = (modelMatrix * _glesVertex);
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_1;
  xlv_TEXCOORD3 = _glesMultiTexCoord0;
  xlv_TEXCOORD4 = tmpvar_2;
}



#endif
#ifdef FRAGMENT
#define unity_LightColor0 _glesLightSource[0].diffuse
#define unity_LightColor1 _glesLightSource[1].diffuse
#define unity_LightColor2 _glesLightSource[2].diffuse
#define unity_LightColor3 _glesLightSource[3].diffuse
#define unity_LightPosition0 _glesLightSource[0].position
#define unity_LightPosition1 _glesLightSource[1].position
#define unity_LightPosition2 _glesLightSource[2].position
#define unity_LightPosition3 _glesLightSource[3].position
#define glstate_light0_spotDirection _glesLightSource[0].spotDirection
#define glstate_light1_spotDirection _glesLightSource[1].spotDirection
#define glstate_light2_spotDirection _glesLightSource[2].spotDirection
#define glstate_light3_spotDirection _glesLightSource[3].spotDirection
#define unity_LightAtten0 _glesLightSource[0].atten
#define unity_LightAtten1 _glesLightSource[1].atten
#define unity_LightAtten2 _glesLightSource[2].atten
#define unity_LightAtten3 _glesLightSource[3].atten
#define glstate_lightmodel_ambient _glesLightModel.ambient
#define gl_LightSource _glesLightSource
#define gl_LightSourceParameters _glesLightSourceParameters
struct _glesLightSourceParameters {
  vec4 diffuse;
  vec4 position;
  vec3 spotDirection;
  vec4 atten;
};
uniform _glesLightSourceParameters _glesLightSource[4];
#define gl_LightModel _glesLightModel
#define gl_LightModelParameters _glesLightModelParameters
struct _glesLightModelParameters {
  vec4 ambient;
};
uniform _glesLightModelParameters _glesLightModel;
#define gl_FrontMaterial _glesFrontMaterial
#define gl_BackMaterial _glesFrontMaterial
#define gl_MaterialParameters _glesMaterialParameters
struct _glesMaterialParameters {
  vec4 emission;
  vec4 ambient;
  vec4 diffuse;
  vec4 specular;
  float shininess;
};
uniform _glesMaterialParameters _glesFrontMaterial;

varying lowp vec3 xlv_TEXCOORD4;
varying mediump vec4 xlv_TEXCOORD3;
varying lowp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform lowp float _Reflection;

uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform lowp vec4 _SpecColor;
uniform mediump float _Shininess;
uniform sampler2D _MainTex;
uniform lowp vec4 _LightColor0;
uniform mediump float _Gloss;
uniform lowp float _FrezPow;
uniform mediump float _FrezFalloff;
uniform samplerCube _Cube;
uniform lowp vec4 _Color;
void main ()
{
  lowp float frez;
  lowp vec4 reflTex;
  lowp vec3 specularReflection;
  lowp vec3 ambientLighting;
  lowp vec3 vertexToLightSource;
  lowp vec3 lightDirection;
  lowp float attenuation;
  lowp vec3 viewDirection;
  lowp vec3 tmpvar_1;
  tmpvar_1 = normalize (xlv_TEXCOORD1);
  highp vec3 tmpvar_2;
  tmpvar_2 = normalize ((_WorldSpaceCameraPos - xlv_TEXCOORD0.xyz));
  viewDirection = tmpvar_2;
  mediump vec2 tmpvar_3;
  tmpvar_3 = xlv_TEXCOORD3.xy;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, tmpvar_3);
  if ((0.0 == _WorldSpaceLightPos0.w)) {
    attenuation = 1.0;
    lightDirection = normalize (_WorldSpaceLightPos0.xyz);
  } else {
    highp vec3 tmpvar_5;
    tmpvar_5 = (_WorldSpaceLightPos0 - xlv_TEXCOORD0).xyz;
    vertexToLightSource = tmpvar_5;
    attenuation = (1.0/(length (vertexToLightSource)));
    lightDirection = normalize (vertexToLightSource);
  };
  highp vec3 tmpvar_6;
  tmpvar_6 = (gl_LightModel.ambient.xyz * _Color.xyz);
  ambientLighting = tmpvar_6;
  lowp vec3 tmpvar_7;
  tmpvar_7 = (((attenuation * _LightColor0.xyz) * _Color.xyz) * max (0.0, dot (tmpvar_1, lightDirection)));
  lowp float tmpvar_8;
  tmpvar_8 = dot (tmpvar_1, lightDirection);
  if ((tmpvar_8 < 0.0)) {
    specularReflection = vec3(0.0, 0.0, 0.0);
  } else {
    lowp float tmpvar_9;
    tmpvar_9 = max (0.0, dot (reflect (-(lightDirection), tmpvar_1), viewDirection));
    mediump vec3 tmpvar_10;
    tmpvar_10 = (((attenuation * _LightColor0.xyz) * _SpecColor.xyz) * pow (tmpvar_9, _Shininess));
    specularReflection = tmpvar_10;
  };
  mediump vec3 tmpvar_11;
  tmpvar_11 = (specularReflection * _Gloss);
  specularReflection = tmpvar_11;
  lowp vec3 tmpvar_12;
  tmpvar_12 = reflect (xlv_TEXCOORD4, normalize (xlv_TEXCOORD1));
  lowp vec4 tmpvar_13;
  tmpvar_13 = textureCube (_Cube, tmpvar_12);
  reflTex = tmpvar_13;
  lowp float tmpvar_14;
  tmpvar_14 = clamp (abs (dot (tmpvar_12, xlv_TEXCOORD1)), 0.0, 1.0);
  mediump float tmpvar_15;
  tmpvar_15 = pow ((1.0 - tmpvar_14), _FrezFalloff);
  frez = tmpvar_15;
  lowp float tmpvar_16;
  tmpvar_16 = (frez * _FrezPow);
  frez = tmpvar_16;
  reflTex.xyz = (tmpvar_13.xyz * clamp ((_Reflection + tmpvar_16), 0.0, 1.0));
  lowp vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = ((tmpvar_4.xyz * clamp (((xlv_TEXCOORD2 + ambientLighting) + tmpvar_7), 0.0, 1.0)) + specularReflection);
  gl_FragData[0] = ((tmpvar_17 + reflTex) + (tmpvar_16 * reflTex));
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
"!!GLES
#define SHADER_API_GLES 1
#define tex2D texture2D


#ifdef VERTEX
#define gl_ModelViewProjectionMatrix glstate_matrix_mvp
uniform mat4 glstate_matrix_mvp;

varying lowp vec3 xlv_TEXCOORD4;
varying mediump vec4 xlv_TEXCOORD3;
varying lowp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 unity_SHC;
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;

uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 _World2Object;
uniform lowp float _SHLightingScale;
uniform highp mat4 _Object2World;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  highp vec3 shl;
  lowp vec3 tmpvar_1;
  lowp vec3 tmpvar_2;
  lowp mat4 modelMatrixInverse;
  lowp mat4 modelMatrix;
  modelMatrix = (_Object2World);
  modelMatrixInverse = (_World2Object);
  lowp vec4 tmpvar_3;
  tmpvar_3.w = 0.0;
  tmpvar_3.xyz = normalize (_glesNormal);
  lowp vec3 tmpvar_4;
  tmpvar_4 = normalize ((tmpvar_3 * modelMatrixInverse).xyz);
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize (((modelMatrix * _glesVertex) - tmpvar_5).xyz);
  tmpvar_2 = tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = tmpvar_4;
  mediump vec3 tmpvar_8;
  mediump vec4 normal;
  normal = tmpvar_7;
  mediump vec3 x3;
  highp float vC;
  mediump vec3 x2;
  mediump vec3 x1;
  highp float tmpvar_9;
  tmpvar_9 = dot (unity_SHAr, normal);
  x1.x = tmpvar_9;
  highp float tmpvar_10;
  tmpvar_10 = dot (unity_SHAg, normal);
  x1.y = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = dot (unity_SHAb, normal);
  x1.z = tmpvar_11;
  mediump vec4 tmpvar_12;
  tmpvar_12 = (normal.xyzz * normal.yzzx);
  highp float tmpvar_13;
  tmpvar_13 = dot (unity_SHBr, tmpvar_12);
  x2.x = tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = dot (unity_SHBg, tmpvar_12);
  x2.y = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = dot (unity_SHBb, tmpvar_12);
  x2.z = tmpvar_15;
  mediump float tmpvar_16;
  tmpvar_16 = ((normal.x * normal.x) - (normal.y * normal.y));
  vC = tmpvar_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = (unity_SHC.xyz * vC);
  x3 = tmpvar_17;
  tmpvar_8 = ((x1 + x2) + x3);
  shl = tmpvar_8;
  highp vec3 tmpvar_18;
  tmpvar_18 = (shl * _SHLightingScale);
  tmpvar_1 = tmpvar_18;
  gl_Position = (gl_ModelViewProjectionMatrix * _glesVertex);
  xlv_TEXCOORD0 = (modelMatrix * _glesVertex);
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_1;
  xlv_TEXCOORD3 = _glesMultiTexCoord0;
  xlv_TEXCOORD4 = tmpvar_2;
}



#endif
#ifdef FRAGMENT
#define unity_LightColor0 _glesLightSource[0].diffuse
#define unity_LightColor1 _glesLightSource[1].diffuse
#define unity_LightColor2 _glesLightSource[2].diffuse
#define unity_LightColor3 _glesLightSource[3].diffuse
#define unity_LightPosition0 _glesLightSource[0].position
#define unity_LightPosition1 _glesLightSource[1].position
#define unity_LightPosition2 _glesLightSource[2].position
#define unity_LightPosition3 _glesLightSource[3].position
#define glstate_light0_spotDirection _glesLightSource[0].spotDirection
#define glstate_light1_spotDirection _glesLightSource[1].spotDirection
#define glstate_light2_spotDirection _glesLightSource[2].spotDirection
#define glstate_light3_spotDirection _glesLightSource[3].spotDirection
#define unity_LightAtten0 _glesLightSource[0].atten
#define unity_LightAtten1 _glesLightSource[1].atten
#define unity_LightAtten2 _glesLightSource[2].atten
#define unity_LightAtten3 _glesLightSource[3].atten
#define glstate_lightmodel_ambient _glesLightModel.ambient
#define gl_LightSource _glesLightSource
#define gl_LightSourceParameters _glesLightSourceParameters
struct _glesLightSourceParameters {
  vec4 diffuse;
  vec4 position;
  vec3 spotDirection;
  vec4 atten;
};
uniform _glesLightSourceParameters _glesLightSource[4];
#define gl_LightModel _glesLightModel
#define gl_LightModelParameters _glesLightModelParameters
struct _glesLightModelParameters {
  vec4 ambient;
};
uniform _glesLightModelParameters _glesLightModel;
#define gl_FrontMaterial _glesFrontMaterial
#define gl_BackMaterial _glesFrontMaterial
#define gl_MaterialParameters _glesMaterialParameters
struct _glesMaterialParameters {
  vec4 emission;
  vec4 ambient;
  vec4 diffuse;
  vec4 specular;
  float shininess;
};
uniform _glesMaterialParameters _glesFrontMaterial;

varying lowp vec3 xlv_TEXCOORD4;
varying mediump vec4 xlv_TEXCOORD3;
varying lowp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform lowp float _Reflection;

uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform lowp vec4 _SpecColor;
uniform mediump float _Shininess;
uniform sampler2D _MainTex;
uniform lowp vec4 _LightColor0;
uniform mediump float _Gloss;
uniform lowp float _FrezPow;
uniform mediump float _FrezFalloff;
uniform samplerCube _Cube;
uniform lowp vec4 _Color;
void main ()
{
  lowp float frez;
  lowp vec4 reflTex;
  lowp vec3 specularReflection;
  lowp vec3 ambientLighting;
  lowp vec3 vertexToLightSource;
  lowp vec3 lightDirection;
  lowp float attenuation;
  lowp vec3 viewDirection;
  lowp vec3 tmpvar_1;
  tmpvar_1 = normalize (xlv_TEXCOORD1);
  highp vec3 tmpvar_2;
  tmpvar_2 = normalize ((_WorldSpaceCameraPos - xlv_TEXCOORD0.xyz));
  viewDirection = tmpvar_2;
  mediump vec2 tmpvar_3;
  tmpvar_3 = xlv_TEXCOORD3.xy;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, tmpvar_3);
  if ((0.0 == _WorldSpaceLightPos0.w)) {
    attenuation = 1.0;
    lightDirection = normalize (_WorldSpaceLightPos0.xyz);
  } else {
    highp vec3 tmpvar_5;
    tmpvar_5 = (_WorldSpaceLightPos0 - xlv_TEXCOORD0).xyz;
    vertexToLightSource = tmpvar_5;
    attenuation = (1.0/(length (vertexToLightSource)));
    lightDirection = normalize (vertexToLightSource);
  };
  highp vec3 tmpvar_6;
  tmpvar_6 = (gl_LightModel.ambient.xyz * _Color.xyz);
  ambientLighting = tmpvar_6;
  lowp vec3 tmpvar_7;
  tmpvar_7 = (((attenuation * _LightColor0.xyz) * _Color.xyz) * max (0.0, dot (tmpvar_1, lightDirection)));
  lowp float tmpvar_8;
  tmpvar_8 = dot (tmpvar_1, lightDirection);
  if ((tmpvar_8 < 0.0)) {
    specularReflection = vec3(0.0, 0.0, 0.0);
  } else {
    lowp float tmpvar_9;
    tmpvar_9 = max (0.0, dot (reflect (-(lightDirection), tmpvar_1), viewDirection));
    mediump vec3 tmpvar_10;
    tmpvar_10 = (((attenuation * _LightColor0.xyz) * _SpecColor.xyz) * pow (tmpvar_9, _Shininess));
    specularReflection = tmpvar_10;
  };
  mediump vec3 tmpvar_11;
  tmpvar_11 = (specularReflection * _Gloss);
  specularReflection = tmpvar_11;
  lowp vec3 tmpvar_12;
  tmpvar_12 = reflect (xlv_TEXCOORD4, normalize (xlv_TEXCOORD1));
  lowp vec4 tmpvar_13;
  tmpvar_13 = textureCube (_Cube, tmpvar_12);
  reflTex = tmpvar_13;
  lowp float tmpvar_14;
  tmpvar_14 = clamp (abs (dot (tmpvar_12, xlv_TEXCOORD1)), 0.0, 1.0);
  mediump float tmpvar_15;
  tmpvar_15 = pow ((1.0 - tmpvar_14), _FrezFalloff);
  frez = tmpvar_15;
  lowp float tmpvar_16;
  tmpvar_16 = (frez * _FrezPow);
  frez = tmpvar_16;
  reflTex.xyz = (tmpvar_13.xyz * clamp ((_Reflection + tmpvar_16), 0.0, 1.0));
  lowp vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = ((tmpvar_4.xyz * clamp (((xlv_TEXCOORD2 + ambientLighting) + tmpvar_7), 0.0, 1.0)) + specularReflection);
  gl_FragData[0] = ((tmpvar_17 + reflTex) + (tmpvar_16 * reflTex));
}



#endif"
}

SubProgram "flash " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 12 [_WorldSpaceCameraPos]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Vector 13 [unity_SHAr]
Vector 14 [unity_SHAg]
Vector 15 [unity_SHAb]
Vector 16 [unity_SHBr]
Vector 17 [unity_SHBg]
Vector 18 [unity_SHBb]
Vector 19 [unity_SHC]
Float 20 [_SHLightingScale]
"agal_vs
c21 0.0 1.0 0.0 0.0
[bc]
adaaaaaaaaaaahacabaaaaffaaaaaaaaajaaaaoeabaaaaaa mul r0.xyz, a1.y, c9
adaaaaaaabaaahacabaaaaaaaaaaaaaaaiaaaaoeabaaaaaa mul r1.xyz, a1.x, c8
abaaaaaaaaaaahacabaaaakeacaaaaaaaaaaaakeacaaaaaa add r0.xyz, r1.xyzz, r0.xyzz
adaaaaaaacaaahacabaaaakkaaaaaaaaakaaaaoeabaaaaaa mul r2.xyz, a1.z, c10
abaaaaaaaaaaahacacaaaakeacaaaaaaaaaaaakeacaaaaaa add r0.xyz, r2.xyzz, r0.xyzz
abaaaaaaaaaaahacaaaaaakeacaaaaaabfaaaaaaabaaaaaa add r0.xyz, r0.xyzz, c21.x
bcaaaaaaaaaaaiacaaaaaakeacaaaaaaaaaaaakeacaaaaaa dp3 r0.w, r0.xyzz, r0.xyzz
akaaaaaaaaaaaiacaaaaaappacaaaaaaaaaaaaaaaaaaaaaa rsq r0.w, r0.w
adaaaaaaacaaahacaaaaaappacaaaaaaaaaaaakeacaaaaaa mul r2.xyz, r0.w, r0.xyzz
adaaaaaaaaaaabacacaaaaffacaaaaaaacaaaaffacaaaaaa mul r0.x, r2.y, r2.y
adaaaaaaacaaaiacacaaaaaaacaaaaaaacaaaaaaacaaaaaa mul r2.w, r2.x, r2.x
acaaaaaaaaaaabacacaaaappacaaaaaaaaaaaaaaacaaaaaa sub r0.x, r2.w, r0.x
adaaaaaaadaaahacaaaaaaaaacaaaaaabdaaaaoeabaaaaaa mul r3.xyz, r0.x, c19
aaaaaaaaaaaaahacacaaaakeacaaaaaaaaaaaaaaaaaaaaaa mov r0.xyz, r2.xyzz
aaaaaaaaaaaaaiacbfaaaaffabaaaaaaaaaaaaaaaaaaaaaa mov r0.w, c21.y
bdaaaaaaaeaaaeacaaaaaaoeacaaaaaaapaaaaoeabaaaaaa dp4 r4.z, r0, c15
bdaaaaaaaeaaacacaaaaaaoeacaaaaaaaoaaaaoeabaaaaaa dp4 r4.y, r0, c14
bdaaaaaaaeaaabacaaaaaaoeacaaaaaaanaaaaoeabaaaaaa dp4 r4.x, r0, c13
adaaaaaaabaaapacacaaaakeacaaaaaaacaaaacjacaaaaaa mul r1, r2.xyzz, r2.yzzx
bdaaaaaaaaaaaeacabaaaaoeacaaaaaabcaaaaoeabaaaaaa dp4 r0.z, r1, c18
bdaaaaaaaaaaabacabaaaaoeacaaaaaabaaaaaoeabaaaaaa dp4 r0.x, r1, c16
bdaaaaaaaaaaacacabaaaaoeacaaaaaabbaaaaoeabaaaaaa dp4 r0.y, r1, c17
abaaaaaaaaaaahacaeaaaakeacaaaaaaaaaaaakeacaaaaaa add r0.xyz, r4.xyzz, r0.xyzz
abaaaaaaaaaaahacaaaaaakeacaaaaaaadaaaakeacaaaaaa add r0.xyz, r0.xyzz, r3.xyzz
adaaaaaaacaaahaeaaaaaakeacaaaaaabeaaaaaaabaaaaaa mul v2.xyz, r0.xyzz, c20.x
bdaaaaaaaaaaabacaaaaaaoeaaaaaaaaaeaaaaoeabaaaaaa dp4 r0.x, a0, c4
bdaaaaaaaaaaaeacaaaaaaoeaaaaaaaaagaaaaoeabaaaaaa dp4 r0.z, a0, c6
bdaaaaaaaaaaacacaaaaaaoeaaaaaaaaafaaaaoeabaaaaaa dp4 r0.y, a0, c5
bdaaaaaaaaaaaiacaaaaaaoeaaaaaaaaahaaaaoeabaaaaaa dp4 r0.w, a0, c7
acaaaaaaabaaahacaaaaaakeacaaaaaaamaaaaoeabaaaaaa sub r1.xyz, r0.xyzz, c12
aaaaaaaaaaaaapaeaaaaaaoeacaaaaaaaaaaaaaaaaaaaaaa mov v0, r0
bcaaaaaaaaaaabacabaaaakeacaaaaaaabaaaakeacaaaaaa dp3 r0.x, r1.xyzz, r1.xyzz
akaaaaaaaaaaabacaaaaaaaaacaaaaaaaaaaaaaaaaaaaaaa rsq r0.x, r0.x
aaaaaaaaabaaahaeacaaaakeacaaaaaaaaaaaaaaaaaaaaaa mov v1.xyz, r2.xyzz
aaaaaaaaadaaapaeadaaaaoeaaaaaaaaaaaaaaaaaaaaaaaa mov v3, a3
adaaaaaaaeaaahaeaaaaaaaaacaaaaaaabaaaakeacaaaaaa mul v4.xyz, r0.x, r1.xyzz
bdaaaaaaaaaaaiadaaaaaaoeaaaaaaaaadaaaaoeabaaaaaa dp4 o0.w, a0, c3
bdaaaaaaaaaaaeadaaaaaaoeaaaaaaaaacaaaaoeabaaaaaa dp4 o0.z, a0, c2
bdaaaaaaaaaaacadaaaaaaoeaaaaaaaaabaaaaoeabaaaaaa dp4 o0.y, a0, c1
bdaaaaaaaaaaabadaaaaaaoeaaaaaaaaaaaaaaoeabaaaaaa dp4 o0.x, a0, c0
aaaaaaaaabaaaiaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v1.w, c0
aaaaaaaaacaaaiaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v2.w, c0
aaaaaaaaaeaaaiaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v4.w, c0
"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_SCREEN" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Vector 13 [_WorldSpaceCameraPos]
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Vector 14 [unity_SHAr]
Vector 15 [unity_SHAg]
Vector 16 [unity_SHAb]
Vector 17 [unity_SHBr]
Vector 18 [unity_SHBg]
Vector 19 [unity_SHBb]
Vector 20 [unity_SHC]
Float 21 [_SHLightingScale]
"!!ARBvp1.0
# 37 ALU
PARAM c[22] = { { 0, 1 },
		state.matrix.mvp,
		program.local[5..21] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
MUL R0.xyz, vertex.normal.y, c[10];
MAD R0.xyz, vertex.normal.x, c[9], R0;
MAD R0.xyz, vertex.normal.z, c[11], R0;
ADD R0.xyz, R0, c[0].x;
DP3 R0.w, R0, R0;
RSQ R0.w, R0.w;
MUL R2.xyz, R0.w, R0;
MUL R0.x, R2.y, R2.y;
MAD R0.x, R2, R2, -R0;
MUL R3.xyz, R0.x, c[20];
MOV R0.xyz, R2;
MOV R0.w, c[0].y;
DP4 R4.z, R0, c[16];
DP4 R4.y, R0, c[15];
DP4 R4.x, R0, c[14];
MUL R1, R2.xyzz, R2.yzzx;
DP4 R0.z, R1, c[19];
DP4 R0.x, R1, c[17];
DP4 R0.y, R1, c[18];
ADD R0.xyz, R4, R0;
ADD R0.xyz, R0, R3;
MUL result.texcoord[2].xyz, R0, c[21].x;
DP4 R0.x, vertex.position, c[5];
DP4 R0.z, vertex.position, c[7];
DP4 R0.y, vertex.position, c[6];
DP4 R0.w, vertex.position, c[8];
ADD R1.xyz, R0, -c[13];
MOV result.texcoord[0], R0;
DP3 R0.x, R1, R1;
RSQ R0.x, R0.x;
MOV result.texcoord[1].xyz, R2;
MOV result.texcoord[3], vertex.texcoord[0];
MUL result.texcoord[4].xyz, R0.x, R1;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 37 instructions, 5 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_SCREEN" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 12 [_WorldSpaceCameraPos]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Vector 13 [unity_SHAr]
Vector 14 [unity_SHAg]
Vector 15 [unity_SHAb]
Vector 16 [unity_SHBr]
Vector 17 [unity_SHBg]
Vector 18 [unity_SHBb]
Vector 19 [unity_SHC]
Float 20 [_SHLightingScale]
"vs_2_0
; 37 ALU
def c21, 0.00000000, 1.00000000, 0, 0
dcl_position0 v0
dcl_normal0 v1
dcl_texcoord0 v2
mul r0.xyz, v1.y, c9
mad r0.xyz, v1.x, c8, r0
mad r0.xyz, v1.z, c10, r0
add r0.xyz, r0, c21.x
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul r2.xyz, r0.w, r0
mul r0.x, r2.y, r2.y
mad r0.x, r2, r2, -r0
mul r3.xyz, r0.x, c19
mov r0.xyz, r2
mov r0.w, c21.y
dp4 r4.z, r0, c15
dp4 r4.y, r0, c14
dp4 r4.x, r0, c13
mul r1, r2.xyzz, r2.yzzx
dp4 r0.z, r1, c18
dp4 r0.x, r1, c16
dp4 r0.y, r1, c17
add r0.xyz, r4, r0
add r0.xyz, r0, r3
mul oT2.xyz, r0, c20.x
dp4 r0.x, v0, c4
dp4 r0.z, v0, c6
dp4 r0.y, v0, c5
dp4 r0.w, v0, c7
add r1.xyz, r0, -c12
mov oT0, r0
dp3 r0.x, r1, r1
rsq r0.x, r0.x
mov oT1.xyz, r2
mov oT3, v2
mul oT4.xyz, r0.x, r1
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_SCREEN" }
"!!GLES
#define SHADER_API_GLES 1
#define tex2D texture2D


#ifdef VERTEX
#define gl_ModelViewProjectionMatrix glstate_matrix_mvp
uniform mat4 glstate_matrix_mvp;

varying lowp vec3 xlv_TEXCOORD4;
varying mediump vec4 xlv_TEXCOORD3;
varying lowp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 unity_SHC;
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;

uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 _World2Object;
uniform lowp float _SHLightingScale;
uniform highp mat4 _Object2World;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  highp vec3 shl;
  lowp vec3 tmpvar_1;
  lowp vec3 tmpvar_2;
  lowp mat4 modelMatrixInverse;
  lowp mat4 modelMatrix;
  modelMatrix = (_Object2World);
  modelMatrixInverse = (_World2Object);
  lowp vec4 tmpvar_3;
  tmpvar_3.w = 0.0;
  tmpvar_3.xyz = normalize (_glesNormal);
  lowp vec3 tmpvar_4;
  tmpvar_4 = normalize ((tmpvar_3 * modelMatrixInverse).xyz);
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize (((modelMatrix * _glesVertex) - tmpvar_5).xyz);
  tmpvar_2 = tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = tmpvar_4;
  mediump vec3 tmpvar_8;
  mediump vec4 normal;
  normal = tmpvar_7;
  mediump vec3 x3;
  highp float vC;
  mediump vec3 x2;
  mediump vec3 x1;
  highp float tmpvar_9;
  tmpvar_9 = dot (unity_SHAr, normal);
  x1.x = tmpvar_9;
  highp float tmpvar_10;
  tmpvar_10 = dot (unity_SHAg, normal);
  x1.y = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = dot (unity_SHAb, normal);
  x1.z = tmpvar_11;
  mediump vec4 tmpvar_12;
  tmpvar_12 = (normal.xyzz * normal.yzzx);
  highp float tmpvar_13;
  tmpvar_13 = dot (unity_SHBr, tmpvar_12);
  x2.x = tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = dot (unity_SHBg, tmpvar_12);
  x2.y = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = dot (unity_SHBb, tmpvar_12);
  x2.z = tmpvar_15;
  mediump float tmpvar_16;
  tmpvar_16 = ((normal.x * normal.x) - (normal.y * normal.y));
  vC = tmpvar_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = (unity_SHC.xyz * vC);
  x3 = tmpvar_17;
  tmpvar_8 = ((x1 + x2) + x3);
  shl = tmpvar_8;
  highp vec3 tmpvar_18;
  tmpvar_18 = (shl * _SHLightingScale);
  tmpvar_1 = tmpvar_18;
  gl_Position = (gl_ModelViewProjectionMatrix * _glesVertex);
  xlv_TEXCOORD0 = (modelMatrix * _glesVertex);
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_1;
  xlv_TEXCOORD3 = _glesMultiTexCoord0;
  xlv_TEXCOORD4 = tmpvar_2;
}



#endif
#ifdef FRAGMENT
#define unity_LightColor0 _glesLightSource[0].diffuse
#define unity_LightColor1 _glesLightSource[1].diffuse
#define unity_LightColor2 _glesLightSource[2].diffuse
#define unity_LightColor3 _glesLightSource[3].diffuse
#define unity_LightPosition0 _glesLightSource[0].position
#define unity_LightPosition1 _glesLightSource[1].position
#define unity_LightPosition2 _glesLightSource[2].position
#define unity_LightPosition3 _glesLightSource[3].position
#define glstate_light0_spotDirection _glesLightSource[0].spotDirection
#define glstate_light1_spotDirection _glesLightSource[1].spotDirection
#define glstate_light2_spotDirection _glesLightSource[2].spotDirection
#define glstate_light3_spotDirection _glesLightSource[3].spotDirection
#define unity_LightAtten0 _glesLightSource[0].atten
#define unity_LightAtten1 _glesLightSource[1].atten
#define unity_LightAtten2 _glesLightSource[2].atten
#define unity_LightAtten3 _glesLightSource[3].atten
#define glstate_lightmodel_ambient _glesLightModel.ambient
#define gl_LightSource _glesLightSource
#define gl_LightSourceParameters _glesLightSourceParameters
struct _glesLightSourceParameters {
  vec4 diffuse;
  vec4 position;
  vec3 spotDirection;
  vec4 atten;
};
uniform _glesLightSourceParameters _glesLightSource[4];
#define gl_LightModel _glesLightModel
#define gl_LightModelParameters _glesLightModelParameters
struct _glesLightModelParameters {
  vec4 ambient;
};
uniform _glesLightModelParameters _glesLightModel;
#define gl_FrontMaterial _glesFrontMaterial
#define gl_BackMaterial _glesFrontMaterial
#define gl_MaterialParameters _glesMaterialParameters
struct _glesMaterialParameters {
  vec4 emission;
  vec4 ambient;
  vec4 diffuse;
  vec4 specular;
  float shininess;
};
uniform _glesMaterialParameters _glesFrontMaterial;

varying lowp vec3 xlv_TEXCOORD4;
varying mediump vec4 xlv_TEXCOORD3;
varying lowp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform lowp float _Reflection;

uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform lowp vec4 _SpecColor;
uniform mediump float _Shininess;
uniform sampler2D _MainTex;
uniform lowp vec4 _LightColor0;
uniform mediump float _Gloss;
uniform lowp float _FrezPow;
uniform mediump float _FrezFalloff;
uniform samplerCube _Cube;
uniform lowp vec4 _Color;
void main ()
{
  lowp float frez;
  lowp vec4 reflTex;
  lowp vec3 specularReflection;
  lowp vec3 ambientLighting;
  lowp vec3 vertexToLightSource;
  lowp vec3 lightDirection;
  lowp float attenuation;
  lowp vec3 viewDirection;
  lowp vec3 tmpvar_1;
  tmpvar_1 = normalize (xlv_TEXCOORD1);
  highp vec3 tmpvar_2;
  tmpvar_2 = normalize ((_WorldSpaceCameraPos - xlv_TEXCOORD0.xyz));
  viewDirection = tmpvar_2;
  mediump vec2 tmpvar_3;
  tmpvar_3 = xlv_TEXCOORD3.xy;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, tmpvar_3);
  if ((0.0 == _WorldSpaceLightPos0.w)) {
    attenuation = 1.0;
    lightDirection = normalize (_WorldSpaceLightPos0.xyz);
  } else {
    highp vec3 tmpvar_5;
    tmpvar_5 = (_WorldSpaceLightPos0 - xlv_TEXCOORD0).xyz;
    vertexToLightSource = tmpvar_5;
    attenuation = (1.0/(length (vertexToLightSource)));
    lightDirection = normalize (vertexToLightSource);
  };
  highp vec3 tmpvar_6;
  tmpvar_6 = (gl_LightModel.ambient.xyz * _Color.xyz);
  ambientLighting = tmpvar_6;
  lowp vec3 tmpvar_7;
  tmpvar_7 = (((attenuation * _LightColor0.xyz) * _Color.xyz) * max (0.0, dot (tmpvar_1, lightDirection)));
  lowp float tmpvar_8;
  tmpvar_8 = dot (tmpvar_1, lightDirection);
  if ((tmpvar_8 < 0.0)) {
    specularReflection = vec3(0.0, 0.0, 0.0);
  } else {
    lowp float tmpvar_9;
    tmpvar_9 = max (0.0, dot (reflect (-(lightDirection), tmpvar_1), viewDirection));
    mediump vec3 tmpvar_10;
    tmpvar_10 = (((attenuation * _LightColor0.xyz) * _SpecColor.xyz) * pow (tmpvar_9, _Shininess));
    specularReflection = tmpvar_10;
  };
  mediump vec3 tmpvar_11;
  tmpvar_11 = (specularReflection * _Gloss);
  specularReflection = tmpvar_11;
  lowp vec3 tmpvar_12;
  tmpvar_12 = reflect (xlv_TEXCOORD4, normalize (xlv_TEXCOORD1));
  lowp vec4 tmpvar_13;
  tmpvar_13 = textureCube (_Cube, tmpvar_12);
  reflTex = tmpvar_13;
  lowp float tmpvar_14;
  tmpvar_14 = clamp (abs (dot (tmpvar_12, xlv_TEXCOORD1)), 0.0, 1.0);
  mediump float tmpvar_15;
  tmpvar_15 = pow ((1.0 - tmpvar_14), _FrezFalloff);
  frez = tmpvar_15;
  lowp float tmpvar_16;
  tmpvar_16 = (frez * _FrezPow);
  frez = tmpvar_16;
  reflTex.xyz = (tmpvar_13.xyz * clamp ((_Reflection + tmpvar_16), 0.0, 1.0));
  lowp vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = ((tmpvar_4.xyz * clamp (((xlv_TEXCOORD2 + ambientLighting) + tmpvar_7), 0.0, 1.0)) + specularReflection);
  gl_FragData[0] = ((tmpvar_17 + reflTex) + (tmpvar_16 * reflTex));
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_SCREEN" }
"!!GLES
#define SHADER_API_GLES 1
#define tex2D texture2D


#ifdef VERTEX
#define gl_ModelViewProjectionMatrix glstate_matrix_mvp
uniform mat4 glstate_matrix_mvp;

varying lowp vec3 xlv_TEXCOORD4;
varying mediump vec4 xlv_TEXCOORD3;
varying lowp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 unity_SHC;
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;

uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 _World2Object;
uniform lowp float _SHLightingScale;
uniform highp mat4 _Object2World;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  highp vec3 shl;
  lowp vec3 tmpvar_1;
  lowp vec3 tmpvar_2;
  lowp mat4 modelMatrixInverse;
  lowp mat4 modelMatrix;
  modelMatrix = (_Object2World);
  modelMatrixInverse = (_World2Object);
  lowp vec4 tmpvar_3;
  tmpvar_3.w = 0.0;
  tmpvar_3.xyz = normalize (_glesNormal);
  lowp vec3 tmpvar_4;
  tmpvar_4 = normalize ((tmpvar_3 * modelMatrixInverse).xyz);
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize (((modelMatrix * _glesVertex) - tmpvar_5).xyz);
  tmpvar_2 = tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = tmpvar_4;
  mediump vec3 tmpvar_8;
  mediump vec4 normal;
  normal = tmpvar_7;
  mediump vec3 x3;
  highp float vC;
  mediump vec3 x2;
  mediump vec3 x1;
  highp float tmpvar_9;
  tmpvar_9 = dot (unity_SHAr, normal);
  x1.x = tmpvar_9;
  highp float tmpvar_10;
  tmpvar_10 = dot (unity_SHAg, normal);
  x1.y = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = dot (unity_SHAb, normal);
  x1.z = tmpvar_11;
  mediump vec4 tmpvar_12;
  tmpvar_12 = (normal.xyzz * normal.yzzx);
  highp float tmpvar_13;
  tmpvar_13 = dot (unity_SHBr, tmpvar_12);
  x2.x = tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = dot (unity_SHBg, tmpvar_12);
  x2.y = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = dot (unity_SHBb, tmpvar_12);
  x2.z = tmpvar_15;
  mediump float tmpvar_16;
  tmpvar_16 = ((normal.x * normal.x) - (normal.y * normal.y));
  vC = tmpvar_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = (unity_SHC.xyz * vC);
  x3 = tmpvar_17;
  tmpvar_8 = ((x1 + x2) + x3);
  shl = tmpvar_8;
  highp vec3 tmpvar_18;
  tmpvar_18 = (shl * _SHLightingScale);
  tmpvar_1 = tmpvar_18;
  gl_Position = (gl_ModelViewProjectionMatrix * _glesVertex);
  xlv_TEXCOORD0 = (modelMatrix * _glesVertex);
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_1;
  xlv_TEXCOORD3 = _glesMultiTexCoord0;
  xlv_TEXCOORD4 = tmpvar_2;
}



#endif
#ifdef FRAGMENT
#define unity_LightColor0 _glesLightSource[0].diffuse
#define unity_LightColor1 _glesLightSource[1].diffuse
#define unity_LightColor2 _glesLightSource[2].diffuse
#define unity_LightColor3 _glesLightSource[3].diffuse
#define unity_LightPosition0 _glesLightSource[0].position
#define unity_LightPosition1 _glesLightSource[1].position
#define unity_LightPosition2 _glesLightSource[2].position
#define unity_LightPosition3 _glesLightSource[3].position
#define glstate_light0_spotDirection _glesLightSource[0].spotDirection
#define glstate_light1_spotDirection _glesLightSource[1].spotDirection
#define glstate_light2_spotDirection _glesLightSource[2].spotDirection
#define glstate_light3_spotDirection _glesLightSource[3].spotDirection
#define unity_LightAtten0 _glesLightSource[0].atten
#define unity_LightAtten1 _glesLightSource[1].atten
#define unity_LightAtten2 _glesLightSource[2].atten
#define unity_LightAtten3 _glesLightSource[3].atten
#define glstate_lightmodel_ambient _glesLightModel.ambient
#define gl_LightSource _glesLightSource
#define gl_LightSourceParameters _glesLightSourceParameters
struct _glesLightSourceParameters {
  vec4 diffuse;
  vec4 position;
  vec3 spotDirection;
  vec4 atten;
};
uniform _glesLightSourceParameters _glesLightSource[4];
#define gl_LightModel _glesLightModel
#define gl_LightModelParameters _glesLightModelParameters
struct _glesLightModelParameters {
  vec4 ambient;
};
uniform _glesLightModelParameters _glesLightModel;
#define gl_FrontMaterial _glesFrontMaterial
#define gl_BackMaterial _glesFrontMaterial
#define gl_MaterialParameters _glesMaterialParameters
struct _glesMaterialParameters {
  vec4 emission;
  vec4 ambient;
  vec4 diffuse;
  vec4 specular;
  float shininess;
};
uniform _glesMaterialParameters _glesFrontMaterial;

varying lowp vec3 xlv_TEXCOORD4;
varying mediump vec4 xlv_TEXCOORD3;
varying lowp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform lowp float _Reflection;

uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform lowp vec4 _SpecColor;
uniform mediump float _Shininess;
uniform sampler2D _MainTex;
uniform lowp vec4 _LightColor0;
uniform mediump float _Gloss;
uniform lowp float _FrezPow;
uniform mediump float _FrezFalloff;
uniform samplerCube _Cube;
uniform lowp vec4 _Color;
void main ()
{
  lowp float frez;
  lowp vec4 reflTex;
  lowp vec3 specularReflection;
  lowp vec3 ambientLighting;
  lowp vec3 vertexToLightSource;
  lowp vec3 lightDirection;
  lowp float attenuation;
  lowp vec3 viewDirection;
  lowp vec3 tmpvar_1;
  tmpvar_1 = normalize (xlv_TEXCOORD1);
  highp vec3 tmpvar_2;
  tmpvar_2 = normalize ((_WorldSpaceCameraPos - xlv_TEXCOORD0.xyz));
  viewDirection = tmpvar_2;
  mediump vec2 tmpvar_3;
  tmpvar_3 = xlv_TEXCOORD3.xy;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, tmpvar_3);
  if ((0.0 == _WorldSpaceLightPos0.w)) {
    attenuation = 1.0;
    lightDirection = normalize (_WorldSpaceLightPos0.xyz);
  } else {
    highp vec3 tmpvar_5;
    tmpvar_5 = (_WorldSpaceLightPos0 - xlv_TEXCOORD0).xyz;
    vertexToLightSource = tmpvar_5;
    attenuation = (1.0/(length (vertexToLightSource)));
    lightDirection = normalize (vertexToLightSource);
  };
  highp vec3 tmpvar_6;
  tmpvar_6 = (gl_LightModel.ambient.xyz * _Color.xyz);
  ambientLighting = tmpvar_6;
  lowp vec3 tmpvar_7;
  tmpvar_7 = (((attenuation * _LightColor0.xyz) * _Color.xyz) * max (0.0, dot (tmpvar_1, lightDirection)));
  lowp float tmpvar_8;
  tmpvar_8 = dot (tmpvar_1, lightDirection);
  if ((tmpvar_8 < 0.0)) {
    specularReflection = vec3(0.0, 0.0, 0.0);
  } else {
    lowp float tmpvar_9;
    tmpvar_9 = max (0.0, dot (reflect (-(lightDirection), tmpvar_1), viewDirection));
    mediump vec3 tmpvar_10;
    tmpvar_10 = (((attenuation * _LightColor0.xyz) * _SpecColor.xyz) * pow (tmpvar_9, _Shininess));
    specularReflection = tmpvar_10;
  };
  mediump vec3 tmpvar_11;
  tmpvar_11 = (specularReflection * _Gloss);
  specularReflection = tmpvar_11;
  lowp vec3 tmpvar_12;
  tmpvar_12 = reflect (xlv_TEXCOORD4, normalize (xlv_TEXCOORD1));
  lowp vec4 tmpvar_13;
  tmpvar_13 = textureCube (_Cube, tmpvar_12);
  reflTex = tmpvar_13;
  lowp float tmpvar_14;
  tmpvar_14 = clamp (abs (dot (tmpvar_12, xlv_TEXCOORD1)), 0.0, 1.0);
  mediump float tmpvar_15;
  tmpvar_15 = pow ((1.0 - tmpvar_14), _FrezFalloff);
  frez = tmpvar_15;
  lowp float tmpvar_16;
  tmpvar_16 = (frez * _FrezPow);
  frez = tmpvar_16;
  reflTex.xyz = (tmpvar_13.xyz * clamp ((_Reflection + tmpvar_16), 0.0, 1.0));
  lowp vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = ((tmpvar_4.xyz * clamp (((xlv_TEXCOORD2 + ambientLighting) + tmpvar_7), 0.0, 1.0)) + specularReflection);
  gl_FragData[0] = ((tmpvar_17 + reflTex) + (tmpvar_16 * reflTex));
}



#endif"
}

SubProgram "flash " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_SCREEN" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 12 [_WorldSpaceCameraPos]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Vector 13 [unity_SHAr]
Vector 14 [unity_SHAg]
Vector 15 [unity_SHAb]
Vector 16 [unity_SHBr]
Vector 17 [unity_SHBg]
Vector 18 [unity_SHBb]
Vector 19 [unity_SHC]
Float 20 [_SHLightingScale]
"agal_vs
c21 0.0 1.0 0.0 0.0
[bc]
adaaaaaaaaaaahacabaaaaffaaaaaaaaajaaaaoeabaaaaaa mul r0.xyz, a1.y, c9
adaaaaaaabaaahacabaaaaaaaaaaaaaaaiaaaaoeabaaaaaa mul r1.xyz, a1.x, c8
abaaaaaaaaaaahacabaaaakeacaaaaaaaaaaaakeacaaaaaa add r0.xyz, r1.xyzz, r0.xyzz
adaaaaaaacaaahacabaaaakkaaaaaaaaakaaaaoeabaaaaaa mul r2.xyz, a1.z, c10
abaaaaaaaaaaahacacaaaakeacaaaaaaaaaaaakeacaaaaaa add r0.xyz, r2.xyzz, r0.xyzz
abaaaaaaaaaaahacaaaaaakeacaaaaaabfaaaaaaabaaaaaa add r0.xyz, r0.xyzz, c21.x
bcaaaaaaaaaaaiacaaaaaakeacaaaaaaaaaaaakeacaaaaaa dp3 r0.w, r0.xyzz, r0.xyzz
akaaaaaaaaaaaiacaaaaaappacaaaaaaaaaaaaaaaaaaaaaa rsq r0.w, r0.w
adaaaaaaacaaahacaaaaaappacaaaaaaaaaaaakeacaaaaaa mul r2.xyz, r0.w, r0.xyzz
adaaaaaaaaaaabacacaaaaffacaaaaaaacaaaaffacaaaaaa mul r0.x, r2.y, r2.y
adaaaaaaacaaaiacacaaaaaaacaaaaaaacaaaaaaacaaaaaa mul r2.w, r2.x, r2.x
acaaaaaaaaaaabacacaaaappacaaaaaaaaaaaaaaacaaaaaa sub r0.x, r2.w, r0.x
adaaaaaaadaaahacaaaaaaaaacaaaaaabdaaaaoeabaaaaaa mul r3.xyz, r0.x, c19
aaaaaaaaaaaaahacacaaaakeacaaaaaaaaaaaaaaaaaaaaaa mov r0.xyz, r2.xyzz
aaaaaaaaaaaaaiacbfaaaaffabaaaaaaaaaaaaaaaaaaaaaa mov r0.w, c21.y
bdaaaaaaaeaaaeacaaaaaaoeacaaaaaaapaaaaoeabaaaaaa dp4 r4.z, r0, c15
bdaaaaaaaeaaacacaaaaaaoeacaaaaaaaoaaaaoeabaaaaaa dp4 r4.y, r0, c14
bdaaaaaaaeaaabacaaaaaaoeacaaaaaaanaaaaoeabaaaaaa dp4 r4.x, r0, c13
adaaaaaaabaaapacacaaaakeacaaaaaaacaaaacjacaaaaaa mul r1, r2.xyzz, r2.yzzx
bdaaaaaaaaaaaeacabaaaaoeacaaaaaabcaaaaoeabaaaaaa dp4 r0.z, r1, c18
bdaaaaaaaaaaabacabaaaaoeacaaaaaabaaaaaoeabaaaaaa dp4 r0.x, r1, c16
bdaaaaaaaaaaacacabaaaaoeacaaaaaabbaaaaoeabaaaaaa dp4 r0.y, r1, c17
abaaaaaaaaaaahacaeaaaakeacaaaaaaaaaaaakeacaaaaaa add r0.xyz, r4.xyzz, r0.xyzz
abaaaaaaaaaaahacaaaaaakeacaaaaaaadaaaakeacaaaaaa add r0.xyz, r0.xyzz, r3.xyzz
adaaaaaaacaaahaeaaaaaakeacaaaaaabeaaaaaaabaaaaaa mul v2.xyz, r0.xyzz, c20.x
bdaaaaaaaaaaabacaaaaaaoeaaaaaaaaaeaaaaoeabaaaaaa dp4 r0.x, a0, c4
bdaaaaaaaaaaaeacaaaaaaoeaaaaaaaaagaaaaoeabaaaaaa dp4 r0.z, a0, c6
bdaaaaaaaaaaacacaaaaaaoeaaaaaaaaafaaaaoeabaaaaaa dp4 r0.y, a0, c5
bdaaaaaaaaaaaiacaaaaaaoeaaaaaaaaahaaaaoeabaaaaaa dp4 r0.w, a0, c7
acaaaaaaabaaahacaaaaaakeacaaaaaaamaaaaoeabaaaaaa sub r1.xyz, r0.xyzz, c12
aaaaaaaaaaaaapaeaaaaaaoeacaaaaaaaaaaaaaaaaaaaaaa mov v0, r0
bcaaaaaaaaaaabacabaaaakeacaaaaaaabaaaakeacaaaaaa dp3 r0.x, r1.xyzz, r1.xyzz
akaaaaaaaaaaabacaaaaaaaaacaaaaaaaaaaaaaaaaaaaaaa rsq r0.x, r0.x
aaaaaaaaabaaahaeacaaaakeacaaaaaaaaaaaaaaaaaaaaaa mov v1.xyz, r2.xyzz
aaaaaaaaadaaapaeadaaaaoeaaaaaaaaaaaaaaaaaaaaaaaa mov v3, a3
adaaaaaaaeaaahaeaaaaaaaaacaaaaaaabaaaakeacaaaaaa mul v4.xyz, r0.x, r1.xyzz
bdaaaaaaaaaaaiadaaaaaaoeaaaaaaaaadaaaaoeabaaaaaa dp4 o0.w, a0, c3
bdaaaaaaaaaaaeadaaaaaaoeaaaaaaaaacaaaaoeabaaaaaa dp4 o0.z, a0, c2
bdaaaaaaaaaaacadaaaaaaoeaaaaaaaaabaaaaoeabaaaaaa dp4 o0.y, a0, c1
bdaaaaaaaaaaabadaaaaaaoeaaaaaaaaaaaaaaoeabaaaaaa dp4 o0.x, a0, c0
aaaaaaaaabaaaiaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v1.w, c0
aaaaaaaaacaaaiaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v2.w, c0
aaaaaaaaaeaaaiaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v4.w, c0
"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Vector 13 [_WorldSpaceCameraPos]
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Vector 14 [unity_4LightPosX0]
Vector 15 [unity_4LightPosY0]
Vector 16 [unity_4LightPosZ0]
Vector 17 [unity_4LightAtten0]
Vector 18 [unity_LightColor0]
Vector 19 [unity_LightColor1]
Vector 20 [unity_SHAr]
Vector 21 [unity_SHAg]
Vector 22 [unity_SHAb]
Vector 23 [unity_SHBr]
Vector 24 [unity_SHBg]
Vector 25 [unity_SHBb]
Vector 26 [unity_SHC]
Vector 27 [_Color]
Float 28 [_SHLightingScale]
"!!ARBvp1.0
# 69 ALU
PARAM c[29] = { { 0, 1 },
		state.matrix.mvp,
		program.local[5..28] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
MUL R0.xyz, vertex.normal.y, c[10];
MAD R0.xyz, vertex.normal.x, c[9], R0;
MAD R0.xyz, vertex.normal.z, c[11], R0;
ADD R0.xyz, R0, c[0].x;
DP3 R0.w, R0, R0;
RSQ R0.w, R0.w;
MUL R1.xyz, R0.w, R0;
MOV R0.xyz, R1;
MOV R0.w, c[0].y;
MUL R2, R1.xyzz, R1.yzzx;
DP4 R3.z, R0, c[22];
DP4 R3.y, R0, c[21];
DP4 R3.x, R0, c[20];
MUL R1.w, R1.y, R1.y;
MAD R0.w, R1.x, R1.x, -R1;
DP4 R0.z, R2, c[25];
DP4 R0.x, R2, c[23];
DP4 R0.y, R2, c[24];
ADD R3.xyz, R3, R0;
MUL R4.xyz, R0.w, c[26];
ADD R3.xyz, R3, R4;
DP4 R0.x, vertex.position, c[5];
DP4 R0.z, vertex.position, c[7];
DP4 R0.y, vertex.position, c[6];
MUL R4.xyz, R3, c[28].x;
MOV R2.x, c[14].y;
MOV R2.z, c[16].y;
MOV R2.y, c[15];
ADD R2.xyz, -R0, R2;
DP3 R0.w, R2, R2;
RSQ R1.w, R0.w;
MUL R2.xyz, R1.w, R2;
DP3 R2.x, R1, R2;
MUL R0.w, R0, c[17].y;
ADD R1.w, R0, c[0].y;
MAX R0.w, R2.x, c[0].x;
RCP R1.w, R1.w;
MOV R2.x, c[14];
MOV R2.z, c[16].x;
MOV R2.y, c[15].x;
ADD R3.xyz, -R0, R2;
MUL R2.xyz, R1.w, c[19];
MUL R2.xyz, R2, c[27];
DP3 R1.w, R3, R3;
MUL R2.xyz, R2, R0.w;
MUL R0.w, R1, c[17].x;
RSQ R1.w, R1.w;
MUL R3.xyz, R1.w, R3;
ADD R0.w, R0, c[0].y;
RCP R0.w, R0.w;
DP3 R1.w, R1, R3;
MUL R3.xyz, R0.w, c[18];
MAX R0.w, R1, c[0].x;
MUL R3.xyz, R3, c[27];
MUL R3.xyz, R3, R0.w;
ADD R2.xyz, R3, R2;
ADD result.texcoord[2].xyz, R2, R4;
DP4 R0.w, vertex.position, c[8];
ADD R2.xyz, R0, -c[13];
MOV result.texcoord[0], R0;
DP3 R0.x, R2, R2;
RSQ R0.x, R0.x;
MOV result.texcoord[1].xyz, R1;
MOV result.texcoord[3], vertex.texcoord[0];
MUL result.texcoord[4].xyz, R0.x, R2;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 69 instructions, 5 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 12 [_WorldSpaceCameraPos]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Vector 13 [unity_4LightPosX0]
Vector 14 [unity_4LightPosY0]
Vector 15 [unity_4LightPosZ0]
Vector 16 [unity_4LightAtten0]
Vector 17 [unity_LightColor0]
Vector 18 [unity_LightColor1]
Vector 19 [unity_SHAr]
Vector 20 [unity_SHAg]
Vector 21 [unity_SHAb]
Vector 22 [unity_SHBr]
Vector 23 [unity_SHBg]
Vector 24 [unity_SHBb]
Vector 25 [unity_SHC]
Vector 26 [_Color]
Float 27 [_SHLightingScale]
"vs_2_0
; 69 ALU
def c28, 0.00000000, 1.00000000, 0, 0
dcl_position0 v0
dcl_normal0 v1
dcl_texcoord0 v2
mul r0.xyz, v1.y, c9
mad r0.xyz, v1.x, c8, r0
mad r0.xyz, v1.z, c10, r0
add r0.xyz, r0, c28.x
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul r1.xyz, r0.w, r0
mul r2, r1.xyzz, r1.yzzx
mov r0.xyz, r1
mov r0.w, c28.y
dp4 r3.z, r0, c21
dp4 r3.y, r0, c20
dp4 r3.x, r0, c19
mul r1.w, r1.y, r1.y
mad r0.w, r1.x, r1.x, -r1
dp4 r0.z, r2, c24
dp4 r0.x, r2, c22
dp4 r0.y, r2, c23
add r3.xyz, r3, r0
mul r4.xyz, r0.w, c25
add r3.xyz, r3, r4
dp4 r0.x, v0, c4
dp4 r0.z, v0, c6
dp4 r0.y, v0, c5
mul r4.xyz, r3, c27.x
mov r2.x, c13.y
mov r2.z, c15.y
mov r2.y, c14
add r2.xyz, -r0, r2
dp3 r0.w, r2, r2
rsq r1.w, r0.w
mul r2.xyz, r1.w, r2
dp3 r1.w, r1, r2
mul r0.w, r0, c16.y
add r0.w, r0, c28.y
rcp r0.w, r0.w
mul r3.xyz, r0.w, c18
max r1.w, r1, c28.x
mul r3.xyz, r3, c26
mul r3.xyz, r3, r1.w
mov r2.x, c13
mov r2.z, c15.x
mov r2.y, c14.x
add r2.xyz, -r0, r2
dp3 r0.w, r2, r2
rsq r2.w, r0.w
mul r1.w, r0, c16.x
add r0.w, r1, c28.y
mul r2.xyz, r2.w, r2
rcp r0.w, r0.w
dp3 r1.w, r1, r2
mul r2.xyz, r0.w, c17
max r0.w, r1, c28.x
mul r2.xyz, r2, c26
mul r2.xyz, r2, r0.w
add r2.xyz, r2, r3
add oT2.xyz, r2, r4
dp4 r0.w, v0, c7
add r2.xyz, r0, -c12
mov oT0, r0
dp3 r0.x, r2, r2
rsq r0.x, r0.x
mov oT1.xyz, r1
mov oT3, v2
mul oT4.xyz, r0.x, r2
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" "VERTEXLIGHT_ON" }
"!!GLES
#define SHADER_API_GLES 1
#define tex2D texture2D


#ifdef VERTEX
#define gl_ModelViewProjectionMatrix glstate_matrix_mvp
uniform mat4 glstate_matrix_mvp;

varying lowp vec3 xlv_TEXCOORD4;
varying mediump vec4 xlv_TEXCOORD3;
varying lowp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 unity_SHC;
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_LightColor[4];
uniform highp vec4 unity_4LightPosZ0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightAtten0;

uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 _World2Object;
uniform lowp float _SHLightingScale;
uniform highp mat4 _Object2World;
uniform lowp vec4 _Color;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  highp vec3 shl;
  lowp vec3 diffuseReflection;
  lowp float attenuation;
  lowp vec3 vertexToLightSource;
  lowp vec4 lightPosition;
  lowp vec3 tmpvar_1;
  lowp vec3 tmpvar_2;
  lowp mat4 modelMatrixInverse;
  lowp mat4 modelMatrix;
  modelMatrix = (_Object2World);
  modelMatrixInverse = (_World2Object);
  highp vec4 tmpvar_3;
  tmpvar_3 = (modelMatrix * _glesVertex);
  lowp vec4 tmpvar_4;
  tmpvar_4.w = 0.0;
  tmpvar_4.xyz = normalize (_glesNormal);
  lowp vec3 tmpvar_5;
  tmpvar_5 = normalize ((tmpvar_4 * modelMatrixInverse).xyz);
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize (((modelMatrix * _glesVertex) - tmpvar_6).xyz);
  tmpvar_2 = tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.x = unity_4LightPosX0.x;
  tmpvar_8.y = unity_4LightPosY0.x;
  tmpvar_8.z = unity_4LightPosZ0.x;
  lightPosition = tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = (lightPosition - tmpvar_3).xyz;
  vertexToLightSource = tmpvar_9;
  lowp float tmpvar_10;
  tmpvar_10 = dot (vertexToLightSource, vertexToLightSource);
  highp float tmpvar_11;
  tmpvar_11 = (1.0/((1.0 + (unity_4LightAtten0.x * tmpvar_10))));
  attenuation = tmpvar_11;
  lowp float tmpvar_12;
  tmpvar_12 = max (0.0, dot (tmpvar_5, normalize (vertexToLightSource)));
  highp vec3 tmpvar_13;
  tmpvar_13 = (((attenuation * unity_LightColor[0].xyz) * _Color.xyz) * tmpvar_12);
  diffuseReflection = tmpvar_13;
  tmpvar_1 = diffuseReflection;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.x = unity_4LightPosX0.y;
  tmpvar_14.y = unity_4LightPosY0.y;
  tmpvar_14.z = unity_4LightPosZ0.y;
  lightPosition = tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = (lightPosition - tmpvar_3).xyz;
  vertexToLightSource = tmpvar_15;
  lowp float tmpvar_16;
  tmpvar_16 = dot (vertexToLightSource, vertexToLightSource);
  highp float tmpvar_17;
  tmpvar_17 = (1.0/((1.0 + (unity_4LightAtten0.y * tmpvar_16))));
  attenuation = tmpvar_17;
  lowp float tmpvar_18;
  tmpvar_18 = max (0.0, dot (tmpvar_5, normalize (vertexToLightSource)));
  highp vec3 tmpvar_19;
  tmpvar_19 = (((attenuation * unity_LightColor[1].xyz) * _Color.xyz) * tmpvar_18);
  diffuseReflection = tmpvar_19;
  tmpvar_1 = (tmpvar_1 + diffuseReflection);
  lowp vec4 tmpvar_20;
  tmpvar_20.w = 1.0;
  tmpvar_20.xyz = tmpvar_5;
  mediump vec3 tmpvar_21;
  mediump vec4 normal;
  normal = tmpvar_20;
  mediump vec3 x3;
  highp float vC;
  mediump vec3 x2;
  mediump vec3 x1;
  highp float tmpvar_22;
  tmpvar_22 = dot (unity_SHAr, normal);
  x1.x = tmpvar_22;
  highp float tmpvar_23;
  tmpvar_23 = dot (unity_SHAg, normal);
  x1.y = tmpvar_23;
  highp float tmpvar_24;
  tmpvar_24 = dot (unity_SHAb, normal);
  x1.z = tmpvar_24;
  mediump vec4 tmpvar_25;
  tmpvar_25 = (normal.xyzz * normal.yzzx);
  highp float tmpvar_26;
  tmpvar_26 = dot (unity_SHBr, tmpvar_25);
  x2.x = tmpvar_26;
  highp float tmpvar_27;
  tmpvar_27 = dot (unity_SHBg, tmpvar_25);
  x2.y = tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = dot (unity_SHBb, tmpvar_25);
  x2.z = tmpvar_28;
  mediump float tmpvar_29;
  tmpvar_29 = ((normal.x * normal.x) - (normal.y * normal.y));
  vC = tmpvar_29;
  highp vec3 tmpvar_30;
  tmpvar_30 = (unity_SHC.xyz * vC);
  x3 = tmpvar_30;
  tmpvar_21 = ((x1 + x2) + x3);
  shl = tmpvar_21;
  highp vec3 tmpvar_31;
  tmpvar_31 = (tmpvar_1 + (shl * _SHLightingScale));
  tmpvar_1 = tmpvar_31;
  gl_Position = (gl_ModelViewProjectionMatrix * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = tmpvar_1;
  xlv_TEXCOORD3 = _glesMultiTexCoord0;
  xlv_TEXCOORD4 = tmpvar_2;
}



#endif
#ifdef FRAGMENT
#define unity_LightColor0 _glesLightSource[0].diffuse
#define unity_LightColor1 _glesLightSource[1].diffuse
#define unity_LightColor2 _glesLightSource[2].diffuse
#define unity_LightColor3 _glesLightSource[3].diffuse
#define unity_LightPosition0 _glesLightSource[0].position
#define unity_LightPosition1 _glesLightSource[1].position
#define unity_LightPosition2 _glesLightSource[2].position
#define unity_LightPosition3 _glesLightSource[3].position
#define glstate_light0_spotDirection _glesLightSource[0].spotDirection
#define glstate_light1_spotDirection _glesLightSource[1].spotDirection
#define glstate_light2_spotDirection _glesLightSource[2].spotDirection
#define glstate_light3_spotDirection _glesLightSource[3].spotDirection
#define unity_LightAtten0 _glesLightSource[0].atten
#define unity_LightAtten1 _glesLightSource[1].atten
#define unity_LightAtten2 _glesLightSource[2].atten
#define unity_LightAtten3 _glesLightSource[3].atten
#define glstate_lightmodel_ambient _glesLightModel.ambient
#define gl_LightSource _glesLightSource
#define gl_LightSourceParameters _glesLightSourceParameters
struct _glesLightSourceParameters {
  vec4 diffuse;
  vec4 position;
  vec3 spotDirection;
  vec4 atten;
};
uniform _glesLightSourceParameters _glesLightSource[4];
#define gl_LightModel _glesLightModel
#define gl_LightModelParameters _glesLightModelParameters
struct _glesLightModelParameters {
  vec4 ambient;
};
uniform _glesLightModelParameters _glesLightModel;
#define gl_FrontMaterial _glesFrontMaterial
#define gl_BackMaterial _glesFrontMaterial
#define gl_MaterialParameters _glesMaterialParameters
struct _glesMaterialParameters {
  vec4 emission;
  vec4 ambient;
  vec4 diffuse;
  vec4 specular;
  float shininess;
};
uniform _glesMaterialParameters _glesFrontMaterial;

varying lowp vec3 xlv_TEXCOORD4;
varying mediump vec4 xlv_TEXCOORD3;
varying lowp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform lowp float _Reflection;

uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform lowp vec4 _SpecColor;
uniform mediump float _Shininess;
uniform sampler2D _MainTex;
uniform lowp vec4 _LightColor0;
uniform mediump float _Gloss;
uniform lowp float _FrezPow;
uniform mediump float _FrezFalloff;
uniform samplerCube _Cube;
uniform lowp vec4 _Color;
void main ()
{
  lowp float frez;
  lowp vec4 reflTex;
  lowp vec3 specularReflection;
  lowp vec3 ambientLighting;
  lowp vec3 vertexToLightSource;
  lowp vec3 lightDirection;
  lowp float attenuation;
  lowp vec3 viewDirection;
  lowp vec3 tmpvar_1;
  tmpvar_1 = normalize (xlv_TEXCOORD1);
  highp vec3 tmpvar_2;
  tmpvar_2 = normalize ((_WorldSpaceCameraPos - xlv_TEXCOORD0.xyz));
  viewDirection = tmpvar_2;
  mediump vec2 tmpvar_3;
  tmpvar_3 = xlv_TEXCOORD3.xy;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, tmpvar_3);
  if ((0.0 == _WorldSpaceLightPos0.w)) {
    attenuation = 1.0;
    lightDirection = normalize (_WorldSpaceLightPos0.xyz);
  } else {
    highp vec3 tmpvar_5;
    tmpvar_5 = (_WorldSpaceLightPos0 - xlv_TEXCOORD0).xyz;
    vertexToLightSource = tmpvar_5;
    attenuation = (1.0/(length (vertexToLightSource)));
    lightDirection = normalize (vertexToLightSource);
  };
  highp vec3 tmpvar_6;
  tmpvar_6 = (gl_LightModel.ambient.xyz * _Color.xyz);
  ambientLighting = tmpvar_6;
  lowp vec3 tmpvar_7;
  tmpvar_7 = (((attenuation * _LightColor0.xyz) * _Color.xyz) * max (0.0, dot (tmpvar_1, lightDirection)));
  lowp float tmpvar_8;
  tmpvar_8 = dot (tmpvar_1, lightDirection);
  if ((tmpvar_8 < 0.0)) {
    specularReflection = vec3(0.0, 0.0, 0.0);
  } else {
    lowp float tmpvar_9;
    tmpvar_9 = max (0.0, dot (reflect (-(lightDirection), tmpvar_1), viewDirection));
    mediump vec3 tmpvar_10;
    tmpvar_10 = (((attenuation * _LightColor0.xyz) * _SpecColor.xyz) * pow (tmpvar_9, _Shininess));
    specularReflection = tmpvar_10;
  };
  mediump vec3 tmpvar_11;
  tmpvar_11 = (specularReflection * _Gloss);
  specularReflection = tmpvar_11;
  lowp vec3 tmpvar_12;
  tmpvar_12 = reflect (xlv_TEXCOORD4, normalize (xlv_TEXCOORD1));
  lowp vec4 tmpvar_13;
  tmpvar_13 = textureCube (_Cube, tmpvar_12);
  reflTex = tmpvar_13;
  lowp float tmpvar_14;
  tmpvar_14 = clamp (abs (dot (tmpvar_12, xlv_TEXCOORD1)), 0.0, 1.0);
  mediump float tmpvar_15;
  tmpvar_15 = pow ((1.0 - tmpvar_14), _FrezFalloff);
  frez = tmpvar_15;
  lowp float tmpvar_16;
  tmpvar_16 = (frez * _FrezPow);
  frez = tmpvar_16;
  reflTex.xyz = (tmpvar_13.xyz * clamp ((_Reflection + tmpvar_16), 0.0, 1.0));
  lowp vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = ((tmpvar_4.xyz * clamp (((xlv_TEXCOORD2 + ambientLighting) + tmpvar_7), 0.0, 1.0)) + specularReflection);
  gl_FragData[0] = ((tmpvar_17 + reflTex) + (tmpvar_16 * reflTex));
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" "VERTEXLIGHT_ON" }
"!!GLES
#define SHADER_API_GLES 1
#define tex2D texture2D


#ifdef VERTEX
#define gl_ModelViewProjectionMatrix glstate_matrix_mvp
uniform mat4 glstate_matrix_mvp;

varying lowp vec3 xlv_TEXCOORD4;
varying mediump vec4 xlv_TEXCOORD3;
varying lowp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 unity_SHC;
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_LightColor[4];
uniform highp vec4 unity_4LightPosZ0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightAtten0;

uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 _World2Object;
uniform lowp float _SHLightingScale;
uniform highp mat4 _Object2World;
uniform lowp vec4 _Color;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  highp vec3 shl;
  lowp vec3 diffuseReflection;
  lowp float attenuation;
  lowp vec3 vertexToLightSource;
  lowp vec4 lightPosition;
  lowp vec3 tmpvar_1;
  lowp vec3 tmpvar_2;
  lowp mat4 modelMatrixInverse;
  lowp mat4 modelMatrix;
  modelMatrix = (_Object2World);
  modelMatrixInverse = (_World2Object);
  highp vec4 tmpvar_3;
  tmpvar_3 = (modelMatrix * _glesVertex);
  lowp vec4 tmpvar_4;
  tmpvar_4.w = 0.0;
  tmpvar_4.xyz = normalize (_glesNormal);
  lowp vec3 tmpvar_5;
  tmpvar_5 = normalize ((tmpvar_4 * modelMatrixInverse).xyz);
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize (((modelMatrix * _glesVertex) - tmpvar_6).xyz);
  tmpvar_2 = tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.x = unity_4LightPosX0.x;
  tmpvar_8.y = unity_4LightPosY0.x;
  tmpvar_8.z = unity_4LightPosZ0.x;
  lightPosition = tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = (lightPosition - tmpvar_3).xyz;
  vertexToLightSource = tmpvar_9;
  lowp float tmpvar_10;
  tmpvar_10 = dot (vertexToLightSource, vertexToLightSource);
  highp float tmpvar_11;
  tmpvar_11 = (1.0/((1.0 + (unity_4LightAtten0.x * tmpvar_10))));
  attenuation = tmpvar_11;
  lowp float tmpvar_12;
  tmpvar_12 = max (0.0, dot (tmpvar_5, normalize (vertexToLightSource)));
  highp vec3 tmpvar_13;
  tmpvar_13 = (((attenuation * unity_LightColor[0].xyz) * _Color.xyz) * tmpvar_12);
  diffuseReflection = tmpvar_13;
  tmpvar_1 = diffuseReflection;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.x = unity_4LightPosX0.y;
  tmpvar_14.y = unity_4LightPosY0.y;
  tmpvar_14.z = unity_4LightPosZ0.y;
  lightPosition = tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = (lightPosition - tmpvar_3).xyz;
  vertexToLightSource = tmpvar_15;
  lowp float tmpvar_16;
  tmpvar_16 = dot (vertexToLightSource, vertexToLightSource);
  highp float tmpvar_17;
  tmpvar_17 = (1.0/((1.0 + (unity_4LightAtten0.y * tmpvar_16))));
  attenuation = tmpvar_17;
  lowp float tmpvar_18;
  tmpvar_18 = max (0.0, dot (tmpvar_5, normalize (vertexToLightSource)));
  highp vec3 tmpvar_19;
  tmpvar_19 = (((attenuation * unity_LightColor[1].xyz) * _Color.xyz) * tmpvar_18);
  diffuseReflection = tmpvar_19;
  tmpvar_1 = (tmpvar_1 + diffuseReflection);
  lowp vec4 tmpvar_20;
  tmpvar_20.w = 1.0;
  tmpvar_20.xyz = tmpvar_5;
  mediump vec3 tmpvar_21;
  mediump vec4 normal;
  normal = tmpvar_20;
  mediump vec3 x3;
  highp float vC;
  mediump vec3 x2;
  mediump vec3 x1;
  highp float tmpvar_22;
  tmpvar_22 = dot (unity_SHAr, normal);
  x1.x = tmpvar_22;
  highp float tmpvar_23;
  tmpvar_23 = dot (unity_SHAg, normal);
  x1.y = tmpvar_23;
  highp float tmpvar_24;
  tmpvar_24 = dot (unity_SHAb, normal);
  x1.z = tmpvar_24;
  mediump vec4 tmpvar_25;
  tmpvar_25 = (normal.xyzz * normal.yzzx);
  highp float tmpvar_26;
  tmpvar_26 = dot (unity_SHBr, tmpvar_25);
  x2.x = tmpvar_26;
  highp float tmpvar_27;
  tmpvar_27 = dot (unity_SHBg, tmpvar_25);
  x2.y = tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = dot (unity_SHBb, tmpvar_25);
  x2.z = tmpvar_28;
  mediump float tmpvar_29;
  tmpvar_29 = ((normal.x * normal.x) - (normal.y * normal.y));
  vC = tmpvar_29;
  highp vec3 tmpvar_30;
  tmpvar_30 = (unity_SHC.xyz * vC);
  x3 = tmpvar_30;
  tmpvar_21 = ((x1 + x2) + x3);
  shl = tmpvar_21;
  highp vec3 tmpvar_31;
  tmpvar_31 = (tmpvar_1 + (shl * _SHLightingScale));
  tmpvar_1 = tmpvar_31;
  gl_Position = (gl_ModelViewProjectionMatrix * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = tmpvar_1;
  xlv_TEXCOORD3 = _glesMultiTexCoord0;
  xlv_TEXCOORD4 = tmpvar_2;
}



#endif
#ifdef FRAGMENT
#define unity_LightColor0 _glesLightSource[0].diffuse
#define unity_LightColor1 _glesLightSource[1].diffuse
#define unity_LightColor2 _glesLightSource[2].diffuse
#define unity_LightColor3 _glesLightSource[3].diffuse
#define unity_LightPosition0 _glesLightSource[0].position
#define unity_LightPosition1 _glesLightSource[1].position
#define unity_LightPosition2 _glesLightSource[2].position
#define unity_LightPosition3 _glesLightSource[3].position
#define glstate_light0_spotDirection _glesLightSource[0].spotDirection
#define glstate_light1_spotDirection _glesLightSource[1].spotDirection
#define glstate_light2_spotDirection _glesLightSource[2].spotDirection
#define glstate_light3_spotDirection _glesLightSource[3].spotDirection
#define unity_LightAtten0 _glesLightSource[0].atten
#define unity_LightAtten1 _glesLightSource[1].atten
#define unity_LightAtten2 _glesLightSource[2].atten
#define unity_LightAtten3 _glesLightSource[3].atten
#define glstate_lightmodel_ambient _glesLightModel.ambient
#define gl_LightSource _glesLightSource
#define gl_LightSourceParameters _glesLightSourceParameters
struct _glesLightSourceParameters {
  vec4 diffuse;
  vec4 position;
  vec3 spotDirection;
  vec4 atten;
};
uniform _glesLightSourceParameters _glesLightSource[4];
#define gl_LightModel _glesLightModel
#define gl_LightModelParameters _glesLightModelParameters
struct _glesLightModelParameters {
  vec4 ambient;
};
uniform _glesLightModelParameters _glesLightModel;
#define gl_FrontMaterial _glesFrontMaterial
#define gl_BackMaterial _glesFrontMaterial
#define gl_MaterialParameters _glesMaterialParameters
struct _glesMaterialParameters {
  vec4 emission;
  vec4 ambient;
  vec4 diffuse;
  vec4 specular;
  float shininess;
};
uniform _glesMaterialParameters _glesFrontMaterial;

varying lowp vec3 xlv_TEXCOORD4;
varying mediump vec4 xlv_TEXCOORD3;
varying lowp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform lowp float _Reflection;

uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform lowp vec4 _SpecColor;
uniform mediump float _Shininess;
uniform sampler2D _MainTex;
uniform lowp vec4 _LightColor0;
uniform mediump float _Gloss;
uniform lowp float _FrezPow;
uniform mediump float _FrezFalloff;
uniform samplerCube _Cube;
uniform lowp vec4 _Color;
void main ()
{
  lowp float frez;
  lowp vec4 reflTex;
  lowp vec3 specularReflection;
  lowp vec3 ambientLighting;
  lowp vec3 vertexToLightSource;
  lowp vec3 lightDirection;
  lowp float attenuation;
  lowp vec3 viewDirection;
  lowp vec3 tmpvar_1;
  tmpvar_1 = normalize (xlv_TEXCOORD1);
  highp vec3 tmpvar_2;
  tmpvar_2 = normalize ((_WorldSpaceCameraPos - xlv_TEXCOORD0.xyz));
  viewDirection = tmpvar_2;
  mediump vec2 tmpvar_3;
  tmpvar_3 = xlv_TEXCOORD3.xy;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, tmpvar_3);
  if ((0.0 == _WorldSpaceLightPos0.w)) {
    attenuation = 1.0;
    lightDirection = normalize (_WorldSpaceLightPos0.xyz);
  } else {
    highp vec3 tmpvar_5;
    tmpvar_5 = (_WorldSpaceLightPos0 - xlv_TEXCOORD0).xyz;
    vertexToLightSource = tmpvar_5;
    attenuation = (1.0/(length (vertexToLightSource)));
    lightDirection = normalize (vertexToLightSource);
  };
  highp vec3 tmpvar_6;
  tmpvar_6 = (gl_LightModel.ambient.xyz * _Color.xyz);
  ambientLighting = tmpvar_6;
  lowp vec3 tmpvar_7;
  tmpvar_7 = (((attenuation * _LightColor0.xyz) * _Color.xyz) * max (0.0, dot (tmpvar_1, lightDirection)));
  lowp float tmpvar_8;
  tmpvar_8 = dot (tmpvar_1, lightDirection);
  if ((tmpvar_8 < 0.0)) {
    specularReflection = vec3(0.0, 0.0, 0.0);
  } else {
    lowp float tmpvar_9;
    tmpvar_9 = max (0.0, dot (reflect (-(lightDirection), tmpvar_1), viewDirection));
    mediump vec3 tmpvar_10;
    tmpvar_10 = (((attenuation * _LightColor0.xyz) * _SpecColor.xyz) * pow (tmpvar_9, _Shininess));
    specularReflection = tmpvar_10;
  };
  mediump vec3 tmpvar_11;
  tmpvar_11 = (specularReflection * _Gloss);
  specularReflection = tmpvar_11;
  lowp vec3 tmpvar_12;
  tmpvar_12 = reflect (xlv_TEXCOORD4, normalize (xlv_TEXCOORD1));
  lowp vec4 tmpvar_13;
  tmpvar_13 = textureCube (_Cube, tmpvar_12);
  reflTex = tmpvar_13;
  lowp float tmpvar_14;
  tmpvar_14 = clamp (abs (dot (tmpvar_12, xlv_TEXCOORD1)), 0.0, 1.0);
  mediump float tmpvar_15;
  tmpvar_15 = pow ((1.0 - tmpvar_14), _FrezFalloff);
  frez = tmpvar_15;
  lowp float tmpvar_16;
  tmpvar_16 = (frez * _FrezPow);
  frez = tmpvar_16;
  reflTex.xyz = (tmpvar_13.xyz * clamp ((_Reflection + tmpvar_16), 0.0, 1.0));
  lowp vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = ((tmpvar_4.xyz * clamp (((xlv_TEXCOORD2 + ambientLighting) + tmpvar_7), 0.0, 1.0)) + specularReflection);
  gl_FragData[0] = ((tmpvar_17 + reflTex) + (tmpvar_16 * reflTex));
}



#endif"
}

SubProgram "flash " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 12 [_WorldSpaceCameraPos]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Vector 13 [unity_4LightPosX0]
Vector 14 [unity_4LightPosY0]
Vector 15 [unity_4LightPosZ0]
Vector 16 [unity_4LightAtten0]
Vector 17 [unity_LightColor0]
Vector 18 [unity_LightColor1]
Vector 19 [unity_SHAr]
Vector 20 [unity_SHAg]
Vector 21 [unity_SHAb]
Vector 22 [unity_SHBr]
Vector 23 [unity_SHBg]
Vector 24 [unity_SHBb]
Vector 25 [unity_SHC]
Vector 26 [_Color]
Float 27 [_SHLightingScale]
"agal_vs
c28 0.0 1.0 0.0 0.0
[bc]
adaaaaaaaaaaahacabaaaaffaaaaaaaaajaaaaoeabaaaaaa mul r0.xyz, a1.y, c9
adaaaaaaabaaahacabaaaaaaaaaaaaaaaiaaaaoeabaaaaaa mul r1.xyz, a1.x, c8
abaaaaaaaaaaahacabaaaakeacaaaaaaaaaaaakeacaaaaaa add r0.xyz, r1.xyzz, r0.xyzz
adaaaaaaacaaahacabaaaakkaaaaaaaaakaaaaoeabaaaaaa mul r2.xyz, a1.z, c10
abaaaaaaaaaaahacacaaaakeacaaaaaaaaaaaakeacaaaaaa add r0.xyz, r2.xyzz, r0.xyzz
abaaaaaaaaaaahacaaaaaakeacaaaaaabmaaaaaaabaaaaaa add r0.xyz, r0.xyzz, c28.x
bcaaaaaaaaaaaiacaaaaaakeacaaaaaaaaaaaakeacaaaaaa dp3 r0.w, r0.xyzz, r0.xyzz
akaaaaaaaaaaaiacaaaaaappacaaaaaaaaaaaaaaaaaaaaaa rsq r0.w, r0.w
adaaaaaaabaaahacaaaaaappacaaaaaaaaaaaakeacaaaaaa mul r1.xyz, r0.w, r0.xyzz
adaaaaaaacaaapacabaaaakeacaaaaaaabaaaacjacaaaaaa mul r2, r1.xyzz, r1.yzzx
aaaaaaaaaaaaahacabaaaakeacaaaaaaaaaaaaaaaaaaaaaa mov r0.xyz, r1.xyzz
aaaaaaaaaaaaaiacbmaaaaffabaaaaaaaaaaaaaaaaaaaaaa mov r0.w, c28.y
bdaaaaaaadaaaeacaaaaaaoeacaaaaaabfaaaaoeabaaaaaa dp4 r3.z, r0, c21
bdaaaaaaadaaacacaaaaaaoeacaaaaaabeaaaaoeabaaaaaa dp4 r3.y, r0, c20
bdaaaaaaadaaabacaaaaaaoeacaaaaaabdaaaaoeabaaaaaa dp4 r3.x, r0, c19
adaaaaaaabaaaiacabaaaaffacaaaaaaabaaaaffacaaaaaa mul r1.w, r1.y, r1.y
adaaaaaaadaaaiacabaaaaaaacaaaaaaabaaaaaaacaaaaaa mul r3.w, r1.x, r1.x
acaaaaaaaaaaaiacadaaaappacaaaaaaabaaaappacaaaaaa sub r0.w, r3.w, r1.w
bdaaaaaaaaaaaeacacaaaaoeacaaaaaabiaaaaoeabaaaaaa dp4 r0.z, r2, c24
bdaaaaaaaaaaabacacaaaaoeacaaaaaabgaaaaoeabaaaaaa dp4 r0.x, r2, c22
bdaaaaaaaaaaacacacaaaaoeacaaaaaabhaaaaoeabaaaaaa dp4 r0.y, r2, c23
abaaaaaaadaaahacadaaaakeacaaaaaaaaaaaakeacaaaaaa add r3.xyz, r3.xyzz, r0.xyzz
adaaaaaaaeaaahacaaaaaappacaaaaaabjaaaaoeabaaaaaa mul r4.xyz, r0.w, c25
abaaaaaaadaaahacadaaaakeacaaaaaaaeaaaakeacaaaaaa add r3.xyz, r3.xyzz, r4.xyzz
bdaaaaaaaaaaabacaaaaaaoeaaaaaaaaaeaaaaoeabaaaaaa dp4 r0.x, a0, c4
bdaaaaaaaaaaaeacaaaaaaoeaaaaaaaaagaaaaoeabaaaaaa dp4 r0.z, a0, c6
bdaaaaaaaaaaacacaaaaaaoeaaaaaaaaafaaaaoeabaaaaaa dp4 r0.y, a0, c5
adaaaaaaaeaaahacadaaaakeacaaaaaablaaaaaaabaaaaaa mul r4.xyz, r3.xyzz, c27.x
aaaaaaaaacaaabacanaaaaffabaaaaaaaaaaaaaaaaaaaaaa mov r2.x, c13.y
aaaaaaaaacaaaeacapaaaaffabaaaaaaaaaaaaaaaaaaaaaa mov r2.z, c15.y
aaaaaaaaacaaacacaoaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov r2.y, c14
bfaaaaaaafaaahacaaaaaakeacaaaaaaaaaaaaaaaaaaaaaa neg r5.xyz, r0.xyzz
abaaaaaaacaaahacafaaaakeacaaaaaaacaaaakeacaaaaaa add r2.xyz, r5.xyzz, r2.xyzz
bcaaaaaaaaaaaiacacaaaakeacaaaaaaacaaaakeacaaaaaa dp3 r0.w, r2.xyzz, r2.xyzz
akaaaaaaabaaaiacaaaaaappacaaaaaaaaaaaaaaaaaaaaaa rsq r1.w, r0.w
adaaaaaaacaaahacabaaaappacaaaaaaacaaaakeacaaaaaa mul r2.xyz, r1.w, r2.xyzz
bcaaaaaaabaaaiacabaaaakeacaaaaaaacaaaakeacaaaaaa dp3 r1.w, r1.xyzz, r2.xyzz
adaaaaaaaaaaaiacaaaaaappacaaaaaabaaaaaffabaaaaaa mul r0.w, r0.w, c16.y
abaaaaaaaaaaaiacaaaaaappacaaaaaabmaaaaffabaaaaaa add r0.w, r0.w, c28.y
afaaaaaaaaaaaiacaaaaaappacaaaaaaaaaaaaaaaaaaaaaa rcp r0.w, r0.w
adaaaaaaadaaahacaaaaaappacaaaaaabcaaaaoeabaaaaaa mul r3.xyz, r0.w, c18
ahaaaaaaabaaaiacabaaaappacaaaaaabmaaaaaaabaaaaaa max r1.w, r1.w, c28.x
adaaaaaaadaaahacadaaaakeacaaaaaabkaaaaoeabaaaaaa mul r3.xyz, r3.xyzz, c26
adaaaaaaadaaahacadaaaakeacaaaaaaabaaaappacaaaaaa mul r3.xyz, r3.xyzz, r1.w
aaaaaaaaacaaabacanaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov r2.x, c13
aaaaaaaaacaaaeacapaaaaaaabaaaaaaaaaaaaaaaaaaaaaa mov r2.z, c15.x
aaaaaaaaacaaacacaoaaaaaaabaaaaaaaaaaaaaaaaaaaaaa mov r2.y, c14.x
bfaaaaaaafaaahacaaaaaakeacaaaaaaaaaaaaaaaaaaaaaa neg r5.xyz, r0.xyzz
abaaaaaaacaaahacafaaaakeacaaaaaaacaaaakeacaaaaaa add r2.xyz, r5.xyzz, r2.xyzz
bcaaaaaaaaaaaiacacaaaakeacaaaaaaacaaaakeacaaaaaa dp3 r0.w, r2.xyzz, r2.xyzz
akaaaaaaacaaaiacaaaaaappacaaaaaaaaaaaaaaaaaaaaaa rsq r2.w, r0.w
adaaaaaaabaaaiacaaaaaappacaaaaaabaaaaaaaabaaaaaa mul r1.w, r0.w, c16.x
abaaaaaaaaaaaiacabaaaappacaaaaaabmaaaaffabaaaaaa add r0.w, r1.w, c28.y
adaaaaaaacaaahacacaaaappacaaaaaaacaaaakeacaaaaaa mul r2.xyz, r2.w, r2.xyzz
afaaaaaaaaaaaiacaaaaaappacaaaaaaaaaaaaaaaaaaaaaa rcp r0.w, r0.w
bcaaaaaaabaaaiacabaaaakeacaaaaaaacaaaakeacaaaaaa dp3 r1.w, r1.xyzz, r2.xyzz
adaaaaaaacaaahacaaaaaappacaaaaaabbaaaaoeabaaaaaa mul r2.xyz, r0.w, c17
ahaaaaaaaaaaaiacabaaaappacaaaaaabmaaaaaaabaaaaaa max r0.w, r1.w, c28.x
adaaaaaaacaaahacacaaaakeacaaaaaabkaaaaoeabaaaaaa mul r2.xyz, r2.xyzz, c26
adaaaaaaacaaahacacaaaakeacaaaaaaaaaaaappacaaaaaa mul r2.xyz, r2.xyzz, r0.w
abaaaaaaacaaahacacaaaakeacaaaaaaadaaaakeacaaaaaa add r2.xyz, r2.xyzz, r3.xyzz
abaaaaaaacaaahaeacaaaakeacaaaaaaaeaaaakeacaaaaaa add v2.xyz, r2.xyzz, r4.xyzz
bdaaaaaaaaaaaiacaaaaaaoeaaaaaaaaahaaaaoeabaaaaaa dp4 r0.w, a0, c7
acaaaaaaacaaahacaaaaaakeacaaaaaaamaaaaoeabaaaaaa sub r2.xyz, r0.xyzz, c12
aaaaaaaaaaaaapaeaaaaaaoeacaaaaaaaaaaaaaaaaaaaaaa mov v0, r0
bcaaaaaaaaaaabacacaaaakeacaaaaaaacaaaakeacaaaaaa dp3 r0.x, r2.xyzz, r2.xyzz
akaaaaaaaaaaabacaaaaaaaaacaaaaaaaaaaaaaaaaaaaaaa rsq r0.x, r0.x
aaaaaaaaabaaahaeabaaaakeacaaaaaaaaaaaaaaaaaaaaaa mov v1.xyz, r1.xyzz
aaaaaaaaadaaapaeadaaaaoeaaaaaaaaaaaaaaaaaaaaaaaa mov v3, a3
adaaaaaaaeaaahaeaaaaaaaaacaaaaaaacaaaakeacaaaaaa mul v4.xyz, r0.x, r2.xyzz
bdaaaaaaaaaaaiadaaaaaaoeaaaaaaaaadaaaaoeabaaaaaa dp4 o0.w, a0, c3
bdaaaaaaaaaaaeadaaaaaaoeaaaaaaaaacaaaaoeabaaaaaa dp4 o0.z, a0, c2
bdaaaaaaaaaaacadaaaaaaoeaaaaaaaaabaaaaoeabaaaaaa dp4 o0.y, a0, c1
bdaaaaaaaaaaabadaaaaaaoeaaaaaaaaaaaaaaoeabaaaaaa dp4 o0.x, a0, c0
aaaaaaaaabaaaiaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v1.w, c0
aaaaaaaaacaaaiaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v2.w, c0
aaaaaaaaaeaaaiaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v4.w, c0
"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Vector 13 [_WorldSpaceCameraPos]
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Vector 14 [unity_4LightPosX0]
Vector 15 [unity_4LightPosY0]
Vector 16 [unity_4LightPosZ0]
Vector 17 [unity_4LightAtten0]
Vector 18 [unity_LightColor0]
Vector 19 [unity_LightColor1]
Vector 20 [unity_SHAr]
Vector 21 [unity_SHAg]
Vector 22 [unity_SHAb]
Vector 23 [unity_SHBr]
Vector 24 [unity_SHBg]
Vector 25 [unity_SHBb]
Vector 26 [unity_SHC]
Vector 27 [_Color]
Float 28 [_SHLightingScale]
"!!ARBvp1.0
# 69 ALU
PARAM c[29] = { { 0, 1 },
		state.matrix.mvp,
		program.local[5..28] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
MUL R0.xyz, vertex.normal.y, c[10];
MAD R0.xyz, vertex.normal.x, c[9], R0;
MAD R0.xyz, vertex.normal.z, c[11], R0;
ADD R0.xyz, R0, c[0].x;
DP3 R0.w, R0, R0;
RSQ R0.w, R0.w;
MUL R1.xyz, R0.w, R0;
MOV R0.xyz, R1;
MOV R0.w, c[0].y;
MUL R2, R1.xyzz, R1.yzzx;
DP4 R3.z, R0, c[22];
DP4 R3.y, R0, c[21];
DP4 R3.x, R0, c[20];
MUL R1.w, R1.y, R1.y;
MAD R0.w, R1.x, R1.x, -R1;
DP4 R0.z, R2, c[25];
DP4 R0.x, R2, c[23];
DP4 R0.y, R2, c[24];
ADD R3.xyz, R3, R0;
MUL R4.xyz, R0.w, c[26];
ADD R3.xyz, R3, R4;
DP4 R0.x, vertex.position, c[5];
DP4 R0.z, vertex.position, c[7];
DP4 R0.y, vertex.position, c[6];
MUL R4.xyz, R3, c[28].x;
MOV R2.x, c[14].y;
MOV R2.z, c[16].y;
MOV R2.y, c[15];
ADD R2.xyz, -R0, R2;
DP3 R0.w, R2, R2;
RSQ R1.w, R0.w;
MUL R2.xyz, R1.w, R2;
DP3 R2.x, R1, R2;
MUL R0.w, R0, c[17].y;
ADD R1.w, R0, c[0].y;
MAX R0.w, R2.x, c[0].x;
RCP R1.w, R1.w;
MOV R2.x, c[14];
MOV R2.z, c[16].x;
MOV R2.y, c[15].x;
ADD R3.xyz, -R0, R2;
MUL R2.xyz, R1.w, c[19];
MUL R2.xyz, R2, c[27];
DP3 R1.w, R3, R3;
MUL R2.xyz, R2, R0.w;
MUL R0.w, R1, c[17].x;
RSQ R1.w, R1.w;
MUL R3.xyz, R1.w, R3;
ADD R0.w, R0, c[0].y;
RCP R0.w, R0.w;
DP3 R1.w, R1, R3;
MUL R3.xyz, R0.w, c[18];
MAX R0.w, R1, c[0].x;
MUL R3.xyz, R3, c[27];
MUL R3.xyz, R3, R0.w;
ADD R2.xyz, R3, R2;
ADD result.texcoord[2].xyz, R2, R4;
DP4 R0.w, vertex.position, c[8];
ADD R2.xyz, R0, -c[13];
MOV result.texcoord[0], R0;
DP3 R0.x, R2, R2;
RSQ R0.x, R0.x;
MOV result.texcoord[1].xyz, R1;
MOV result.texcoord[3], vertex.texcoord[0];
MUL result.texcoord[4].xyz, R0.x, R2;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 69 instructions, 5 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 12 [_WorldSpaceCameraPos]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Vector 13 [unity_4LightPosX0]
Vector 14 [unity_4LightPosY0]
Vector 15 [unity_4LightPosZ0]
Vector 16 [unity_4LightAtten0]
Vector 17 [unity_LightColor0]
Vector 18 [unity_LightColor1]
Vector 19 [unity_SHAr]
Vector 20 [unity_SHAg]
Vector 21 [unity_SHAb]
Vector 22 [unity_SHBr]
Vector 23 [unity_SHBg]
Vector 24 [unity_SHBb]
Vector 25 [unity_SHC]
Vector 26 [_Color]
Float 27 [_SHLightingScale]
"vs_2_0
; 69 ALU
def c28, 0.00000000, 1.00000000, 0, 0
dcl_position0 v0
dcl_normal0 v1
dcl_texcoord0 v2
mul r0.xyz, v1.y, c9
mad r0.xyz, v1.x, c8, r0
mad r0.xyz, v1.z, c10, r0
add r0.xyz, r0, c28.x
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul r1.xyz, r0.w, r0
mul r2, r1.xyzz, r1.yzzx
mov r0.xyz, r1
mov r0.w, c28.y
dp4 r3.z, r0, c21
dp4 r3.y, r0, c20
dp4 r3.x, r0, c19
mul r1.w, r1.y, r1.y
mad r0.w, r1.x, r1.x, -r1
dp4 r0.z, r2, c24
dp4 r0.x, r2, c22
dp4 r0.y, r2, c23
add r3.xyz, r3, r0
mul r4.xyz, r0.w, c25
add r3.xyz, r3, r4
dp4 r0.x, v0, c4
dp4 r0.z, v0, c6
dp4 r0.y, v0, c5
mul r4.xyz, r3, c27.x
mov r2.x, c13.y
mov r2.z, c15.y
mov r2.y, c14
add r2.xyz, -r0, r2
dp3 r0.w, r2, r2
rsq r1.w, r0.w
mul r2.xyz, r1.w, r2
dp3 r1.w, r1, r2
mul r0.w, r0, c16.y
add r0.w, r0, c28.y
rcp r0.w, r0.w
mul r3.xyz, r0.w, c18
max r1.w, r1, c28.x
mul r3.xyz, r3, c26
mul r3.xyz, r3, r1.w
mov r2.x, c13
mov r2.z, c15.x
mov r2.y, c14.x
add r2.xyz, -r0, r2
dp3 r0.w, r2, r2
rsq r2.w, r0.w
mul r1.w, r0, c16.x
add r0.w, r1, c28.y
mul r2.xyz, r2.w, r2
rcp r0.w, r0.w
dp3 r1.w, r1, r2
mul r2.xyz, r0.w, c17
max r0.w, r1, c28.x
mul r2.xyz, r2, c26
mul r2.xyz, r2, r0.w
add r2.xyz, r2, r3
add oT2.xyz, r2, r4
dp4 r0.w, v0, c7
add r2.xyz, r0, -c12
mov oT0, r0
dp3 r0.x, r2, r2
rsq r0.x, r0.x
mov oT1.xyz, r1
mov oT3, v2
mul oT4.xyz, r0.x, r2
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
"!!GLES
#define SHADER_API_GLES 1
#define tex2D texture2D


#ifdef VERTEX
#define gl_ModelViewProjectionMatrix glstate_matrix_mvp
uniform mat4 glstate_matrix_mvp;

varying lowp vec3 xlv_TEXCOORD4;
varying mediump vec4 xlv_TEXCOORD3;
varying lowp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 unity_SHC;
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_LightColor[4];
uniform highp vec4 unity_4LightPosZ0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightAtten0;

uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 _World2Object;
uniform lowp float _SHLightingScale;
uniform highp mat4 _Object2World;
uniform lowp vec4 _Color;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  highp vec3 shl;
  lowp vec3 diffuseReflection;
  lowp float attenuation;
  lowp vec3 vertexToLightSource;
  lowp vec4 lightPosition;
  lowp vec3 tmpvar_1;
  lowp vec3 tmpvar_2;
  lowp mat4 modelMatrixInverse;
  lowp mat4 modelMatrix;
  modelMatrix = (_Object2World);
  modelMatrixInverse = (_World2Object);
  highp vec4 tmpvar_3;
  tmpvar_3 = (modelMatrix * _glesVertex);
  lowp vec4 tmpvar_4;
  tmpvar_4.w = 0.0;
  tmpvar_4.xyz = normalize (_glesNormal);
  lowp vec3 tmpvar_5;
  tmpvar_5 = normalize ((tmpvar_4 * modelMatrixInverse).xyz);
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize (((modelMatrix * _glesVertex) - tmpvar_6).xyz);
  tmpvar_2 = tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.x = unity_4LightPosX0.x;
  tmpvar_8.y = unity_4LightPosY0.x;
  tmpvar_8.z = unity_4LightPosZ0.x;
  lightPosition = tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = (lightPosition - tmpvar_3).xyz;
  vertexToLightSource = tmpvar_9;
  lowp float tmpvar_10;
  tmpvar_10 = dot (vertexToLightSource, vertexToLightSource);
  highp float tmpvar_11;
  tmpvar_11 = (1.0/((1.0 + (unity_4LightAtten0.x * tmpvar_10))));
  attenuation = tmpvar_11;
  lowp float tmpvar_12;
  tmpvar_12 = max (0.0, dot (tmpvar_5, normalize (vertexToLightSource)));
  highp vec3 tmpvar_13;
  tmpvar_13 = (((attenuation * unity_LightColor[0].xyz) * _Color.xyz) * tmpvar_12);
  diffuseReflection = tmpvar_13;
  tmpvar_1 = diffuseReflection;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.x = unity_4LightPosX0.y;
  tmpvar_14.y = unity_4LightPosY0.y;
  tmpvar_14.z = unity_4LightPosZ0.y;
  lightPosition = tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = (lightPosition - tmpvar_3).xyz;
  vertexToLightSource = tmpvar_15;
  lowp float tmpvar_16;
  tmpvar_16 = dot (vertexToLightSource, vertexToLightSource);
  highp float tmpvar_17;
  tmpvar_17 = (1.0/((1.0 + (unity_4LightAtten0.y * tmpvar_16))));
  attenuation = tmpvar_17;
  lowp float tmpvar_18;
  tmpvar_18 = max (0.0, dot (tmpvar_5, normalize (vertexToLightSource)));
  highp vec3 tmpvar_19;
  tmpvar_19 = (((attenuation * unity_LightColor[1].xyz) * _Color.xyz) * tmpvar_18);
  diffuseReflection = tmpvar_19;
  tmpvar_1 = (tmpvar_1 + diffuseReflection);
  lowp vec4 tmpvar_20;
  tmpvar_20.w = 1.0;
  tmpvar_20.xyz = tmpvar_5;
  mediump vec3 tmpvar_21;
  mediump vec4 normal;
  normal = tmpvar_20;
  mediump vec3 x3;
  highp float vC;
  mediump vec3 x2;
  mediump vec3 x1;
  highp float tmpvar_22;
  tmpvar_22 = dot (unity_SHAr, normal);
  x1.x = tmpvar_22;
  highp float tmpvar_23;
  tmpvar_23 = dot (unity_SHAg, normal);
  x1.y = tmpvar_23;
  highp float tmpvar_24;
  tmpvar_24 = dot (unity_SHAb, normal);
  x1.z = tmpvar_24;
  mediump vec4 tmpvar_25;
  tmpvar_25 = (normal.xyzz * normal.yzzx);
  highp float tmpvar_26;
  tmpvar_26 = dot (unity_SHBr, tmpvar_25);
  x2.x = tmpvar_26;
  highp float tmpvar_27;
  tmpvar_27 = dot (unity_SHBg, tmpvar_25);
  x2.y = tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = dot (unity_SHBb, tmpvar_25);
  x2.z = tmpvar_28;
  mediump float tmpvar_29;
  tmpvar_29 = ((normal.x * normal.x) - (normal.y * normal.y));
  vC = tmpvar_29;
  highp vec3 tmpvar_30;
  tmpvar_30 = (unity_SHC.xyz * vC);
  x3 = tmpvar_30;
  tmpvar_21 = ((x1 + x2) + x3);
  shl = tmpvar_21;
  highp vec3 tmpvar_31;
  tmpvar_31 = (tmpvar_1 + (shl * _SHLightingScale));
  tmpvar_1 = tmpvar_31;
  gl_Position = (gl_ModelViewProjectionMatrix * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = tmpvar_1;
  xlv_TEXCOORD3 = _glesMultiTexCoord0;
  xlv_TEXCOORD4 = tmpvar_2;
}



#endif
#ifdef FRAGMENT
#define unity_LightColor0 _glesLightSource[0].diffuse
#define unity_LightColor1 _glesLightSource[1].diffuse
#define unity_LightColor2 _glesLightSource[2].diffuse
#define unity_LightColor3 _glesLightSource[3].diffuse
#define unity_LightPosition0 _glesLightSource[0].position
#define unity_LightPosition1 _glesLightSource[1].position
#define unity_LightPosition2 _glesLightSource[2].position
#define unity_LightPosition3 _glesLightSource[3].position
#define glstate_light0_spotDirection _glesLightSource[0].spotDirection
#define glstate_light1_spotDirection _glesLightSource[1].spotDirection
#define glstate_light2_spotDirection _glesLightSource[2].spotDirection
#define glstate_light3_spotDirection _glesLightSource[3].spotDirection
#define unity_LightAtten0 _glesLightSource[0].atten
#define unity_LightAtten1 _glesLightSource[1].atten
#define unity_LightAtten2 _glesLightSource[2].atten
#define unity_LightAtten3 _glesLightSource[3].atten
#define glstate_lightmodel_ambient _glesLightModel.ambient
#define gl_LightSource _glesLightSource
#define gl_LightSourceParameters _glesLightSourceParameters
struct _glesLightSourceParameters {
  vec4 diffuse;
  vec4 position;
  vec3 spotDirection;
  vec4 atten;
};
uniform _glesLightSourceParameters _glesLightSource[4];
#define gl_LightModel _glesLightModel
#define gl_LightModelParameters _glesLightModelParameters
struct _glesLightModelParameters {
  vec4 ambient;
};
uniform _glesLightModelParameters _glesLightModel;
#define gl_FrontMaterial _glesFrontMaterial
#define gl_BackMaterial _glesFrontMaterial
#define gl_MaterialParameters _glesMaterialParameters
struct _glesMaterialParameters {
  vec4 emission;
  vec4 ambient;
  vec4 diffuse;
  vec4 specular;
  float shininess;
};
uniform _glesMaterialParameters _glesFrontMaterial;

varying lowp vec3 xlv_TEXCOORD4;
varying mediump vec4 xlv_TEXCOORD3;
varying lowp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform lowp float _Reflection;

uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform lowp vec4 _SpecColor;
uniform mediump float _Shininess;
uniform sampler2D _MainTex;
uniform lowp vec4 _LightColor0;
uniform mediump float _Gloss;
uniform lowp float _FrezPow;
uniform mediump float _FrezFalloff;
uniform samplerCube _Cube;
uniform lowp vec4 _Color;
void main ()
{
  lowp float frez;
  lowp vec4 reflTex;
  lowp vec3 specularReflection;
  lowp vec3 ambientLighting;
  lowp vec3 vertexToLightSource;
  lowp vec3 lightDirection;
  lowp float attenuation;
  lowp vec3 viewDirection;
  lowp vec3 tmpvar_1;
  tmpvar_1 = normalize (xlv_TEXCOORD1);
  highp vec3 tmpvar_2;
  tmpvar_2 = normalize ((_WorldSpaceCameraPos - xlv_TEXCOORD0.xyz));
  viewDirection = tmpvar_2;
  mediump vec2 tmpvar_3;
  tmpvar_3 = xlv_TEXCOORD3.xy;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, tmpvar_3);
  if ((0.0 == _WorldSpaceLightPos0.w)) {
    attenuation = 1.0;
    lightDirection = normalize (_WorldSpaceLightPos0.xyz);
  } else {
    highp vec3 tmpvar_5;
    tmpvar_5 = (_WorldSpaceLightPos0 - xlv_TEXCOORD0).xyz;
    vertexToLightSource = tmpvar_5;
    attenuation = (1.0/(length (vertexToLightSource)));
    lightDirection = normalize (vertexToLightSource);
  };
  highp vec3 tmpvar_6;
  tmpvar_6 = (gl_LightModel.ambient.xyz * _Color.xyz);
  ambientLighting = tmpvar_6;
  lowp vec3 tmpvar_7;
  tmpvar_7 = (((attenuation * _LightColor0.xyz) * _Color.xyz) * max (0.0, dot (tmpvar_1, lightDirection)));
  lowp float tmpvar_8;
  tmpvar_8 = dot (tmpvar_1, lightDirection);
  if ((tmpvar_8 < 0.0)) {
    specularReflection = vec3(0.0, 0.0, 0.0);
  } else {
    lowp float tmpvar_9;
    tmpvar_9 = max (0.0, dot (reflect (-(lightDirection), tmpvar_1), viewDirection));
    mediump vec3 tmpvar_10;
    tmpvar_10 = (((attenuation * _LightColor0.xyz) * _SpecColor.xyz) * pow (tmpvar_9, _Shininess));
    specularReflection = tmpvar_10;
  };
  mediump vec3 tmpvar_11;
  tmpvar_11 = (specularReflection * _Gloss);
  specularReflection = tmpvar_11;
  lowp vec3 tmpvar_12;
  tmpvar_12 = reflect (xlv_TEXCOORD4, normalize (xlv_TEXCOORD1));
  lowp vec4 tmpvar_13;
  tmpvar_13 = textureCube (_Cube, tmpvar_12);
  reflTex = tmpvar_13;
  lowp float tmpvar_14;
  tmpvar_14 = clamp (abs (dot (tmpvar_12, xlv_TEXCOORD1)), 0.0, 1.0);
  mediump float tmpvar_15;
  tmpvar_15 = pow ((1.0 - tmpvar_14), _FrezFalloff);
  frez = tmpvar_15;
  lowp float tmpvar_16;
  tmpvar_16 = (frez * _FrezPow);
  frez = tmpvar_16;
  reflTex.xyz = (tmpvar_13.xyz * clamp ((_Reflection + tmpvar_16), 0.0, 1.0));
  lowp vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = ((tmpvar_4.xyz * clamp (((xlv_TEXCOORD2 + ambientLighting) + tmpvar_7), 0.0, 1.0)) + specularReflection);
  gl_FragData[0] = ((tmpvar_17 + reflTex) + (tmpvar_16 * reflTex));
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
"!!GLES
#define SHADER_API_GLES 1
#define tex2D texture2D


#ifdef VERTEX
#define gl_ModelViewProjectionMatrix glstate_matrix_mvp
uniform mat4 glstate_matrix_mvp;

varying lowp vec3 xlv_TEXCOORD4;
varying mediump vec4 xlv_TEXCOORD3;
varying lowp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 unity_SHC;
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_LightColor[4];
uniform highp vec4 unity_4LightPosZ0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightAtten0;

uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 _World2Object;
uniform lowp float _SHLightingScale;
uniform highp mat4 _Object2World;
uniform lowp vec4 _Color;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  highp vec3 shl;
  lowp vec3 diffuseReflection;
  lowp float attenuation;
  lowp vec3 vertexToLightSource;
  lowp vec4 lightPosition;
  lowp vec3 tmpvar_1;
  lowp vec3 tmpvar_2;
  lowp mat4 modelMatrixInverse;
  lowp mat4 modelMatrix;
  modelMatrix = (_Object2World);
  modelMatrixInverse = (_World2Object);
  highp vec4 tmpvar_3;
  tmpvar_3 = (modelMatrix * _glesVertex);
  lowp vec4 tmpvar_4;
  tmpvar_4.w = 0.0;
  tmpvar_4.xyz = normalize (_glesNormal);
  lowp vec3 tmpvar_5;
  tmpvar_5 = normalize ((tmpvar_4 * modelMatrixInverse).xyz);
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize (((modelMatrix * _glesVertex) - tmpvar_6).xyz);
  tmpvar_2 = tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.x = unity_4LightPosX0.x;
  tmpvar_8.y = unity_4LightPosY0.x;
  tmpvar_8.z = unity_4LightPosZ0.x;
  lightPosition = tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = (lightPosition - tmpvar_3).xyz;
  vertexToLightSource = tmpvar_9;
  lowp float tmpvar_10;
  tmpvar_10 = dot (vertexToLightSource, vertexToLightSource);
  highp float tmpvar_11;
  tmpvar_11 = (1.0/((1.0 + (unity_4LightAtten0.x * tmpvar_10))));
  attenuation = tmpvar_11;
  lowp float tmpvar_12;
  tmpvar_12 = max (0.0, dot (tmpvar_5, normalize (vertexToLightSource)));
  highp vec3 tmpvar_13;
  tmpvar_13 = (((attenuation * unity_LightColor[0].xyz) * _Color.xyz) * tmpvar_12);
  diffuseReflection = tmpvar_13;
  tmpvar_1 = diffuseReflection;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.x = unity_4LightPosX0.y;
  tmpvar_14.y = unity_4LightPosY0.y;
  tmpvar_14.z = unity_4LightPosZ0.y;
  lightPosition = tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = (lightPosition - tmpvar_3).xyz;
  vertexToLightSource = tmpvar_15;
  lowp float tmpvar_16;
  tmpvar_16 = dot (vertexToLightSource, vertexToLightSource);
  highp float tmpvar_17;
  tmpvar_17 = (1.0/((1.0 + (unity_4LightAtten0.y * tmpvar_16))));
  attenuation = tmpvar_17;
  lowp float tmpvar_18;
  tmpvar_18 = max (0.0, dot (tmpvar_5, normalize (vertexToLightSource)));
  highp vec3 tmpvar_19;
  tmpvar_19 = (((attenuation * unity_LightColor[1].xyz) * _Color.xyz) * tmpvar_18);
  diffuseReflection = tmpvar_19;
  tmpvar_1 = (tmpvar_1 + diffuseReflection);
  lowp vec4 tmpvar_20;
  tmpvar_20.w = 1.0;
  tmpvar_20.xyz = tmpvar_5;
  mediump vec3 tmpvar_21;
  mediump vec4 normal;
  normal = tmpvar_20;
  mediump vec3 x3;
  highp float vC;
  mediump vec3 x2;
  mediump vec3 x1;
  highp float tmpvar_22;
  tmpvar_22 = dot (unity_SHAr, normal);
  x1.x = tmpvar_22;
  highp float tmpvar_23;
  tmpvar_23 = dot (unity_SHAg, normal);
  x1.y = tmpvar_23;
  highp float tmpvar_24;
  tmpvar_24 = dot (unity_SHAb, normal);
  x1.z = tmpvar_24;
  mediump vec4 tmpvar_25;
  tmpvar_25 = (normal.xyzz * normal.yzzx);
  highp float tmpvar_26;
  tmpvar_26 = dot (unity_SHBr, tmpvar_25);
  x2.x = tmpvar_26;
  highp float tmpvar_27;
  tmpvar_27 = dot (unity_SHBg, tmpvar_25);
  x2.y = tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = dot (unity_SHBb, tmpvar_25);
  x2.z = tmpvar_28;
  mediump float tmpvar_29;
  tmpvar_29 = ((normal.x * normal.x) - (normal.y * normal.y));
  vC = tmpvar_29;
  highp vec3 tmpvar_30;
  tmpvar_30 = (unity_SHC.xyz * vC);
  x3 = tmpvar_30;
  tmpvar_21 = ((x1 + x2) + x3);
  shl = tmpvar_21;
  highp vec3 tmpvar_31;
  tmpvar_31 = (tmpvar_1 + (shl * _SHLightingScale));
  tmpvar_1 = tmpvar_31;
  gl_Position = (gl_ModelViewProjectionMatrix * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = tmpvar_1;
  xlv_TEXCOORD3 = _glesMultiTexCoord0;
  xlv_TEXCOORD4 = tmpvar_2;
}



#endif
#ifdef FRAGMENT
#define unity_LightColor0 _glesLightSource[0].diffuse
#define unity_LightColor1 _glesLightSource[1].diffuse
#define unity_LightColor2 _glesLightSource[2].diffuse
#define unity_LightColor3 _glesLightSource[3].diffuse
#define unity_LightPosition0 _glesLightSource[0].position
#define unity_LightPosition1 _glesLightSource[1].position
#define unity_LightPosition2 _glesLightSource[2].position
#define unity_LightPosition3 _glesLightSource[3].position
#define glstate_light0_spotDirection _glesLightSource[0].spotDirection
#define glstate_light1_spotDirection _glesLightSource[1].spotDirection
#define glstate_light2_spotDirection _glesLightSource[2].spotDirection
#define glstate_light3_spotDirection _glesLightSource[3].spotDirection
#define unity_LightAtten0 _glesLightSource[0].atten
#define unity_LightAtten1 _glesLightSource[1].atten
#define unity_LightAtten2 _glesLightSource[2].atten
#define unity_LightAtten3 _glesLightSource[3].atten
#define glstate_lightmodel_ambient _glesLightModel.ambient
#define gl_LightSource _glesLightSource
#define gl_LightSourceParameters _glesLightSourceParameters
struct _glesLightSourceParameters {
  vec4 diffuse;
  vec4 position;
  vec3 spotDirection;
  vec4 atten;
};
uniform _glesLightSourceParameters _glesLightSource[4];
#define gl_LightModel _glesLightModel
#define gl_LightModelParameters _glesLightModelParameters
struct _glesLightModelParameters {
  vec4 ambient;
};
uniform _glesLightModelParameters _glesLightModel;
#define gl_FrontMaterial _glesFrontMaterial
#define gl_BackMaterial _glesFrontMaterial
#define gl_MaterialParameters _glesMaterialParameters
struct _glesMaterialParameters {
  vec4 emission;
  vec4 ambient;
  vec4 diffuse;
  vec4 specular;
  float shininess;
};
uniform _glesMaterialParameters _glesFrontMaterial;

varying lowp vec3 xlv_TEXCOORD4;
varying mediump vec4 xlv_TEXCOORD3;
varying lowp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform lowp float _Reflection;

uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform lowp vec4 _SpecColor;
uniform mediump float _Shininess;
uniform sampler2D _MainTex;
uniform lowp vec4 _LightColor0;
uniform mediump float _Gloss;
uniform lowp float _FrezPow;
uniform mediump float _FrezFalloff;
uniform samplerCube _Cube;
uniform lowp vec4 _Color;
void main ()
{
  lowp float frez;
  lowp vec4 reflTex;
  lowp vec3 specularReflection;
  lowp vec3 ambientLighting;
  lowp vec3 vertexToLightSource;
  lowp vec3 lightDirection;
  lowp float attenuation;
  lowp vec3 viewDirection;
  lowp vec3 tmpvar_1;
  tmpvar_1 = normalize (xlv_TEXCOORD1);
  highp vec3 tmpvar_2;
  tmpvar_2 = normalize ((_WorldSpaceCameraPos - xlv_TEXCOORD0.xyz));
  viewDirection = tmpvar_2;
  mediump vec2 tmpvar_3;
  tmpvar_3 = xlv_TEXCOORD3.xy;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, tmpvar_3);
  if ((0.0 == _WorldSpaceLightPos0.w)) {
    attenuation = 1.0;
    lightDirection = normalize (_WorldSpaceLightPos0.xyz);
  } else {
    highp vec3 tmpvar_5;
    tmpvar_5 = (_WorldSpaceLightPos0 - xlv_TEXCOORD0).xyz;
    vertexToLightSource = tmpvar_5;
    attenuation = (1.0/(length (vertexToLightSource)));
    lightDirection = normalize (vertexToLightSource);
  };
  highp vec3 tmpvar_6;
  tmpvar_6 = (gl_LightModel.ambient.xyz * _Color.xyz);
  ambientLighting = tmpvar_6;
  lowp vec3 tmpvar_7;
  tmpvar_7 = (((attenuation * _LightColor0.xyz) * _Color.xyz) * max (0.0, dot (tmpvar_1, lightDirection)));
  lowp float tmpvar_8;
  tmpvar_8 = dot (tmpvar_1, lightDirection);
  if ((tmpvar_8 < 0.0)) {
    specularReflection = vec3(0.0, 0.0, 0.0);
  } else {
    lowp float tmpvar_9;
    tmpvar_9 = max (0.0, dot (reflect (-(lightDirection), tmpvar_1), viewDirection));
    mediump vec3 tmpvar_10;
    tmpvar_10 = (((attenuation * _LightColor0.xyz) * _SpecColor.xyz) * pow (tmpvar_9, _Shininess));
    specularReflection = tmpvar_10;
  };
  mediump vec3 tmpvar_11;
  tmpvar_11 = (specularReflection * _Gloss);
  specularReflection = tmpvar_11;
  lowp vec3 tmpvar_12;
  tmpvar_12 = reflect (xlv_TEXCOORD4, normalize (xlv_TEXCOORD1));
  lowp vec4 tmpvar_13;
  tmpvar_13 = textureCube (_Cube, tmpvar_12);
  reflTex = tmpvar_13;
  lowp float tmpvar_14;
  tmpvar_14 = clamp (abs (dot (tmpvar_12, xlv_TEXCOORD1)), 0.0, 1.0);
  mediump float tmpvar_15;
  tmpvar_15 = pow ((1.0 - tmpvar_14), _FrezFalloff);
  frez = tmpvar_15;
  lowp float tmpvar_16;
  tmpvar_16 = (frez * _FrezPow);
  frez = tmpvar_16;
  reflTex.xyz = (tmpvar_13.xyz * clamp ((_Reflection + tmpvar_16), 0.0, 1.0));
  lowp vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = ((tmpvar_4.xyz * clamp (((xlv_TEXCOORD2 + ambientLighting) + tmpvar_7), 0.0, 1.0)) + specularReflection);
  gl_FragData[0] = ((tmpvar_17 + reflTex) + (tmpvar_16 * reflTex));
}



#endif"
}

SubProgram "flash " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 12 [_WorldSpaceCameraPos]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Vector 13 [unity_4LightPosX0]
Vector 14 [unity_4LightPosY0]
Vector 15 [unity_4LightPosZ0]
Vector 16 [unity_4LightAtten0]
Vector 17 [unity_LightColor0]
Vector 18 [unity_LightColor1]
Vector 19 [unity_SHAr]
Vector 20 [unity_SHAg]
Vector 21 [unity_SHAb]
Vector 22 [unity_SHBr]
Vector 23 [unity_SHBg]
Vector 24 [unity_SHBb]
Vector 25 [unity_SHC]
Vector 26 [_Color]
Float 27 [_SHLightingScale]
"agal_vs
c28 0.0 1.0 0.0 0.0
[bc]
adaaaaaaaaaaahacabaaaaffaaaaaaaaajaaaaoeabaaaaaa mul r0.xyz, a1.y, c9
adaaaaaaabaaahacabaaaaaaaaaaaaaaaiaaaaoeabaaaaaa mul r1.xyz, a1.x, c8
abaaaaaaaaaaahacabaaaakeacaaaaaaaaaaaakeacaaaaaa add r0.xyz, r1.xyzz, r0.xyzz
adaaaaaaacaaahacabaaaakkaaaaaaaaakaaaaoeabaaaaaa mul r2.xyz, a1.z, c10
abaaaaaaaaaaahacacaaaakeacaaaaaaaaaaaakeacaaaaaa add r0.xyz, r2.xyzz, r0.xyzz
abaaaaaaaaaaahacaaaaaakeacaaaaaabmaaaaaaabaaaaaa add r0.xyz, r0.xyzz, c28.x
bcaaaaaaaaaaaiacaaaaaakeacaaaaaaaaaaaakeacaaaaaa dp3 r0.w, r0.xyzz, r0.xyzz
akaaaaaaaaaaaiacaaaaaappacaaaaaaaaaaaaaaaaaaaaaa rsq r0.w, r0.w
adaaaaaaabaaahacaaaaaappacaaaaaaaaaaaakeacaaaaaa mul r1.xyz, r0.w, r0.xyzz
adaaaaaaacaaapacabaaaakeacaaaaaaabaaaacjacaaaaaa mul r2, r1.xyzz, r1.yzzx
aaaaaaaaaaaaahacabaaaakeacaaaaaaaaaaaaaaaaaaaaaa mov r0.xyz, r1.xyzz
aaaaaaaaaaaaaiacbmaaaaffabaaaaaaaaaaaaaaaaaaaaaa mov r0.w, c28.y
bdaaaaaaadaaaeacaaaaaaoeacaaaaaabfaaaaoeabaaaaaa dp4 r3.z, r0, c21
bdaaaaaaadaaacacaaaaaaoeacaaaaaabeaaaaoeabaaaaaa dp4 r3.y, r0, c20
bdaaaaaaadaaabacaaaaaaoeacaaaaaabdaaaaoeabaaaaaa dp4 r3.x, r0, c19
adaaaaaaabaaaiacabaaaaffacaaaaaaabaaaaffacaaaaaa mul r1.w, r1.y, r1.y
adaaaaaaadaaaiacabaaaaaaacaaaaaaabaaaaaaacaaaaaa mul r3.w, r1.x, r1.x
acaaaaaaaaaaaiacadaaaappacaaaaaaabaaaappacaaaaaa sub r0.w, r3.w, r1.w
bdaaaaaaaaaaaeacacaaaaoeacaaaaaabiaaaaoeabaaaaaa dp4 r0.z, r2, c24
bdaaaaaaaaaaabacacaaaaoeacaaaaaabgaaaaoeabaaaaaa dp4 r0.x, r2, c22
bdaaaaaaaaaaacacacaaaaoeacaaaaaabhaaaaoeabaaaaaa dp4 r0.y, r2, c23
abaaaaaaadaaahacadaaaakeacaaaaaaaaaaaakeacaaaaaa add r3.xyz, r3.xyzz, r0.xyzz
adaaaaaaaeaaahacaaaaaappacaaaaaabjaaaaoeabaaaaaa mul r4.xyz, r0.w, c25
abaaaaaaadaaahacadaaaakeacaaaaaaaeaaaakeacaaaaaa add r3.xyz, r3.xyzz, r4.xyzz
bdaaaaaaaaaaabacaaaaaaoeaaaaaaaaaeaaaaoeabaaaaaa dp4 r0.x, a0, c4
bdaaaaaaaaaaaeacaaaaaaoeaaaaaaaaagaaaaoeabaaaaaa dp4 r0.z, a0, c6
bdaaaaaaaaaaacacaaaaaaoeaaaaaaaaafaaaaoeabaaaaaa dp4 r0.y, a0, c5
adaaaaaaaeaaahacadaaaakeacaaaaaablaaaaaaabaaaaaa mul r4.xyz, r3.xyzz, c27.x
aaaaaaaaacaaabacanaaaaffabaaaaaaaaaaaaaaaaaaaaaa mov r2.x, c13.y
aaaaaaaaacaaaeacapaaaaffabaaaaaaaaaaaaaaaaaaaaaa mov r2.z, c15.y
aaaaaaaaacaaacacaoaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov r2.y, c14
bfaaaaaaafaaahacaaaaaakeacaaaaaaaaaaaaaaaaaaaaaa neg r5.xyz, r0.xyzz
abaaaaaaacaaahacafaaaakeacaaaaaaacaaaakeacaaaaaa add r2.xyz, r5.xyzz, r2.xyzz
bcaaaaaaaaaaaiacacaaaakeacaaaaaaacaaaakeacaaaaaa dp3 r0.w, r2.xyzz, r2.xyzz
akaaaaaaabaaaiacaaaaaappacaaaaaaaaaaaaaaaaaaaaaa rsq r1.w, r0.w
adaaaaaaacaaahacabaaaappacaaaaaaacaaaakeacaaaaaa mul r2.xyz, r1.w, r2.xyzz
bcaaaaaaabaaaiacabaaaakeacaaaaaaacaaaakeacaaaaaa dp3 r1.w, r1.xyzz, r2.xyzz
adaaaaaaaaaaaiacaaaaaappacaaaaaabaaaaaffabaaaaaa mul r0.w, r0.w, c16.y
abaaaaaaaaaaaiacaaaaaappacaaaaaabmaaaaffabaaaaaa add r0.w, r0.w, c28.y
afaaaaaaaaaaaiacaaaaaappacaaaaaaaaaaaaaaaaaaaaaa rcp r0.w, r0.w
adaaaaaaadaaahacaaaaaappacaaaaaabcaaaaoeabaaaaaa mul r3.xyz, r0.w, c18
ahaaaaaaabaaaiacabaaaappacaaaaaabmaaaaaaabaaaaaa max r1.w, r1.w, c28.x
adaaaaaaadaaahacadaaaakeacaaaaaabkaaaaoeabaaaaaa mul r3.xyz, r3.xyzz, c26
adaaaaaaadaaahacadaaaakeacaaaaaaabaaaappacaaaaaa mul r3.xyz, r3.xyzz, r1.w
aaaaaaaaacaaabacanaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov r2.x, c13
aaaaaaaaacaaaeacapaaaaaaabaaaaaaaaaaaaaaaaaaaaaa mov r2.z, c15.x
aaaaaaaaacaaacacaoaaaaaaabaaaaaaaaaaaaaaaaaaaaaa mov r2.y, c14.x
bfaaaaaaafaaahacaaaaaakeacaaaaaaaaaaaaaaaaaaaaaa neg r5.xyz, r0.xyzz
abaaaaaaacaaahacafaaaakeacaaaaaaacaaaakeacaaaaaa add r2.xyz, r5.xyzz, r2.xyzz
bcaaaaaaaaaaaiacacaaaakeacaaaaaaacaaaakeacaaaaaa dp3 r0.w, r2.xyzz, r2.xyzz
akaaaaaaacaaaiacaaaaaappacaaaaaaaaaaaaaaaaaaaaaa rsq r2.w, r0.w
adaaaaaaabaaaiacaaaaaappacaaaaaabaaaaaaaabaaaaaa mul r1.w, r0.w, c16.x
abaaaaaaaaaaaiacabaaaappacaaaaaabmaaaaffabaaaaaa add r0.w, r1.w, c28.y
adaaaaaaacaaahacacaaaappacaaaaaaacaaaakeacaaaaaa mul r2.xyz, r2.w, r2.xyzz
afaaaaaaaaaaaiacaaaaaappacaaaaaaaaaaaaaaaaaaaaaa rcp r0.w, r0.w
bcaaaaaaabaaaiacabaaaakeacaaaaaaacaaaakeacaaaaaa dp3 r1.w, r1.xyzz, r2.xyzz
adaaaaaaacaaahacaaaaaappacaaaaaabbaaaaoeabaaaaaa mul r2.xyz, r0.w, c17
ahaaaaaaaaaaaiacabaaaappacaaaaaabmaaaaaaabaaaaaa max r0.w, r1.w, c28.x
adaaaaaaacaaahacacaaaakeacaaaaaabkaaaaoeabaaaaaa mul r2.xyz, r2.xyzz, c26
adaaaaaaacaaahacacaaaakeacaaaaaaaaaaaappacaaaaaa mul r2.xyz, r2.xyzz, r0.w
abaaaaaaacaaahacacaaaakeacaaaaaaadaaaakeacaaaaaa add r2.xyz, r2.xyzz, r3.xyzz
abaaaaaaacaaahaeacaaaakeacaaaaaaaeaaaakeacaaaaaa add v2.xyz, r2.xyzz, r4.xyzz
bdaaaaaaaaaaaiacaaaaaaoeaaaaaaaaahaaaaoeabaaaaaa dp4 r0.w, a0, c7
acaaaaaaacaaahacaaaaaakeacaaaaaaamaaaaoeabaaaaaa sub r2.xyz, r0.xyzz, c12
aaaaaaaaaaaaapaeaaaaaaoeacaaaaaaaaaaaaaaaaaaaaaa mov v0, r0
bcaaaaaaaaaaabacacaaaakeacaaaaaaacaaaakeacaaaaaa dp3 r0.x, r2.xyzz, r2.xyzz
akaaaaaaaaaaabacaaaaaaaaacaaaaaaaaaaaaaaaaaaaaaa rsq r0.x, r0.x
aaaaaaaaabaaahaeabaaaakeacaaaaaaaaaaaaaaaaaaaaaa mov v1.xyz, r1.xyzz
aaaaaaaaadaaapaeadaaaaoeaaaaaaaaaaaaaaaaaaaaaaaa mov v3, a3
adaaaaaaaeaaahaeaaaaaaaaacaaaaaaacaaaakeacaaaaaa mul v4.xyz, r0.x, r2.xyzz
bdaaaaaaaaaaaiadaaaaaaoeaaaaaaaaadaaaaoeabaaaaaa dp4 o0.w, a0, c3
bdaaaaaaaaaaaeadaaaaaaoeaaaaaaaaacaaaaoeabaaaaaa dp4 o0.z, a0, c2
bdaaaaaaaaaaacadaaaaaaoeaaaaaaaaabaaaaoeabaaaaaa dp4 o0.y, a0, c1
bdaaaaaaaaaaabadaaaaaaoeaaaaaaaaaaaaaaoeabaaaaaa dp4 o0.x, a0, c0
aaaaaaaaabaaaiaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v1.w, c0
aaaaaaaaacaaaiaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v2.w, c0
aaaaaaaaaeaaaiaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v4.w, c0
"
}

}
Program "fp" {
// Fragment combos: 6
//   opengl - ALU: 55 to 55, TEX: 2 to 2
//   d3d9 - ALU: 59 to 59, TEX: 2 to 2
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
Vector 1 [_WorldSpaceCameraPos]
Vector 2 [_WorldSpaceLightPos0]
Vector 3 [_Color]
Float 4 [_Reflection]
Vector 5 [_SpecColor]
Float 6 [_Shininess]
Float 7 [_Gloss]
Float 8 [_FrezPow]
Float 9 [_FrezFalloff]
Vector 10 [_LightColor0]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_Cube] CUBE
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 55 ALU, 2 TEX
PARAM c[12] = { state.lightmodel.ambient,
		program.local[1..10],
		{ 2, 1, 0 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
TEMP R6;
TEX R1.xyz, fragment.texcoord[3], texture[0], 2D;
ADD R4.xyz, -fragment.texcoord[0], c[2];
DP3 R1.w, R4, R4;
RSQ R2.w, R1.w;
ADD R6.xyz, -fragment.texcoord[0], c[1];
DP3 R0.x, fragment.texcoord[1], fragment.texcoord[1];
RSQ R0.x, R0.x;
MUL R2.xyz, R0.x, fragment.texcoord[1];
DP3 R0.x, R2, fragment.texcoord[4];
MUL R0.xyz, R2, R0.x;
MAD R3.xyz, -R0, c[11].x, fragment.texcoord[4];
ABS R1.w, -c[2];
DP3 R3.w, c[2], c[2];
RSQ R3.w, R3.w;
CMP R1.w, -R1, c[11].z, c[11].y;
DP3 R4.w, R6, R6;
MUL R5.xyz, R3.w, c[2];
ABS R1.w, R1;
CMP R3.w, -R1, c[11].z, c[11].y;
MUL R4.xyz, R2.w, R4;
CMP R4.xyz, -R3.w, R4, R5;
DP3 R1.w, R2, R4;
MUL R2.xyz, R2, -R1.w;
RSQ R4.w, R4.w;
MAD R2.xyz, -R2, c[11].x, -R4;
MUL R5.xyz, R4.w, R6;
DP3 R2.x, R2, R5;
MAX R2.x, R2, c[11].z;
POW R4.w, R2.x, c[6].x;
CMP R2.x, -R3.w, R2.w, c[11].y;
SLT R2.w, R1, c[11].z;
MUL R2.xyz, R2.x, c[10];
MUL R4.xyz, R2, c[5];
ABS R2.w, R2;
CMP R3.w, -R2, c[11].z, c[11].y;
DP3 R2.w, R3, fragment.texcoord[1];
MUL R4.xyz, R4, R4.w;
ABS_SAT R2.w, R2;
MUL R2.xyz, R2, c[3];
TEX R0, R3, texture[1], CUBE;
CMP R3.xyz, -R3.w, R4, c[11].z;
ADD R3.w, -R2, c[11].y;
MAX R2.w, R1, c[11].z;
POW R1.w, R3.w, c[9].x;
MOV R4.xyz, c[3];
MAD R4.xyz, R4, c[0], fragment.texcoord[2];
MAD_SAT R2.xyz, R2, R2.w, R4;
MUL R1.w, R1, c[8].x;
ADD_SAT R2.w, R1, c[4].x;
MUL R0.xyz, R0, R2.w;
MUL R3.xyz, R3, c[7].x;
MAD R2.xyz, R1, R2, R3;
MOV R2.w, c[11].y;
ADD R2, R0, R2;
MAD result.color, R1.w, R0, R2;
END
# 55 instructions, 7 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
Vector 0 [glstate_lightmodel_ambient]
Vector 1 [_WorldSpaceCameraPos]
Vector 2 [_WorldSpaceLightPos0]
Vector 3 [_Color]
Float 4 [_Reflection]
Vector 5 [_SpecColor]
Float 6 [_Shininess]
Float 7 [_Gloss]
Float 8 [_FrezPow]
Float 9 [_FrezFalloff]
Vector 10 [_LightColor0]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_Cube] CUBE
"ps_2_0
; 59 ALU, 2 TEX
dcl_2d s0
dcl_cube s1
def c11, 2.00000000, 1.00000000, 0.00000000, 0
dcl t0.xyz
dcl t1.xyz
dcl t2.xyz
dcl t3.xy
dcl t4.xyz
texld r5, t3, s0
dp3_pp r0.x, t1, t1
rsq_pp r0.x, r0.x
mul_pp r6.xyz, r0.x, t1
dp3_pp r0.x, r6, t4
mul_pp r0.xyz, r6, r0.x
mad_pp r7.xyz, -r0, c11.x, t4
add r2.xyz, -t0, c2
dp3_pp r0.x, r2, r2
rsq_pp r1.x, r0.x
mul_pp r3.xyz, r1.x, r2
dp3_pp r2.x, c2, c2
rsq_pp r2.x, r2.x
abs_pp r0.x, -c2.w
add r8.xyz, -t0, c1
cmp_pp r0.x, -r0, c11.y, c11.z
mul_pp r9.xyz, r2.x, c2
abs_pp r2.x, r0
cmp_pp r9.xyz, -r2.x, r3, r9
dp3_pp r0.x, r6, r9
mul_pp r6.xyz, r6, -r0.x
dp3 r3.x, r8, r8
rsq r3.x, r3.x
mul r3.xyz, r3.x, r8
mad_pp r6.xyz, -r6, c11.x, -r9
dp3_pp r3.x, r6, r3
max_pp r3.x, r3, c11.z
pow_pp r6.w, r3.x, c6.x
cmp_pp r1.x, -r2, r1, c11.y
mul_pp r3.xyz, r1.x, c10
mul_pp r2.xyz, r3, c5
mov_pp r1.x, r6.w
mul_pp r8.xyz, r2, r1.x
cmp_pp r1.x, r0, c11.z, c11.y
dp3_pp r2.x, r7, t1
abs_pp r6.x, r1
abs_pp_sat r1.x, r2
cmp_pp r2.xyz, -r6.x, r8, c11.z
add_pp r1.x, -r1, c11.y
mul_pp r6.xyz, r2, c7.x
pow_pp r2.x, r1.x, c9.x
max_pp r1.x, r0, c11.z
mov_pp r0.x, r2.x
mul_pp r0.x, r0, c8
mul_pp r3.xyz, r3, c3
mov_pp r2.w, c11.y
texld r4, r7, s1
mov_pp r7.xyz, c0
mad_pp r2.xyz, c3, r7, t2
mad_pp_sat r1.xyz, r3, r1.x, r2
mad_pp r2.xyz, r5, r1, r6
add_pp_sat r1.x, r0, c4
mul_pp r1.xyz, r4, r1.x
mov_pp r1.w, r4
add_pp r2, r1, r2
mad_pp r0, r0.x, r1, r2
mov_pp oC0, r0
"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
"!!GLES"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
"!!GLES"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
Vector 1 [_WorldSpaceCameraPos]
Vector 2 [_WorldSpaceLightPos0]
Vector 3 [_Color]
Float 4 [_Reflection]
Vector 5 [_SpecColor]
Float 6 [_Shininess]
Float 7 [_Gloss]
Float 8 [_FrezPow]
Float 9 [_FrezFalloff]
Vector 10 [_LightColor0]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_Cube] CUBE
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 55 ALU, 2 TEX
PARAM c[12] = { state.lightmodel.ambient,
		program.local[1..10],
		{ 2, 1, 0 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
TEMP R6;
TEX R1.xyz, fragment.texcoord[3], texture[0], 2D;
ADD R4.xyz, -fragment.texcoord[0], c[2];
DP3 R1.w, R4, R4;
RSQ R2.w, R1.w;
ADD R6.xyz, -fragment.texcoord[0], c[1];
DP3 R0.x, fragment.texcoord[1], fragment.texcoord[1];
RSQ R0.x, R0.x;
MUL R2.xyz, R0.x, fragment.texcoord[1];
DP3 R0.x, R2, fragment.texcoord[4];
MUL R0.xyz, R2, R0.x;
MAD R3.xyz, -R0, c[11].x, fragment.texcoord[4];
ABS R1.w, -c[2];
DP3 R3.w, c[2], c[2];
RSQ R3.w, R3.w;
CMP R1.w, -R1, c[11].z, c[11].y;
DP3 R4.w, R6, R6;
MUL R5.xyz, R3.w, c[2];
ABS R1.w, R1;
CMP R3.w, -R1, c[11].z, c[11].y;
MUL R4.xyz, R2.w, R4;
CMP R4.xyz, -R3.w, R4, R5;
DP3 R1.w, R2, R4;
MUL R2.xyz, R2, -R1.w;
RSQ R4.w, R4.w;
MAD R2.xyz, -R2, c[11].x, -R4;
MUL R5.xyz, R4.w, R6;
DP3 R2.x, R2, R5;
MAX R2.x, R2, c[11].z;
POW R4.w, R2.x, c[6].x;
CMP R2.x, -R3.w, R2.w, c[11].y;
SLT R2.w, R1, c[11].z;
MUL R2.xyz, R2.x, c[10];
MUL R4.xyz, R2, c[5];
ABS R2.w, R2;
CMP R3.w, -R2, c[11].z, c[11].y;
DP3 R2.w, R3, fragment.texcoord[1];
MUL R4.xyz, R4, R4.w;
ABS_SAT R2.w, R2;
MUL R2.xyz, R2, c[3];
TEX R0, R3, texture[1], CUBE;
CMP R3.xyz, -R3.w, R4, c[11].z;
ADD R3.w, -R2, c[11].y;
MAX R2.w, R1, c[11].z;
POW R1.w, R3.w, c[9].x;
MOV R4.xyz, c[3];
MAD R4.xyz, R4, c[0], fragment.texcoord[2];
MAD_SAT R2.xyz, R2, R2.w, R4;
MUL R1.w, R1, c[8].x;
ADD_SAT R2.w, R1, c[4].x;
MUL R0.xyz, R0, R2.w;
MUL R3.xyz, R3, c[7].x;
MAD R2.xyz, R1, R2, R3;
MOV R2.w, c[11].y;
ADD R2, R0, R2;
MAD result.color, R1.w, R0, R2;
END
# 55 instructions, 7 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
Vector 0 [glstate_lightmodel_ambient]
Vector 1 [_WorldSpaceCameraPos]
Vector 2 [_WorldSpaceLightPos0]
Vector 3 [_Color]
Float 4 [_Reflection]
Vector 5 [_SpecColor]
Float 6 [_Shininess]
Float 7 [_Gloss]
Float 8 [_FrezPow]
Float 9 [_FrezFalloff]
Vector 10 [_LightColor0]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_Cube] CUBE
"ps_2_0
; 59 ALU, 2 TEX
dcl_2d s0
dcl_cube s1
def c11, 2.00000000, 1.00000000, 0.00000000, 0
dcl t0.xyz
dcl t1.xyz
dcl t2.xyz
dcl t3.xy
dcl t4.xyz
texld r5, t3, s0
dp3_pp r0.x, t1, t1
rsq_pp r0.x, r0.x
mul_pp r6.xyz, r0.x, t1
dp3_pp r0.x, r6, t4
mul_pp r0.xyz, r6, r0.x
mad_pp r7.xyz, -r0, c11.x, t4
add r2.xyz, -t0, c2
dp3_pp r0.x, r2, r2
rsq_pp r1.x, r0.x
mul_pp r3.xyz, r1.x, r2
dp3_pp r2.x, c2, c2
rsq_pp r2.x, r2.x
abs_pp r0.x, -c2.w
add r8.xyz, -t0, c1
cmp_pp r0.x, -r0, c11.y, c11.z
mul_pp r9.xyz, r2.x, c2
abs_pp r2.x, r0
cmp_pp r9.xyz, -r2.x, r3, r9
dp3_pp r0.x, r6, r9
mul_pp r6.xyz, r6, -r0.x
dp3 r3.x, r8, r8
rsq r3.x, r3.x
mul r3.xyz, r3.x, r8
mad_pp r6.xyz, -r6, c11.x, -r9
dp3_pp r3.x, r6, r3
max_pp r3.x, r3, c11.z
pow_pp r6.w, r3.x, c6.x
cmp_pp r1.x, -r2, r1, c11.y
mul_pp r3.xyz, r1.x, c10
mul_pp r2.xyz, r3, c5
mov_pp r1.x, r6.w
mul_pp r8.xyz, r2, r1.x
cmp_pp r1.x, r0, c11.z, c11.y
dp3_pp r2.x, r7, t1
abs_pp r6.x, r1
abs_pp_sat r1.x, r2
cmp_pp r2.xyz, -r6.x, r8, c11.z
add_pp r1.x, -r1, c11.y
mul_pp r6.xyz, r2, c7.x
pow_pp r2.x, r1.x, c9.x
max_pp r1.x, r0, c11.z
mov_pp r0.x, r2.x
mul_pp r0.x, r0, c8
mul_pp r3.xyz, r3, c3
mov_pp r2.w, c11.y
texld r4, r7, s1
mov_pp r7.xyz, c0
mad_pp r2.xyz, c3, r7, t2
mad_pp_sat r1.xyz, r3, r1.x, r2
mad_pp r2.xyz, r5, r1, r6
add_pp_sat r1.x, r0, c4
mul_pp r1.xyz, r4, r1.x
mov_pp r1.w, r4
add_pp r2, r1, r2
mad_pp r0, r0.x, r1, r2
mov_pp oC0, r0
"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
"!!GLES"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
"!!GLES"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_OFF" }
Vector 1 [_WorldSpaceCameraPos]
Vector 2 [_WorldSpaceLightPos0]
Vector 3 [_Color]
Float 4 [_Reflection]
Vector 5 [_SpecColor]
Float 6 [_Shininess]
Float 7 [_Gloss]
Float 8 [_FrezPow]
Float 9 [_FrezFalloff]
Vector 10 [_LightColor0]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_Cube] CUBE
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 55 ALU, 2 TEX
PARAM c[12] = { state.lightmodel.ambient,
		program.local[1..10],
		{ 2, 1, 0 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
TEMP R6;
TEX R1.xyz, fragment.texcoord[3], texture[0], 2D;
ADD R4.xyz, -fragment.texcoord[0], c[2];
DP3 R1.w, R4, R4;
RSQ R2.w, R1.w;
ADD R6.xyz, -fragment.texcoord[0], c[1];
DP3 R0.x, fragment.texcoord[1], fragment.texcoord[1];
RSQ R0.x, R0.x;
MUL R2.xyz, R0.x, fragment.texcoord[1];
DP3 R0.x, R2, fragment.texcoord[4];
MUL R0.xyz, R2, R0.x;
MAD R3.xyz, -R0, c[11].x, fragment.texcoord[4];
ABS R1.w, -c[2];
DP3 R3.w, c[2], c[2];
RSQ R3.w, R3.w;
CMP R1.w, -R1, c[11].z, c[11].y;
DP3 R4.w, R6, R6;
MUL R5.xyz, R3.w, c[2];
ABS R1.w, R1;
CMP R3.w, -R1, c[11].z, c[11].y;
MUL R4.xyz, R2.w, R4;
CMP R4.xyz, -R3.w, R4, R5;
DP3 R1.w, R2, R4;
MUL R2.xyz, R2, -R1.w;
RSQ R4.w, R4.w;
MAD R2.xyz, -R2, c[11].x, -R4;
MUL R5.xyz, R4.w, R6;
DP3 R2.x, R2, R5;
MAX R2.x, R2, c[11].z;
POW R4.w, R2.x, c[6].x;
CMP R2.x, -R3.w, R2.w, c[11].y;
SLT R2.w, R1, c[11].z;
MUL R2.xyz, R2.x, c[10];
MUL R4.xyz, R2, c[5];
ABS R2.w, R2;
CMP R3.w, -R2, c[11].z, c[11].y;
DP3 R2.w, R3, fragment.texcoord[1];
MUL R4.xyz, R4, R4.w;
ABS_SAT R2.w, R2;
MUL R2.xyz, R2, c[3];
TEX R0, R3, texture[1], CUBE;
CMP R3.xyz, -R3.w, R4, c[11].z;
ADD R3.w, -R2, c[11].y;
MAX R2.w, R1, c[11].z;
POW R1.w, R3.w, c[9].x;
MOV R4.xyz, c[3];
MAD R4.xyz, R4, c[0], fragment.texcoord[2];
MAD_SAT R2.xyz, R2, R2.w, R4;
MUL R1.w, R1, c[8].x;
ADD_SAT R2.w, R1, c[4].x;
MUL R0.xyz, R0, R2.w;
MUL R3.xyz, R3, c[7].x;
MAD R2.xyz, R1, R2, R3;
MOV R2.w, c[11].y;
ADD R2, R0, R2;
MAD result.color, R1.w, R0, R2;
END
# 55 instructions, 7 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_OFF" }
Vector 0 [glstate_lightmodel_ambient]
Vector 1 [_WorldSpaceCameraPos]
Vector 2 [_WorldSpaceLightPos0]
Vector 3 [_Color]
Float 4 [_Reflection]
Vector 5 [_SpecColor]
Float 6 [_Shininess]
Float 7 [_Gloss]
Float 8 [_FrezPow]
Float 9 [_FrezFalloff]
Vector 10 [_LightColor0]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_Cube] CUBE
"ps_2_0
; 59 ALU, 2 TEX
dcl_2d s0
dcl_cube s1
def c11, 2.00000000, 1.00000000, 0.00000000, 0
dcl t0.xyz
dcl t1.xyz
dcl t2.xyz
dcl t3.xy
dcl t4.xyz
texld r5, t3, s0
dp3_pp r0.x, t1, t1
rsq_pp r0.x, r0.x
mul_pp r6.xyz, r0.x, t1
dp3_pp r0.x, r6, t4
mul_pp r0.xyz, r6, r0.x
mad_pp r7.xyz, -r0, c11.x, t4
add r2.xyz, -t0, c2
dp3_pp r0.x, r2, r2
rsq_pp r1.x, r0.x
mul_pp r3.xyz, r1.x, r2
dp3_pp r2.x, c2, c2
rsq_pp r2.x, r2.x
abs_pp r0.x, -c2.w
add r8.xyz, -t0, c1
cmp_pp r0.x, -r0, c11.y, c11.z
mul_pp r9.xyz, r2.x, c2
abs_pp r2.x, r0
cmp_pp r9.xyz, -r2.x, r3, r9
dp3_pp r0.x, r6, r9
mul_pp r6.xyz, r6, -r0.x
dp3 r3.x, r8, r8
rsq r3.x, r3.x
mul r3.xyz, r3.x, r8
mad_pp r6.xyz, -r6, c11.x, -r9
dp3_pp r3.x, r6, r3
max_pp r3.x, r3, c11.z
pow_pp r6.w, r3.x, c6.x
cmp_pp r1.x, -r2, r1, c11.y
mul_pp r3.xyz, r1.x, c10
mul_pp r2.xyz, r3, c5
mov_pp r1.x, r6.w
mul_pp r8.xyz, r2, r1.x
cmp_pp r1.x, r0, c11.z, c11.y
dp3_pp r2.x, r7, t1
abs_pp r6.x, r1
abs_pp_sat r1.x, r2
cmp_pp r2.xyz, -r6.x, r8, c11.z
add_pp r1.x, -r1, c11.y
mul_pp r6.xyz, r2, c7.x
pow_pp r2.x, r1.x, c9.x
max_pp r1.x, r0, c11.z
mov_pp r0.x, r2.x
mul_pp r0.x, r0, c8
mul_pp r3.xyz, r3, c3
mov_pp r2.w, c11.y
texld r4, r7, s1
mov_pp r7.xyz, c0
mad_pp r2.xyz, c3, r7, t2
mad_pp_sat r1.xyz, r3, r1.x, r2
mad_pp r2.xyz, r5, r1, r6
add_pp_sat r1.x, r0, c4
mul_pp r1.xyz, r4, r1.x
mov_pp r1.w, r4
add_pp r2, r1, r2
mad_pp r0, r0.x, r1, r2
mov_pp oC0, r0
"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_OFF" }
"!!GLES"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_OFF" }
"!!GLES"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
Vector 1 [_WorldSpaceCameraPos]
Vector 2 [_WorldSpaceLightPos0]
Vector 3 [_Color]
Float 4 [_Reflection]
Vector 5 [_SpecColor]
Float 6 [_Shininess]
Float 7 [_Gloss]
Float 8 [_FrezPow]
Float 9 [_FrezFalloff]
Vector 10 [_LightColor0]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_Cube] CUBE
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 55 ALU, 2 TEX
PARAM c[12] = { state.lightmodel.ambient,
		program.local[1..10],
		{ 2, 1, 0 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
TEMP R6;
TEX R1.xyz, fragment.texcoord[3], texture[0], 2D;
ADD R4.xyz, -fragment.texcoord[0], c[2];
DP3 R1.w, R4, R4;
RSQ R2.w, R1.w;
ADD R6.xyz, -fragment.texcoord[0], c[1];
DP3 R0.x, fragment.texcoord[1], fragment.texcoord[1];
RSQ R0.x, R0.x;
MUL R2.xyz, R0.x, fragment.texcoord[1];
DP3 R0.x, R2, fragment.texcoord[4];
MUL R0.xyz, R2, R0.x;
MAD R3.xyz, -R0, c[11].x, fragment.texcoord[4];
ABS R1.w, -c[2];
DP3 R3.w, c[2], c[2];
RSQ R3.w, R3.w;
CMP R1.w, -R1, c[11].z, c[11].y;
DP3 R4.w, R6, R6;
MUL R5.xyz, R3.w, c[2];
ABS R1.w, R1;
CMP R3.w, -R1, c[11].z, c[11].y;
MUL R4.xyz, R2.w, R4;
CMP R4.xyz, -R3.w, R4, R5;
DP3 R1.w, R2, R4;
MUL R2.xyz, R2, -R1.w;
RSQ R4.w, R4.w;
MAD R2.xyz, -R2, c[11].x, -R4;
MUL R5.xyz, R4.w, R6;
DP3 R2.x, R2, R5;
MAX R2.x, R2, c[11].z;
POW R4.w, R2.x, c[6].x;
CMP R2.x, -R3.w, R2.w, c[11].y;
SLT R2.w, R1, c[11].z;
MUL R2.xyz, R2.x, c[10];
MUL R4.xyz, R2, c[5];
ABS R2.w, R2;
CMP R3.w, -R2, c[11].z, c[11].y;
DP3 R2.w, R3, fragment.texcoord[1];
MUL R4.xyz, R4, R4.w;
ABS_SAT R2.w, R2;
MUL R2.xyz, R2, c[3];
TEX R0, R3, texture[1], CUBE;
CMP R3.xyz, -R3.w, R4, c[11].z;
ADD R3.w, -R2, c[11].y;
MAX R2.w, R1, c[11].z;
POW R1.w, R3.w, c[9].x;
MOV R4.xyz, c[3];
MAD R4.xyz, R4, c[0], fragment.texcoord[2];
MAD_SAT R2.xyz, R2, R2.w, R4;
MUL R1.w, R1, c[8].x;
ADD_SAT R2.w, R1, c[4].x;
MUL R0.xyz, R0, R2.w;
MUL R3.xyz, R3, c[7].x;
MAD R2.xyz, R1, R2, R3;
MOV R2.w, c[11].y;
ADD R2, R0, R2;
MAD result.color, R1.w, R0, R2;
END
# 55 instructions, 7 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
Vector 0 [glstate_lightmodel_ambient]
Vector 1 [_WorldSpaceCameraPos]
Vector 2 [_WorldSpaceLightPos0]
Vector 3 [_Color]
Float 4 [_Reflection]
Vector 5 [_SpecColor]
Float 6 [_Shininess]
Float 7 [_Gloss]
Float 8 [_FrezPow]
Float 9 [_FrezFalloff]
Vector 10 [_LightColor0]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_Cube] CUBE
"ps_2_0
; 59 ALU, 2 TEX
dcl_2d s0
dcl_cube s1
def c11, 2.00000000, 1.00000000, 0.00000000, 0
dcl t0.xyz
dcl t1.xyz
dcl t2.xyz
dcl t3.xy
dcl t4.xyz
texld r5, t3, s0
dp3_pp r0.x, t1, t1
rsq_pp r0.x, r0.x
mul_pp r6.xyz, r0.x, t1
dp3_pp r0.x, r6, t4
mul_pp r0.xyz, r6, r0.x
mad_pp r7.xyz, -r0, c11.x, t4
add r2.xyz, -t0, c2
dp3_pp r0.x, r2, r2
rsq_pp r1.x, r0.x
mul_pp r3.xyz, r1.x, r2
dp3_pp r2.x, c2, c2
rsq_pp r2.x, r2.x
abs_pp r0.x, -c2.w
add r8.xyz, -t0, c1
cmp_pp r0.x, -r0, c11.y, c11.z
mul_pp r9.xyz, r2.x, c2
abs_pp r2.x, r0
cmp_pp r9.xyz, -r2.x, r3, r9
dp3_pp r0.x, r6, r9
mul_pp r6.xyz, r6, -r0.x
dp3 r3.x, r8, r8
rsq r3.x, r3.x
mul r3.xyz, r3.x, r8
mad_pp r6.xyz, -r6, c11.x, -r9
dp3_pp r3.x, r6, r3
max_pp r3.x, r3, c11.z
pow_pp r6.w, r3.x, c6.x
cmp_pp r1.x, -r2, r1, c11.y
mul_pp r3.xyz, r1.x, c10
mul_pp r2.xyz, r3, c5
mov_pp r1.x, r6.w
mul_pp r8.xyz, r2, r1.x
cmp_pp r1.x, r0, c11.z, c11.y
dp3_pp r2.x, r7, t1
abs_pp r6.x, r1
abs_pp_sat r1.x, r2
cmp_pp r2.xyz, -r6.x, r8, c11.z
add_pp r1.x, -r1, c11.y
mul_pp r6.xyz, r2, c7.x
pow_pp r2.x, r1.x, c9.x
max_pp r1.x, r0, c11.z
mov_pp r0.x, r2.x
mul_pp r0.x, r0, c8
mul_pp r3.xyz, r3, c3
mov_pp r2.w, c11.y
texld r4, r7, s1
mov_pp r7.xyz, c0
mad_pp r2.xyz, c3, r7, t2
mad_pp_sat r1.xyz, r3, r1.x, r2
mad_pp r2.xyz, r5, r1, r6
add_pp_sat r1.x, r0, c4
mul_pp r1.xyz, r4, r1.x
mov_pp r1.w, r4
add_pp r2, r1, r2
mad_pp r0, r0.x, r1, r2
mov_pp oC0, r0
"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
"!!GLES"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
"!!GLES"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
Vector 1 [_WorldSpaceCameraPos]
Vector 2 [_WorldSpaceLightPos0]
Vector 3 [_Color]
Float 4 [_Reflection]
Vector 5 [_SpecColor]
Float 6 [_Shininess]
Float 7 [_Gloss]
Float 8 [_FrezPow]
Float 9 [_FrezFalloff]
Vector 10 [_LightColor0]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_Cube] CUBE
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 55 ALU, 2 TEX
PARAM c[12] = { state.lightmodel.ambient,
		program.local[1..10],
		{ 2, 1, 0 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
TEMP R6;
TEX R1.xyz, fragment.texcoord[3], texture[0], 2D;
ADD R4.xyz, -fragment.texcoord[0], c[2];
DP3 R1.w, R4, R4;
RSQ R2.w, R1.w;
ADD R6.xyz, -fragment.texcoord[0], c[1];
DP3 R0.x, fragment.texcoord[1], fragment.texcoord[1];
RSQ R0.x, R0.x;
MUL R2.xyz, R0.x, fragment.texcoord[1];
DP3 R0.x, R2, fragment.texcoord[4];
MUL R0.xyz, R2, R0.x;
MAD R3.xyz, -R0, c[11].x, fragment.texcoord[4];
ABS R1.w, -c[2];
DP3 R3.w, c[2], c[2];
RSQ R3.w, R3.w;
CMP R1.w, -R1, c[11].z, c[11].y;
DP3 R4.w, R6, R6;
MUL R5.xyz, R3.w, c[2];
ABS R1.w, R1;
CMP R3.w, -R1, c[11].z, c[11].y;
MUL R4.xyz, R2.w, R4;
CMP R4.xyz, -R3.w, R4, R5;
DP3 R1.w, R2, R4;
MUL R2.xyz, R2, -R1.w;
RSQ R4.w, R4.w;
MAD R2.xyz, -R2, c[11].x, -R4;
MUL R5.xyz, R4.w, R6;
DP3 R2.x, R2, R5;
MAX R2.x, R2, c[11].z;
POW R4.w, R2.x, c[6].x;
CMP R2.x, -R3.w, R2.w, c[11].y;
SLT R2.w, R1, c[11].z;
MUL R2.xyz, R2.x, c[10];
MUL R4.xyz, R2, c[5];
ABS R2.w, R2;
CMP R3.w, -R2, c[11].z, c[11].y;
DP3 R2.w, R3, fragment.texcoord[1];
MUL R4.xyz, R4, R4.w;
ABS_SAT R2.w, R2;
MUL R2.xyz, R2, c[3];
TEX R0, R3, texture[1], CUBE;
CMP R3.xyz, -R3.w, R4, c[11].z;
ADD R3.w, -R2, c[11].y;
MAX R2.w, R1, c[11].z;
POW R1.w, R3.w, c[9].x;
MOV R4.xyz, c[3];
MAD R4.xyz, R4, c[0], fragment.texcoord[2];
MAD_SAT R2.xyz, R2, R2.w, R4;
MUL R1.w, R1, c[8].x;
ADD_SAT R2.w, R1, c[4].x;
MUL R0.xyz, R0, R2.w;
MUL R3.xyz, R3, c[7].x;
MAD R2.xyz, R1, R2, R3;
MOV R2.w, c[11].y;
ADD R2, R0, R2;
MAD result.color, R1.w, R0, R2;
END
# 55 instructions, 7 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
Vector 0 [glstate_lightmodel_ambient]
Vector 1 [_WorldSpaceCameraPos]
Vector 2 [_WorldSpaceLightPos0]
Vector 3 [_Color]
Float 4 [_Reflection]
Vector 5 [_SpecColor]
Float 6 [_Shininess]
Float 7 [_Gloss]
Float 8 [_FrezPow]
Float 9 [_FrezFalloff]
Vector 10 [_LightColor0]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_Cube] CUBE
"ps_2_0
; 59 ALU, 2 TEX
dcl_2d s0
dcl_cube s1
def c11, 2.00000000, 1.00000000, 0.00000000, 0
dcl t0.xyz
dcl t1.xyz
dcl t2.xyz
dcl t3.xy
dcl t4.xyz
texld r5, t3, s0
dp3_pp r0.x, t1, t1
rsq_pp r0.x, r0.x
mul_pp r6.xyz, r0.x, t1
dp3_pp r0.x, r6, t4
mul_pp r0.xyz, r6, r0.x
mad_pp r7.xyz, -r0, c11.x, t4
add r2.xyz, -t0, c2
dp3_pp r0.x, r2, r2
rsq_pp r1.x, r0.x
mul_pp r3.xyz, r1.x, r2
dp3_pp r2.x, c2, c2
rsq_pp r2.x, r2.x
abs_pp r0.x, -c2.w
add r8.xyz, -t0, c1
cmp_pp r0.x, -r0, c11.y, c11.z
mul_pp r9.xyz, r2.x, c2
abs_pp r2.x, r0
cmp_pp r9.xyz, -r2.x, r3, r9
dp3_pp r0.x, r6, r9
mul_pp r6.xyz, r6, -r0.x
dp3 r3.x, r8, r8
rsq r3.x, r3.x
mul r3.xyz, r3.x, r8
mad_pp r6.xyz, -r6, c11.x, -r9
dp3_pp r3.x, r6, r3
max_pp r3.x, r3, c11.z
pow_pp r6.w, r3.x, c6.x
cmp_pp r1.x, -r2, r1, c11.y
mul_pp r3.xyz, r1.x, c10
mul_pp r2.xyz, r3, c5
mov_pp r1.x, r6.w
mul_pp r8.xyz, r2, r1.x
cmp_pp r1.x, r0, c11.z, c11.y
dp3_pp r2.x, r7, t1
abs_pp r6.x, r1
abs_pp_sat r1.x, r2
cmp_pp r2.xyz, -r6.x, r8, c11.z
add_pp r1.x, -r1, c11.y
mul_pp r6.xyz, r2, c7.x
pow_pp r2.x, r1.x, c9.x
max_pp r1.x, r0, c11.z
mov_pp r0.x, r2.x
mul_pp r0.x, r0, c8
mul_pp r3.xyz, r3, c3
mov_pp r2.w, c11.y
texld r4, r7, s1
mov_pp r7.xyz, c0
mad_pp r2.xyz, c3, r7, t2
mad_pp_sat r1.xyz, r3, r1.x, r2
mad_pp r2.xyz, r5, r1, r6
add_pp_sat r1.x, r0, c4
mul_pp r1.xyz, r4, r1.x
mov_pp r1.w, r4
add_pp r2, r1, r2
mad_pp r0, r0.x, r1, r2
mov_pp oC0, r0
"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
"!!GLES"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
"!!GLES"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_SCREEN" }
Vector 1 [_WorldSpaceCameraPos]
Vector 2 [_WorldSpaceLightPos0]
Vector 3 [_Color]
Float 4 [_Reflection]
Vector 5 [_SpecColor]
Float 6 [_Shininess]
Float 7 [_Gloss]
Float 8 [_FrezPow]
Float 9 [_FrezFalloff]
Vector 10 [_LightColor0]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_Cube] CUBE
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 55 ALU, 2 TEX
PARAM c[12] = { state.lightmodel.ambient,
		program.local[1..10],
		{ 2, 1, 0 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
TEMP R6;
TEX R1.xyz, fragment.texcoord[3], texture[0], 2D;
ADD R4.xyz, -fragment.texcoord[0], c[2];
DP3 R1.w, R4, R4;
RSQ R2.w, R1.w;
ADD R6.xyz, -fragment.texcoord[0], c[1];
DP3 R0.x, fragment.texcoord[1], fragment.texcoord[1];
RSQ R0.x, R0.x;
MUL R2.xyz, R0.x, fragment.texcoord[1];
DP3 R0.x, R2, fragment.texcoord[4];
MUL R0.xyz, R2, R0.x;
MAD R3.xyz, -R0, c[11].x, fragment.texcoord[4];
ABS R1.w, -c[2];
DP3 R3.w, c[2], c[2];
RSQ R3.w, R3.w;
CMP R1.w, -R1, c[11].z, c[11].y;
DP3 R4.w, R6, R6;
MUL R5.xyz, R3.w, c[2];
ABS R1.w, R1;
CMP R3.w, -R1, c[11].z, c[11].y;
MUL R4.xyz, R2.w, R4;
CMP R4.xyz, -R3.w, R4, R5;
DP3 R1.w, R2, R4;
MUL R2.xyz, R2, -R1.w;
RSQ R4.w, R4.w;
MAD R2.xyz, -R2, c[11].x, -R4;
MUL R5.xyz, R4.w, R6;
DP3 R2.x, R2, R5;
MAX R2.x, R2, c[11].z;
POW R4.w, R2.x, c[6].x;
CMP R2.x, -R3.w, R2.w, c[11].y;
SLT R2.w, R1, c[11].z;
MUL R2.xyz, R2.x, c[10];
MUL R4.xyz, R2, c[5];
ABS R2.w, R2;
CMP R3.w, -R2, c[11].z, c[11].y;
DP3 R2.w, R3, fragment.texcoord[1];
MUL R4.xyz, R4, R4.w;
ABS_SAT R2.w, R2;
MUL R2.xyz, R2, c[3];
TEX R0, R3, texture[1], CUBE;
CMP R3.xyz, -R3.w, R4, c[11].z;
ADD R3.w, -R2, c[11].y;
MAX R2.w, R1, c[11].z;
POW R1.w, R3.w, c[9].x;
MOV R4.xyz, c[3];
MAD R4.xyz, R4, c[0], fragment.texcoord[2];
MAD_SAT R2.xyz, R2, R2.w, R4;
MUL R1.w, R1, c[8].x;
ADD_SAT R2.w, R1, c[4].x;
MUL R0.xyz, R0, R2.w;
MUL R3.xyz, R3, c[7].x;
MAD R2.xyz, R1, R2, R3;
MOV R2.w, c[11].y;
ADD R2, R0, R2;
MAD result.color, R1.w, R0, R2;
END
# 55 instructions, 7 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_SCREEN" }
Vector 0 [glstate_lightmodel_ambient]
Vector 1 [_WorldSpaceCameraPos]
Vector 2 [_WorldSpaceLightPos0]
Vector 3 [_Color]
Float 4 [_Reflection]
Vector 5 [_SpecColor]
Float 6 [_Shininess]
Float 7 [_Gloss]
Float 8 [_FrezPow]
Float 9 [_FrezFalloff]
Vector 10 [_LightColor0]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_Cube] CUBE
"ps_2_0
; 59 ALU, 2 TEX
dcl_2d s0
dcl_cube s1
def c11, 2.00000000, 1.00000000, 0.00000000, 0
dcl t0.xyz
dcl t1.xyz
dcl t2.xyz
dcl t3.xy
dcl t4.xyz
texld r5, t3, s0
dp3_pp r0.x, t1, t1
rsq_pp r0.x, r0.x
mul_pp r6.xyz, r0.x, t1
dp3_pp r0.x, r6, t4
mul_pp r0.xyz, r6, r0.x
mad_pp r7.xyz, -r0, c11.x, t4
add r2.xyz, -t0, c2
dp3_pp r0.x, r2, r2
rsq_pp r1.x, r0.x
mul_pp r3.xyz, r1.x, r2
dp3_pp r2.x, c2, c2
rsq_pp r2.x, r2.x
abs_pp r0.x, -c2.w
add r8.xyz, -t0, c1
cmp_pp r0.x, -r0, c11.y, c11.z
mul_pp r9.xyz, r2.x, c2
abs_pp r2.x, r0
cmp_pp r9.xyz, -r2.x, r3, r9
dp3_pp r0.x, r6, r9
mul_pp r6.xyz, r6, -r0.x
dp3 r3.x, r8, r8
rsq r3.x, r3.x
mul r3.xyz, r3.x, r8
mad_pp r6.xyz, -r6, c11.x, -r9
dp3_pp r3.x, r6, r3
max_pp r3.x, r3, c11.z
pow_pp r6.w, r3.x, c6.x
cmp_pp r1.x, -r2, r1, c11.y
mul_pp r3.xyz, r1.x, c10
mul_pp r2.xyz, r3, c5
mov_pp r1.x, r6.w
mul_pp r8.xyz, r2, r1.x
cmp_pp r1.x, r0, c11.z, c11.y
dp3_pp r2.x, r7, t1
abs_pp r6.x, r1
abs_pp_sat r1.x, r2
cmp_pp r2.xyz, -r6.x, r8, c11.z
add_pp r1.x, -r1, c11.y
mul_pp r6.xyz, r2, c7.x
pow_pp r2.x, r1.x, c9.x
max_pp r1.x, r0, c11.z
mov_pp r0.x, r2.x
mul_pp r0.x, r0, c8
mul_pp r3.xyz, r3, c3
mov_pp r2.w, c11.y
texld r4, r7, s1
mov_pp r7.xyz, c0
mad_pp r2.xyz, c3, r7, t2
mad_pp_sat r1.xyz, r3, r1.x, r2
mad_pp r2.xyz, r5, r1, r6
add_pp_sat r1.x, r0, c4
mul_pp r1.xyz, r4, r1.x
mov_pp r1.w, r4
add_pp r2, r1, r2
mad_pp r0, r0.x, r1, r2
mov_pp oC0, r0
"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_SCREEN" }
"!!GLES"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_SCREEN" }
"!!GLES"
}

}

#LINE 234

      }
 }
   // The definition of a fallback shader should be commented out 
   // during development:
   Fallback "Mobile/Diffuse"
}