Shader "Custom/ShaderLab_LightMode"
{
	Properties
	{}
	
	SubShader
	{
		Pass
		{
			Tags{"LightMode"="Vertex"}

			CGPROGRAM
#pragma vertex vert
#pragma fragment frag

			struct v2f
			{
				float4 pos : SV_POSITION;
			};

			v2f vert(float4 position : POSITION)
			{
				v2f o;
				o.pos = UnityObjectToClipPos(position);
				return o;
			}

			float4 frag(v2f i) : COLOR
			{
				return float4(0,1,0,1);
			}

			ENDCG
		}
	}

	FallBack "Diffuse"
}