using UnityEngine;
using System.Collections;

public class SplashScreen : MonoBehaviour {
	public float timer = 2f;
	public string levelToLoad = "SU-821";

	// Use this for initialization
	void Start ()
    {
		StartCoroutine("DisplayScene");
        StartCoroutine(PlayMusic());
	}

    private IEnumerator PlayMusic()
    {
        yield return new WaitForEndOfFrame();
        GameObject.Find("Camera").GetComponent<AudioSource>().Play();

        Debug.Log(GameObject.Find("Camera").GetComponent<AudioSource>().isPlaying);
    }

	IEnumerator DisplayScene() {
		yield return new WaitForSeconds( timer );
		Application.LoadLevel( levelToLoad );
	
	}
}
