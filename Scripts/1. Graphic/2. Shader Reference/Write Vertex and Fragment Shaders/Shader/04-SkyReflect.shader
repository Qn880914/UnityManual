Shader "Custom/ShaderReference/04-SkyReflect"
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
				float4 vertex : SV_POSITION;
				float3 worldReflect : TEXCOORD0;
			};

			v2f vert(VertexInput v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				float3 worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;
				float3 worldViewDir = normalize(worldPos - _WorldSpaceCameraPos.xyz);
				float3 worldNormal = UnityObjectToWorldNormal(v.normal);
				o.worldReflect = reflect(worldViewDir, worldNormal);
				return o;
			}

			float4 frag(v2f i) : SV_Target
			{
				float4 c = 1;
				half4 skyData = UNITY_SAMPLE_TEXCUBE(unity_SpecCube0, i.worldReflect);
				float3 skyColor = DecodeHDR(skyData, unity_SpecCube0_HDR);
				c.rgb = skyColor;
				return c;
			}
			ENDCG
		}
	}
}
