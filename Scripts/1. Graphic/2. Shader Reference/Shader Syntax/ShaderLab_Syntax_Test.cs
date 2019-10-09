using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ShaderLab_Syntax_Test : MonoBehaviour
{
    [SerializeField] private readonly Texture2D m_MainTexture;

    [SerializeField] private readonly MeshRenderer m_MeshRenderer;

    // Start is called before the first frame update
    private void Start()
    {
        if(null != m_MainTexture && null != m_MeshRenderer)
        {
            MaterialPropertyBlock propertyBlock = new MaterialPropertyBlock();
            propertyBlock.SetTexture("_MainTex", m_MainTexture);
            m_MeshRenderer.SetPropertyBlock(propertyBlock);
        }
    }

    // Update is called once per frame
    private void Update()
    {
        
    }
}
