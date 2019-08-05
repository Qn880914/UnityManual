using UnityEngine;

public class OcclusionCullingTest : MonoBehaviour
{
    private Renderer m_Renderer;

    private Camera m_CameraMain;

    // Start is called before the first frame update
    void Start()
    {
        m_Renderer = GetComponent<Renderer>();
        m_CameraMain = Camera.main;
    }

    // Update is called once per frame
    void Update()
    {
        if(m_Renderer.isVisible)
        {
            Debug.Log("Visible by MainCamera");
        }
        else
        {
            Debug.Log("Not Visible by MainCamera");
        }

        if(m_CameraMain.useOcclusionCulling)
        {
            Debug.Log("Occlusion Culling is Using");
        }
    }
}
