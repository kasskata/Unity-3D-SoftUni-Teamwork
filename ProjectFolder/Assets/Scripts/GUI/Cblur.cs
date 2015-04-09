using UnityEngine;
using System.Collections;

public class Cblur : MonoBehaviour
{
    public void Update()
    {
        if (Input.GetKeyDown(KeyCode.Escape))
        {
            if (Time.timeScale == 0)
            {
                gameObject.GetComponent<BlurEffect>().enabled = false;

            }
            else
            {
                gameObject.GetComponent<BlurEffect>().enabled = true;
            }
        }
    }
}