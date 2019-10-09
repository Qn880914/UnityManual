Shader "Custom/ShaderReference/07-checkerboard"
{
	Properties
	{
		_Density("Density", Range(2, 50)) = 2
	}

		SubShader
	{
		Pass
		{
			CGPROGRAM
#pragma vertex vert
#pragma fragment frag

			float _Density;

			struct v2f
			{
				float4 vertex : SV_POSITION;
				float2 uv : TEXCOORD0;
			};

			v2f vert(float4 vertex : POSITION, float2 texcoord : TEXCOORD0)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(vertex);
				o.uv = texcoord * _Density;
				return o;
			}

			float4 frag(v2f i) : SV_Target
			{
				float2 c = i.uv;
				c = floor(c) / 2;
				float checker = frac(c.x + c.y) * 2;
				return checker;
			}
			ENDCG
		}
	}
}
