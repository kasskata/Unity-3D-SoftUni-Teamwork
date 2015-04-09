using UnityEngine;
using System.Collections;

public class videocontroller : MonoBehaviour {

	// Use this for initialization
	void Start () {

MovieTexture movie= renderer.material.mainTexture as MovieTexture;
		
		movie.Play ();
}
	}

	
	

