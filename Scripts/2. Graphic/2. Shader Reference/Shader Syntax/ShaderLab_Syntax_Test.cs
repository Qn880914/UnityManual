using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ShaderLab_Syntax_Test : MonoBehaviour
{
    [SerializeField] private Texture2D m_MainTexture;

    [SerializeField] private MeshRenderer m_MeshRenderer;

    // Start is called before the first frame update
    void Start()
    {
        if(null != m_MainTexture && null != m_MeshRenderer)
        {
            MaterialPropertyBlock propertyBlock = new MaterialPropertyBlock();
            propertyBlock.SetTexture("_MainTex", m_MainTexture);
            m_MeshRenderer.SetPropertyBlock(propertyBlock);
        }
    }

    // Update is called once per frame
    void Update()
    {
        
    }
}
