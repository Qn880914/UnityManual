Shader "Custom/ShaderLab_Lighting"
{
	Properties
	{
		_Color("Main Color", Color) = (1,1,1,1)
		_MainTex("Base (RGB)", 2D) = "white" {}
		_LightMap("Lightmap (RGB)", 2D) = "black" {}
	}

	SubShader
	{
		LOD 200
		Tags{"RenderType" = "Opaque"}

		// ---- forward rendering base pass: 
		Pass
		{
			Name "FORWARD"
			Tags{"LightMode" = "ForwardBase"}

			CGPROGRAM
#pragma vertex vert
#pragma fragment frag
#pragma multi_compile_instancing
#pragma multi_compile_fog
#pragma multi_compile_fwdbase nodynlightmap
#include "HLSLSupport.cginc"
#define UNITY_INSTANCED_LOD_FADE
#define UNITY_INSTANCED_SH
#define UNITY_INSTANCED_LIGHTMAPSTS
#include "UnityShaderVariables.cginc"
#include "UnityShaderUtilities.cginc"

			struct appdata
			{
				float4 position : POSITION;
				float3 normal : NORMAL;
			};

			struct v2f
			{
				float4 position : SV_POSITION;
			};

			v2f vert(appdata i)
			{
				v2f o;
				o.position = UnityObjectToClipPos(i.position);
				return o;
			}

			float4 frag(v2f i) : COLOR
			{
				return float4(1,0,0,1);
			}
			ENDCG
		}

		// ---- Vertex rendering pass:
		Pass
		{
			Tags{"LightMode" = "Vertex"}

			CGPROGRAM
#pragma target 3.0
#pragma vertex vert
#pragma fragment frag

			struct v2f
			{
				float4 position : SV_POSITION;
			};

			v2f vert(float4 position : POSITION)
			{
				v2f o;
				o.position = UnityObjectToClipPos(position);
				return o;
			}

			half4 frag(v2f i) : COLOR
			{
				//return unity_LightColor;
				return half4(1, 0, 0, 1);
			}
			ENDCG
		}
	}
}
