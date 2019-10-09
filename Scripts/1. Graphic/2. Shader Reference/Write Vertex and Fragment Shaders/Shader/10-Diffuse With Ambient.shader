Shader "Custom/ShaderReference/10-Diffuse With Ambient"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
	}

		SubShader
	{
		Pass
		{
			Tags{"LightMode" = "ForwardBase"}

			CGPROGRAM
#pragma vertex vert
#pragma fragment frag
#include "UnityCG.cginc"
#include "Lighting.cginc"

			sampler2D _MainTex;

			struct v2f
			{
				float4 vertex : SV_POSITION;
				float2 uv : TEXCOORD0;
				float4 diff : COLOR0;
			};

			v2f vert(float4 vertex : POSITION, float3 normal : NORMAL, float2 uv : TEXCOORD0)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(vertex);
				float3 worldNormal = UnityObjectToWorldNormal(normal);
				float nh = max(0, dot(worldNormal, _WorldSpaceLightPos0));
				o.diff = nh * _LightColor0;
				o.diff.rgb += ShadeSH9(float4(worldNormal, 1.0));
				o.uv = uv;
				return o;
			}

			float4 frag(v2f i) : SV_Target
			{
				float4 c = tex2D(_MainTex, i.uv);
				c *= i.diff;
				return c;
			}
			
			ENDCG
		}
	}
}
