Shader "Custom/ShaderLab_RenderType"
{
	Properties
	{}

	SubShader
	{
		Tags{"RenderType"="Opaque"}

		Pass
		{
			CGPROGRAM
#pragma target 3.0
#pragma vertex vert
#pragma fragment frag

			struct appdata
			{
				float4 pos : POSITION;
			};

			struct v2f
			{
				float4 pos : SV_POSITION;
			};

			v2f vert(appdata i)
			{
				v2f o;
				o.pos = UnityObjectToClipPos(i.pos);
				return o;
			}

			float4 frag(v2f i) : COLOR
			{
				return float4(1,0,0,1);
			}

			ENDCG
		}
	}

	FallBack "Difuse"
}