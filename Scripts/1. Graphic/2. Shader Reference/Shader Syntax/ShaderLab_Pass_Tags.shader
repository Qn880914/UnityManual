Shader "Custom/ShaderLab_Pass_Tags"
{
	Properties
	{}
	
	SubShader
	{
		//	LightMode :
		//			Always: Always rendered; no lighting is applied.
		//		Forward Rendering
		//			ForwardBase: Used in Forward rendering, ambient, main directional light, vertex / SH lights and lightmapsare applied.
		//			ForwardAdd: Used in Forward rendering; additive per-pixel lights are applied, one pass per light.
		//		Deferred
		//			Deferred: Used in Deferred Shading; renders g - buffer.
		//		Legacy Deferred Lighting
		//			PrepassBase: Used in legacy Deferred Lighting, renders normals and specular exponent.
		//			PrepassFinal: Used in legacy Deferred Lighting, renders final color by combining textures, lighting and emission.
		//		legacy Vertex Lit
		//			Vertex: Used in legacy Vertex Lit rendering when object is not lightmapped; all vertex lights are applied.
		//			VertexLMRGBM: Used in legacy Vertex Lit rendering when object is lightmapped; on platforms where lightmap is RGBM encoded (PC & console).
		//			VertexLM: Used in legacy Vertex Lit rendering when object is lightmapped; on platforms where lightmap is double-LDR encoded (mobile platforms).
		//		In any of the above, to render Shadows or a depth texture, ShadowCaster pass is used
		//			ShadowCaster: Renders object depth into the shadowmap or a depth texture.
		//
		//			MotionVectors: Used to calculate per-object motion vectors.
		//	PassFlags :
		//		OnlyDirectional
		//			When used in ForwardBase pass type, this flag makes it so that only the main directional light and ambient/lightprobe data is passed into the shader. This means that data of non-important lights is not passed into vertex-light or spherical harmonics shader variables. See Forward rendering for details.
		//			A pass can indicate flags that change how rendering pipeline passes data to it. This is done by using PassFlags tag, with a value that is space-separated flag names. Currently the flags supported are:
		//	RequireOptions :
		//		A pass can indicate that it should only be rendered when some external conditions are met. This is done by using RequireOptions tag, whose value is a string of space separated options. Currently the options supported by Unity are:
		//		SoftVegetation
		//			 Render this pass only if Soft Vegetation is on in the Quality window.

		Pass
		{
			Tags{"LightMode"="ForwardBase"}
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
				o.pos = UnityObjectToClipPos(position);
				return o;
			}

			float4 frag(v2f i) : COLOR
			{
				return float4(1,0,0,1);
			}
			ENDCG
		}
		Pass
		{
			Tags{"LightMode"="ForwardAdd"}

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

		Pass
		{
			Tags{"LightMode" = "Deferred"}

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
				return float4(0,0,1,1);
			}

			ENDCG
		}
	}

	FallBack "Diffuse"
}