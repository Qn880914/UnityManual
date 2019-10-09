Shader "Custom/ShaderReference/11-Shadow Casting"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
	}
		SubShader
	{
		Tags { "RenderType" = "Opaque" }
		LOD 100

		Pass
		{
			Tags {"LightMode" = "ForwardBase"}
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#include "UnityCG.cginc"
			#include "Lighting.cginc"

			sampler2D _MainTex;
			struct v2f
			{
				fixed4 diff : COLOR0;
				float4 vertex : SV_POSITION;
				float2 uv : TEXCOORD0;
			};
			v2f vert(appdata_base v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				float3 worldNormal = UnityObjectToWorldNormal(v.normal);
				// only evaluate ambient
				float nh = max(0, dot(worldNormal, _WorldSpaceLightPos0));
				o.diff = nh * _LightColor0;
				o.diff.rgb += ShadeSH9(half4(worldNormal,1));
				o.diff.a = 1;
				o.uv = v.texcoord;
				return o;
			}
			fixed4 frag(v2f i) : SV_Target
			{
				float4 c = tex2D(_MainTex, i.uv);
				c *= i.diff;
				return c;
			}
			ENDCG
		}

		// shadow caster rendering pass, implemented manually
		// using macros from UnityCG.cginc
		Pass
		{
			Tags {"LightMode" = "ShadowCaster"}

			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma multi_compile_shadowcaster
			#include "UnityCG.cginc"

			struct v2f {
				//V2F_SHADOW_CASTER;
				float3 vec : TEXCOORD0;
				float4 pos : SV_POSITION;
			};

			v2f vert(appdata_base v)
			{
				v2f o;
				//TRANSFER_SHADOW_CASTER_NORMALOFFSET(o)
				o.vec = mul(unity_ObjectToWorld, v.vertex).xyz - _LightPositionRange.xyz; 
				o.pos = UnityObjectToClipPos(v.vertex);
				return o;
			}

			float4 frag(v2f i) : SV_Target
			{
				//SHADOW_CASTER_FRAGMENT(i)
				return UnityEncodeCubeShadowDepth((length(i.vec) + unity_LightShadowBias.x) * _LightPositionRange.w);
			}
			ENDCG
		}
    }
}
