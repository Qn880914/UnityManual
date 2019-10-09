Shader "Custom/Blend"
{
	Properties
	{
		[NoScaleOffset] _MainTex("Main Tex(RGB)", 2D) = "white" {}
		[HideInInspector] _3DTex("3D Tex(RGB)", 3D) = "white" {}
		[Gama] _CubeTex("Cube Tex(RGB)", Cube) = "white" {}
		[HDR] _2DArrayTex("2DArray Tex(RGB)", 2DArray) = "white" {}
		[Normal] _NormalTex("Normal Tex(RGB)", 2DArray) = "white" {}

		_Color("Color", Color) = (1, 0, 0, 1)
		_Vector("Vector", Vector) = (1, 0, 0, 1)

		_Float("float", float) = 1
		_Int("int", int) = 1
		_Range("Range", Range(0, 1)) = 0.5
	}

	SubShader
	{
		Tags
		{
			"Queue" = "Geometry"
			"RenderType" = "Opaque"
			"DisableBatching" = "False"
			"ForceNoShadowCasting" = "True"
			"IgnoreProjector" = "True"
			"CanUseSpriteAtlas" = "True"
		}

		Pass
		{
			Tags{"LightMode" = "ForwardBase"}

			CGPROGRAM
#pragma vertex vert
#pragma fragment frag

			struct VertexInput
			{
				float4 vertex : POSITION;
				float4 color : COLOR;
				float3 normal : NORMAL;
				float4 tangent : TANGENT;
				float2 texcoord : TEXCOORD0;
			};

			struct v2f
			{
				float4 pos : SV_POSITION;
			};

			v2f vert(VertexInput v)
			{
				v2f o;
				o.pos = UnityObjectToClipPos(v.vertex);
				return o;
			}

			float4 frag(v2f i) : SV_Target
			{
				return float4(0.5, 0, 0, 1);
			}
			ENDCG
		}

		Pass
		{
			//Blend One OneMinusDstColor
			Blend OneMinusSrcColor Zero

			Tags{"LightMode" = "ForwardAdd"}

			CGPROGRAM
#pragma vertex vert
#pragma fragment frag

			struct VertexInput
			{
				float4 vertex : POSITION;
				float4 color : COLOR;
				float3 normal : NORMAL;
				float4 tangent : TANGENT;
				float2 texcoord : TEXCOORD0;
			};

			struct v2f
			{
				float4 pos : SV_POSITION;
			};

			v2f vert(VertexInput v)
			{
				v2f o;
				o.pos = UnityObjectToClipPos(v.vertex);
				return o;
			}

			float4 frag(v2f i) : SV_Target
			{
				return float4(0.4, 0, 0, 1);
			}
			ENDCG
		}
	}
}
