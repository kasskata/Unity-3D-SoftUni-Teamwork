using UnityEngine;
using System.Collections;

public class Music : MonoBehaviour {

  
     Object[] myMusic; // declare this as Object array
     
     void Awake () {
        myMusic = Resources.LoadAll("Music",typeof(AudioClip));
        audio.clip = myMusic[0] as AudioClip;
     }
     
     void Start (){
        audio.Play(); 
     }
  
     // Update is called once per frame
     void Update () {
        if(!audio.isPlaying)
          playRandomMusic();
     }
     
     void playRandomMusic() {
        audio.clip = myMusic[Random.Range(0,myMusic.Length)] as AudioClip;
        audio.Play();
     }
 }