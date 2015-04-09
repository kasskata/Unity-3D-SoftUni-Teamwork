using UnityEngine;
using System.Collections;

public class MenuTime : MonoBehaviour
{
    private void Update()
    {
        Time.timeScale = 1;
        AudioListener.volume = 1;
    }
}
