Shader "ShaderLab_GrabPass"
{
	Properties
	{}

	SubShader
	{
		Tags{"RenderType"="Opaque"}

		GrabPass{}

		Pass
		{
			CGPROGRAM
	#pragma vertex vert
	#pragma fragment frag
	#include "UnityCG.cginc"

			sampler2D _GrabTexture;

			struct appdata
			{
				float4 vertex : POSITION;
			};

			struct v2f
			{
				float4 vertex : SV_POSITION;
				float4 grabVertex : TEXCOORD0;
			};

			v2f vert(appdata i)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(i.vertex);
				o.grabVertex = ComputeGrabScreenPos(i.vertex);
				return o;
			}

			float4 frag(v2f i) : COLOR
			{
				return tex2Dproj(_GrabTexture, i.grabVertex);
			}
			ENDCG
		}
	}

	FallBack "Difuse"
}