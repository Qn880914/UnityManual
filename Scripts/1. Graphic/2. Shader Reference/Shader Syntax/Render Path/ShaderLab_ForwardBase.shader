Shader "Custom/ShaderLab_ForwardBase"
{
	Properties
	{
		_MainTex("Main Tex(RGB)", 2D) = "white" {}
	}

	SubShader
	{
		Tags
		{
			"Queue" = "Geometry"
			"RenderType" = "Opaque"
			"IgnoreProjector" = "true"
			"ForceNoShadowCasting" = "true"
		}

		Pass
		{
			Tags{"LightMode" = "ForwardBase"}

			CGPROGRAM
#pragma target 3.0
#pragma vertex vert
#pragma fragment frag

			struct appdata_v
			{
				float4 position : POSITION;
			};
			
			struct appdata_v2f
			{
				float4 position : SV_POSITION;
			};

			appdata_v2f vert(appdata_v i)
			{
				appdata_v2f o;
				o.position = UnityObjectToClipPos(i.position);
				return o;
			}

			float4 frag(appdata_v2f i)
			{
			}

			ENDCG
		}
	}
}
