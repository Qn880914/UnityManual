Shader "Custom/ShaderLab_ZWrite"
{
	Properties
	{
		_MainTex("Main Tex", 2D) = "white" {}
	}

	SubShader
	{
		//Tags{"Queue" = "Transparent" "PreviewType"="Plane"}

		Pass
		{
			ZWrite Off

			Blend One One

			//ZTest Always

			CGPROGRAM
#pragma vertex vert
#pragma fragment frag

			sampler2D _MainTex;
			struct appdata
			{
				float4 pos : POSITION;
				float2 uv : TEXCOORD0;
			};
			struct v2f
			{
				float4 pos : SV_POSITION;
				float2 uv : TEXCOORD0;
			};

			v2f vert(appdata i)
			{
				v2f o;
				o.pos = UnityObjectToClipPos(i.pos);
				o.uv = i.uv;
				return o;
			}

			float4 frag(v2f i) : COLOR
			{
				float4 c = tex2D(_MainTex, i.uv);
				c.a = 0.1;
				return c;
			}
			ENDCG
		}
	}

	FallBack "Difuse"
}