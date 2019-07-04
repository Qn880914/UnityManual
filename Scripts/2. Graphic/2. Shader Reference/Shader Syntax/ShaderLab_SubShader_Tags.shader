Shader "ShaderLab_SubShader_Tags"
{
	Properties
	{}

	SubShader
	{
		// Queue : 
		//			Background	1000   
		//			Geometry	2000 (default)  
		//			AlphaTest	2450 
		//			Transparent 3000
		//			Overlay		4000
		// RenderType	:  Use for ReplacementShader
		//			Camera.RenderWithShader / Camera.SetReplacementShader
		//			Opaque
		//			Transparent
		//			Background
		//			"Overlay"
		// DisableBatching 
		//			True
		//			False
        //          lodfade
        // ForceNoShadowCasting
        //          True
        //          False
        // IgnoreProjector
        //          True
        //          False
        //  CanUseSpriteAtlas
        //          True
        //          False
        // PreviewType
        //          Plane
        //          Skybox
		Tags{"Queue"="Geometry" "RenderType"="Opaque" "DisableBatching" = "True" "PreviewType"="Plane"}

		Pass
		{
			//Blend One One

			CGPROGRAM
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
				return float4(1,1,0,1);
			}

			ENDCG
		}
	}

	FallBack "Difuse"
}