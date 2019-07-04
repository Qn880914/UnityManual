Shader "Custom/ShaderLab_Syntax"
{
    Properties
    {
        // Number and Slider
        _Range("Range", Range(0, 10)) = 5
        _Float("Float", float) = 1
        _Int("Int", int) = 1
        
        // Color and Vectors
        _Color("Color", Color) = (1,1,0,1)
        _Vector("Vector", Vector) = (1,0,0,0)
        
        // Textures
        _MainTex("Main Tex", 2D) = "white" {}
        _3DTex("3D Tex", 3D) = "white"{}
        _Cube("Cube", Cube) = "white"{}
    }
    
    SubShader
    {
        Pass
        {
        }
    }
    
    Fallback "diffuse"
}
