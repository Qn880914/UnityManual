using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ShaderLab_ReplaceRender : MonoBehaviour
{
    [SerializeField] private Camera m_Camera;

    [SerializeField] private Shader m_Shader;

    // Start is called before the first frame update
    private void Start()
    {
        if (null != m_Camera && null != m_Shader)
        {
            m_Camera.SetReplacementShader(m_Shader, "RenderType");
        }
    }

    // Update is called once per frame
    private void Update()
    {
    }

    private void OnGUI()
    {
        /*if (null != m_Camera && null != m_Shader)
        {
            m_Camera.RenderWithShader(m_Shader, "RenderType");
        }*/
    }
}
