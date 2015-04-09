 using UnityEngine;
 using System.Collections;
 
 public class MusicBg : MonoBehaviour {
 
 private static MusicBg instance = null;
 public AudioClip[] musicbg;
 private int i;
     
     
     public static MusicBg Instance
     {
         get { return instance; }
     }
     
     
     void Awake() {
         if (instance != null && instance != this) {
             Destroy(this.gameObject);
             return;
         } else {
             instance = this;
         }
         DontDestroyOnLoad(this.gameObject);
     }
  
     void Start()
     {
     i= Random.Range(0,musicbg.Length);
     StartCoroutine("Music");
     }
     
 IEnumerator Playlist()
     {
         while(true)
         {
             yield return new WaitForSeconds(1.0f);
             if(!audio.isPlaying)
             {
                 if(i != (musicbg.Length -1))
                 {
                     i++;
                     audio.clip = musicbg[i];
                     audio.Play();
                 }
                 else
                 {
                     i=0;
                     audio.clip= musicbg[i];
                     audio.Play();
                 }
             }
         }
     }
 }