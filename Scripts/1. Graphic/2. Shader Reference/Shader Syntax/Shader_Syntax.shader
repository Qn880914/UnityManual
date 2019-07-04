Shader "Custom Shader Syntax"
{
	Properties
	{
		// texture
		[HideInInspector] _MainTex("Main Tex", 2D) = "white"{}
		[HideInInspector] _CubeTex("Cube Tex", Cube) = "white"{}
		[HideInInspector] _2DArrayTex("2DArray Tex", 2DArray) = "white"{}
		[HideInInspector] _3DTex("3D Tex", 3D) = "white"{}

		// Number and slider
		_Float("Float", float) =  1
		_Int("Int", int) = 1
		_Range("Range", Range(0,1)) =0.5

		// Color and Vector
		_Color("Color", Color) = (1,0,0,1)
		_Vector("Vector", Vector) = (1,0,0)

		[HideInInspector] _HideTex("Hide Tex", 2D) = "white"{}
		[NoScaleOffset] _NoScaleOffsetTex("No Scale Offset Tex", 2D) = "white"{}
		[Normal] _NormalTex("Normal Tex", 2D) = "white"{}
		[HDR] _HDRTex("HDR Tex", 2D) = "white"{}
		[Gama] _GamaTex("Gama Tex", 2D) = "white"{}
		[PerRendererData] _PerRendererDataTex("PerRendererData Tex", 2D) = "white"{}
	}

	SubShader
	{
		Pass
		{
			//ZTest NotEqual
CGPROGRAM
#pragma vertex vert
#pragma fragment frag

			struct appdata
			{
				float4 vertex : POSITION;
			};

			struct v2f
			{
				float4 vertex : SV_POSITION;
			};

			v2f vert(appdata i)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(i.vertex);
				return o;
			}

			float4 frag(v2f i) : COLOR
			{
				return float4(1, 0, 0, 1);
			}
ENDCG
		}
	}

	FallBack "Diffuse"
}