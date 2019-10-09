using UnityEngine;
using UnityEngine.UI;

public class DynamicResolutionTest : MonoBehaviour
{
    [SerializeField] private Text m_TextScreen;

    [SerializeField] private float m_ResolutionWidthScaleMax = 1.0f;

    [SerializeField] private float m_ResolutionHeightScaleMax = 1.0f;

    [SerializeField] private float m_ResolutionWidthScaleMin = 0.5f;

    [SerializeField] private float m_ResolutionHeightScaleMin = 0.5f;

    [SerializeField] private float m_ResolutionWidthScaleIncrement = 0.1f;

    [SerializeField] private float m_ResolutionHeightScaleIncrement = 0.1f;

    private FrameTiming[] frameTimings = new FrameTiming[3];

    private float m_WidthScale = 1.0f;

    private float m_HeightScale = 1.0f;

    private uint m_FrameCount = 0;

    private const uint kNumFrameTimings = 2;

    private double m_FrameTimeGPU;

    private double m_FrameTimeCPU;

    // Start is called before the first frame update
    private void Start()
    {
        int width = (int)Mathf.Ceil(ScalableBufferManager.widthScaleFactor * Screen.currentResolution.width);
        int height = (int)Mathf.Ceil(ScalableBufferManager.heightScaleFactor * Screen.currentResolution.height);
        m_TextScreen.text = string.Format("Scale : {0:F3}x{1:F3}\nResolution : {2}x{3}\n", m_WidthScale, m_HeightScale, width, height);
    }

    // Update is called once per frame
    private void Update()
    {
        float oldWidthScale = m_WidthScale;
        float oldHeightScale = m_HeightScale;

        if(Input.GetKeyDown(KeyCode.A))
        {
            m_WidthScale = Mathf.Max(m_ResolutionWidthScaleMin, m_WidthScale - m_ResolutionWidthScaleIncrement);
            m_HeightScale = Mathf.Max(m_ResolutionHeightScaleMin, m_HeightScale - m_ResolutionHeightScaleIncrement);
        }

        if(Input.GetKeyDown(KeyCode.B))
        {
            m_WidthScale = Mathf.Min(m_ResolutionWidthScaleMax, m_WidthScale + m_ResolutionWidthScaleIncrement);
            m_HeightScale = Mathf.Min(m_ResolutionHeightScaleMax, m_HeightScale + m_ResolutionHeightScaleIncrement);
        }

        if(oldWidthScale != m_WidthScale || oldHeightScale != m_HeightScale)
        {
            ScalableBufferManager.ResizeBuffers(m_WidthScale, m_HeightScale);
        }

        DetermineResolution();
        int width = (int)Mathf.Ceil(ScalableBufferManager.widthScaleFactor * Screen.currentResolution.width);
        int height = (int)Mathf.Ceil(ScalableBufferManager.heightScaleFactor * Screen.currentResolution.height);
        m_TextScreen.text = string.Format("Scale : {0:F3}x{1:F3}\nResolution : {2}x{3}\n", m_WidthScale, m_HeightScale, width, height);

        m_TextScreen.text = string.Format("Scale: {0:F3}x{1:F3}\nResolution: {2}x{3}\nScaleFactor: {4:F3}x{5:F3}\nGPU: {6:F3} CPU: {7:F3}",
            m_WidthScale,
            m_HeightScale,
            width,
            height,
            ScalableBufferManager.widthScaleFactor,
            ScalableBufferManager.heightScaleFactor,
            m_FrameTimeGPU,
            m_FrameTimeCPU);
    }

    private void DetermineResolution()
    {
        ++m_FrameCount;
        if (m_FrameCount <= kNumFrameTimings)
        {
            return;
        }
        FrameTimingManager.CaptureFrameTimings();
        FrameTimingManager.GetLatestTimings(kNumFrameTimings, frameTimings);
        if (frameTimings.Length < kNumFrameTimings)
        {
            Debug.LogFormat("Skipping frame {0}, didn't get enough frame timings.",
                m_FrameCount);

            return;
        }

        m_FrameTimeGPU = frameTimings[0].gpuFrameTime;
        m_FrameTimeCPU = frameTimings[0].cpuFrameTime;
    }
}
