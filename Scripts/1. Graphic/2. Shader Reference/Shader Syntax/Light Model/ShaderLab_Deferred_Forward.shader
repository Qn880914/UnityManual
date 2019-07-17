Shader "Custom/ShaderLab_Deferred_Forward"
{
	Properties
	{
		_MainTex("Main Tex(RGB)", 2D) = "white" {}
		[HideInInspector] _Cube("Cube", Cube) = "white" {}
		[NoScaleOffset] _2DArray("2D Array", 2DArray) = "white" {}
		[Normal] _3D("3D", 3D) = "white" {}

		[HideInInspector] _Color("Color", Color) = (1,0,0,1)
		[HideInInspector] _Vector("Vector", Vector) = (1,0,0,1)

		[HideInInspector] _Float("Float", float) = 1.0
		[HideInInspector] _Int("Int", int) = 1
		[HideInInspector] _Range("Range", Range(0, 10)) = 5
	}

	SubShader
	{
		Tags
		{
			"Queue" = "Geometry"
			"RenderType" = "Opaque"
			"IgnorProjector" = "true"
			"ForceNoShadowCasting" = "true"
		}

		//Blend One One

		// ---- deferred 
		Pass
		{
			Tags{"LightMode"="Deferred"}

			Blend One One

			CGPROGRAM
#pragma target 3.0
#pragma vertex vert
#pragma fragment frag

			struct appdata_v
			{
				float4 position : POSITION;
				float3 normal : NORMAL;
				float2 texcoord : TEXCOORD0;
			};

			struct appdata_v2f
			{
				float4 position : SV_POSITION;
				float3 normal : NORMAL;
				float2 texcoord : TEXCOORD0;
			};

			appdata_v2f vert(appdata_v i)
			{
				appdata_v2f o;
				o.position = UnityObjectToClipPos(i.position);
				o.normal = i.normal;
				o.texcoord = i.texcoord;
				return o;
			}

			float4 frag(appdata_v2f i) : COLOR
			{
				return float4(1, 0, 0, 1);
			}
			ENDCG
		}

		// ---- forward Base
		Pass
		{
			Tags{"LightMode"="ForwardBase"}

			CGPROGRAM
#pragma target 3.0
#pragma vertex vert
#pragma fragment frag

			struct appdata_v
			{
				float4 position : POSITION;
				float3 normal : NORMAL;
				float2 texcoord : TEXCOORD0;
			};

			struct appdata_v2f
			{
				float4 position : SV_POSITION;
				float3 normal : NORMAL;
				float2 texcoord : TEXCOORD0;
			};

			appdata_v2f vert(appdata_v i)
			{
				appdata_v2f o;
				o.position = UnityObjectToClipPos(i.position);
				o.normal = i.normal;
				o.texcoord = i.texcoord;
				return o;
			}

			float4 frag(appdata_v2f i) : COLOR
			{
				return float4(0,1,0,1);
			}
			ENDCG
		}

		// ---- forward add
		Pass
		{
			Tags{"LightMode" = "ForwardAdd"}
			CGPROGRAM
#pragma target 3.0
#pragma vertex vert
#pragma fragment frag

			struct appdata_v
			{
				float4 position : POSITION;
				float3 normal : NORMAL;
				float2 texcoord : TEXCOORD0;
			};

			struct appdata_v2f
			{
				float4 position : SV_POSITION;
				float3 normal : NORMAL;
				float2 texcoord : TEXCOORD0;
			};

			appdata_v2f vert(appdata_v i)
			{
				appdata_v2f o;
				o.position = UnityObjectToClipPos(i.position);
				o.normal = i.normal;
				o.texcoord = i.texcoord;
				return o;
			}

			float4 frag(appdata_v2f i) : COLOR
			{
				return float4(0,0,1,1);
			}
			ENDCG
		}
	}
}
