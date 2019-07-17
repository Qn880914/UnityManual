Shader "Custom/ShaderLab_VertexLight"
{
	Properties
	{
		_Color("Color(RGB)", Color) = (1,0,0,1)
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
			Tags {"LightMode" = "Vertex"}

			CGPROGRAM
#pragma target 3.0
#pragma vertex vert
#pragma fragment frag

			struct appdata_v
			{
				float4 position : POSITION;
				float3 normal : NORMAL;
				float4 color : COLOR;
				float2 texcoord : TEXCOORD0;
			};

			struct appdata_v2f
			{
				float4 position : SV_POSITION;
				float3 normal : NORMAL;
				float4 color : COLOR;
				float2 texcoord : TEXCOORD0;
			};

			appdata_v2f vert(appdata_v i)
			{
				appdata_v2f o;
				o.position = UnityObjectToClipPos(i.position);
				o.color = unity_LightColor[0];
				return o;
			}

			float4 frag(appdata_v2f i) : COLOR
			{
				return i.color;
			}
			
			ENDCG
		}
	}
}
