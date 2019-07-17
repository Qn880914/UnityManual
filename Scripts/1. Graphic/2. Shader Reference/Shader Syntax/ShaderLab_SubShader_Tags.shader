Shader "Custom/ShaderLab_SubShader_Tags"
{
	Properties
	{}

	SubShader
	{
		// Queue : 
		//		decides which render queue its objects belong to, this way any Transparent shaders make sure they are drawn after all opaque objects and so on.
		//			Background	1000   : this render queue is rendered before any others. You’d typically use this for things that really need to be in the background.
		//			Geometry	2000 (default)  : this is used for most objects. Opaque geometry uses this queue.
		//			AlphaTest	2450	 : alpha tested geometry uses this queue. It’s a separate queue from Geometry one since it’s more efficient to render alpha-tested objects after all solid ones are drawn.
		//			Transparent 3000	 : this render queue is rendered after Geometry and AlphaTest, in back-to-front order. Anything alpha-blended (i.e. shaders that don’t write to depth buffer) should go here (glass, particle effects).
		//			Overlay		4000	 : this render queue is meant for overlay effects. Anything rendered last should go here (e.g. lens flares).
		// RenderType	:  Use for ReplacementShader
		//		This is used by Shader Replacement and in some cases used to produce camera’s depth texture.
		//			Camera.RenderWithShader / Camera.SetReplacementShader
		//			Opaque
		//			Transparent
		//			Background
		//			"Overlay"
		// DisableBatching 
		//		Some shaders (mostly ones that do object-space vertex deformations) do not work when Draw Call Batching is used – that’s because batching transforms all geometry into world space, so “object space” is lost.
		//			True	: always disables batching for this shader
		//			False	: does not disable batching; this is default
        //          lodfade	: disable batching when LOD fading is active; mostly used on trees
        // ForceNoShadowCasting
		//		If IgnoreProjector tag is given and has a value of “True”, then an object that uses this shader will not be affected by Projectors. This is mostly useful on semitransparent objects, because there is no good way for Projectors to affect them.
        //          True
        //          False
        // IgnoreProjector
		//		This is mostly useful on semitransparent objects, because there is no good way for Projectors to affect them
        //          True
        //          False
        //  CanUseSpriteAtlas
		//		Set CanUseSpriteAtlas tag to “False” if the shader is meant for sprites, and will not work when they are packed into atlases(see Sprite Packer).
        //          True
        //          False
        // PreviewType
        //          Plane
        //          Skybox
		Tags{"Queue"="Transparent" "RenderType"="Opaque" "DisableBatching" = "True" "PreviewType"="Plane"}

		Pass
		{
			//Blend One One

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
				return float4(1,1,0,1);
			}

			ENDCG
		}
	}

	FallBack "Difuse"
}