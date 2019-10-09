Shader "Custom/ShaderReference/SimplestUnlitShader"
{
	Properties
	{
		[NoScaleOffset] _MainTex("Main Tex(RGB)", 2D) = "white" {}
	}

		SubShader
	{
		LOD 100

		Tags {"RenderType" = "Opaque"}

		Pass
		{
			Tags{"LightMode" = "ForwardBase"}

			CGPROGRAM
#pragma vertex vert
#pragma fragment frag
#include "UnityCG.cginc"

			float4 _MainTex_ST;
			sampler2D _MainTex;
			
			struct VertexInput
			{
				float4 vertex : POSITION;
				float2 texcoord : TEXCOORD0;
			};

			struct v2f
			{
				float4 vertex : SV_POSITION;
				float2 uv : TEXCOORD0;
			};

			v2f vert(VertexInput v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = TRANSFORM_TEX(v.texcoord, _MainTex);
				return o;
			}

			float4 frag(v2f i) : COLOR
			{
				float4 c = tex2D(_MainTex, i.uv);
				return c;
			}
			ENDCG
		}
	}
}
