using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using System.Linq;

public class teset : MonoBehaviour
{
    // Start is called before the first frame update
    void Start()
    {
        List<int> listInt = new List<int>();
        listInt.Add(5);
        listInt.Add(8);
        listInt.Add(1);
        listInt.Add(2);
        listInt.Add(10);
        listInt.Add(7);
        listInt.Add(6);
        listInt = listInt.OrderBy(item => item).ToList();
        for(int i = 0; i < listInt.Count; ++ i)
        {
            UnityEngine.Debug.Log(listInt[i]);
        }
    }

    // Update is called once per frame
    void Update()
    {
        
    }
}
