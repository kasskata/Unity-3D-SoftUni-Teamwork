using UnityEngine;
using System.Collections;

public class ExitKey : MonoBehaviour
{

    public void Update()
    {
        if (Input.GetKeyDown(KeyCode.Escape))
        {
            Application.Quit();
        }
    }
}