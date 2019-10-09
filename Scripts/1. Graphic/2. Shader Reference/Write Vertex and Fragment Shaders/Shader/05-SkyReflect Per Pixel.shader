Shader "Custom/ShaderReference/05-SkyReflect Per Pixel"
{
	Properties
	{
		[NoScaleOffset]_BumpTex("Bump Tex(RGB)", 2D) = "white" {}
	}

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

			sampler2D _BumpTex;
			float4 _BumpTex_ST;

			struct VertexInput
			{
				float4 vertex : POSITION;
				float4 tangent : TANGENT;
				float3 normal : NORMAL;
				float2 texcoord : TEXCOORD0;
			};

			struct v2f
			{
				float4 vertex : SV_POSITION;
				float2 uv : TEXCOORD0;
				float3 tangentSpace0 : TEXCOORD1;
				float3 tangentSpace1 : TEXCOORD2;
				float3 tangentSpace2 : TEXCOORD3;
				float3 worldPos : TEXCOORD4;
			};

			v2f vert(VertexInput v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = TRANSFORM_TEX(v.texcoord, _BumpTex);

				o.worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;
				half3 worldNormal = UnityObjectToWorldNormal(v.normal);
				half3 worldTangent = UnityObjectToWorldDir(v.tangent);
				half w = v.tangent.w * unity_WorldTransformParams.w;
				half3 worldBiNormal = cross(worldNormal, worldTangent) * w;
				o.tangentSpace0 = half3(worldTangent.x, worldBiNormal.x, worldNormal.x);
				o.tangentSpace1 = half3(worldTangent.y, worldBiNormal.y, worldNormal.y);
				o.tangentSpace2 = half3(worldTangent.z, worldBiNormal.z, worldNormal.z);
				return o;
			}

			float4 frag(v2f i) : SV_Target
			{
				half3 tNormal = UnpackNormal(tex2D(_BumpTex, i.uv));
				half3 worldNormal;
				worldNormal.x = dot(i.tangentSpace0, tNormal);
				worldNormal.y = dot(i.tangentSpace1, tNormal);
				worldNormal.z = dot(i.tangentSpace2, tNormal);

				half3 worldViewDir = normalize(UnityWorldSpaceViewDir(i.worldPos));
				half3 worldRefl = reflect(-worldViewDir, tNormal);
				half4 skyData = UNITY_SAMPLE_TEXCUBE(unity_SpecCube0, worldRefl);
				half3 skyColor = DecodeHDR(skyData, unity_SpecCube0_HDR);
				fixed4 c = 0;
				c.rgb = skyColor;
				//c.rgb = worldNormal;
				return c;
			}
			ENDCG
		}
	}
}
