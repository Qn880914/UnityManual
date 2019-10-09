Shader "Custom/ShaderReference/WorldSpaceNormal"
{
	SubShader
	{
		LOD 100

		Tags{"RenderType" = "Opaque"}

		Pass
		{
			Tags{"LightMode" = "ForwardBase"}

			CGPROGRAM
#pragma vertex vert
#pragma fragment frag
#include "UnityCG.cginc"

			struct VertexInput
			{
				float4 vertex : POSITION;
				float3 normal : NORMAL;
			};

			struct v2f
			{
				float4 vertex : POSITION;
				float3 normal : TEXCOORD0;
			};

			v2f vert(VertexInput v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.normal = UnityObjectToWorldNormal(v.normal);
				return o;
			}

			float4 frag(v2f i) : COLOR
			{
				float4 c = 1;
				c.rgb = i.normal * 0.5 + 0.5;
				return c;
			}
			ENDCG
		}
	}
}
