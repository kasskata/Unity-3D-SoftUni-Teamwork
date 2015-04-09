using UnityEngine;
using System.Collections;

public class LoadLevelLoadingScreen : MonoBehaviour
{
    private void Update()
    {
        if (Input.GetKeyDown("space"))
        {
            Application.LoadLevel("Garage");
        }
    }
}
