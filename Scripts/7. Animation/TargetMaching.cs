using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class TargetMaching : MonoBehaviour
{
    [SerializeField] private Animator m_Animator;

    [SerializeField] private GameObject m_Target;

    // Start is called before the first frame update
    void Start()
    {
        if(null != m_Animator)
        {
            m_Animator.MatchTarget(m_Target.transform.position,
                Quaternion.identity, AvatarTarget.LeftFoot, new MatchTargetWeightMask(Vector3.one, 0), 0, 0);
        }
    }

    // Update is called once per frame
    void Update()
    {
        
    }
}
