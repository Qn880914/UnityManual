Shader "Custom/Culling_DepthTest"
{
    Properties
    {
        // Texture
        [HideInInspector] _MainTex("Main Tex", 2D) = "white"{}
        [HideInInspector] _CubeTex("Cube Tex", Cube) = "white"{}
        [HideInInspector] _3DTex("3D Tex", 3D) = "white"{}
        
        // Vector and Color
        [HideInInspector] _Vector("Vector", Vector) = (1,1,1,1)
        [HideInInspector] _Color("Color", Color) = (1,0,0,1)
        
        // Float Int Range
        [HideInInspector] _Float("Float", float) = 1
        [HideInInspector] _Int("Int", int) = 1
        [HideInInspector] _Range("Range", Range(0,1)) = 0.5
    }
    
    SubShader
    {
        Tags{"Queue" = "Transparent" "RenderType" = "Transparent"}
        Pass
        {
            // Cull  Front | Back | Off
            // Default is Back
            Cull Back
            
            // ZWrite  On | Off
            // Default is On
            ZWrite Off
            
            // ZTest Less | Greater | LEqual | GEqual | Equal | NotEqual | Always
            // Default is LEqual
            //ZTest NotEqual
            
            // Blend
            //Blend One One
            Blend SrcAlpha OneMinusSrcAlpha 
            //Blend One Zero
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            
            sampler2D _MainTex;
            
            struct Input
            {
                float4 vertex : POSITION;
                float4 color : COLOR;
                float2 uv : TEXCOORD0;
            };
            
            struct v2f
            {
                float4 position : SV_POSITION;
                float2 uv : TEXCOORD0;
            };
            
            v2f vert(Input i)
            {
                v2f o;
                o.position = UnityObjectToClipPos(i.vertex);
                o.uv = i.uv;
                return o;
            }
            
            float4 frag(v2f i) : COLOR
            {
                float4 col = tex2D(_MainTex, i.uv);
                col.a = 0.5;
                return col;
            }
            ENDCG
        }
    }
}
