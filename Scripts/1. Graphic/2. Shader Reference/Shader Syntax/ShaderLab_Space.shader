// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Custom/ShaderLab_Space"
{
	Properties
	{
		_MainTex("Main Tex", 2D) = "white" {}
		[HideInInspector] _2DArray("2D Array", 2DArray) = "white"{}
		[HideInInspector] _3D("3D", 3D) = "white"{}
		[HideInInspector] _Cube("Cube", Cube) = "white"{}

		[HideInInspector] _Float("Float", float) = 0.1
		[HideInInspector] _Int("Int", int) = 1
		[HideInInspector] _Range("Range", Range(0,10)) = 1

		[HideInInspector] _Color("Color", Color) = (1,0,0,1)
		[HideInInspector] _Vector("Vector", Vector) = (0,1,0,1)
	}

	SubShader
	{
		Tags{"Queue"="Geometry" "RenderType"="Opaque"}
		Pass
		{
			Tags{"LightMode"="ForwardBase" "ForceNoShadowCasting"="True" "IgnoreProject"="True"}

			CGPROGRAM
#pragma target 3.0
#pragma vertex vert
#pragma fragment frag

			struct v2f
			{
				float4 pos : SV_POSITION;
			};

			v2f vert(float4 position : POSITION)
			{
				v2f o;
				//o.pos = UnityObjectToClipPos(position);
				o.pos = UnityObjectToClipPos(position);
				return o;
			}

			float4 frag(v2f i) : COLOR
			{
				return float4(1,0,0,1);
			}
			ENDCG
		}
	}
}
