using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[RequireComponent(typeof(Animator))]
public class IKControl : MonoBehaviour
{
    [SerializeField] private Animator m_Animator;

    [SerializeField] private bool m_IKActive;

    [SerializeField] private Transform m_RightHandObj;

    [SerializeField] private Transform m_LookObj;

    // Start is called before the first frame update
    private void Start()
    {
        
    }

    // Update is called once per frame
    private void OnAnimatorIK()
    {
        if(m_Animator != null)
        {
            if(m_IKActive)
            {
                if(m_LookObj != null)
                {
                    m_Animator.SetLookAtWeight(1);
                    m_Animator.SetLookAtPosition(m_LookObj.position);
                }

                if(m_RightHandObj != null)
                {
                    m_Animator.SetIKPositionWeight(AvatarIKGoal.RightHand, 1);
                    m_Animator.SetIKRotationWeight(AvatarIKGoal.RightHand, 1);
                    m_Animator.SetIKPosition(AvatarIKGoal.RightHand, m_RightHandObj.position);
                    m_Animator.SetIKRotation(AvatarIKGoal.RightHand, m_RightHandObj.rotation);
                }
            }
            else
            {
                m_Animator.SetIKPositionWeight(AvatarIKGoal.RightHand, 0);
                m_Animator.SetIKRotationWeight(AvatarIKGoal.RightHand, 0);
                m_Animator.SetLookAtWeight(0);
            }
        }
    }
}
