using UnityEngine;
using System.Collections;

public class Playlist : MonoBehaviour
{
    private int randomSong;
    private bool[] playlistIsPlayed;
    private Object[] playlist;
    private int counter = 0;
    bool isStoped = false;
    
    void Awake()
    {
        playlist = Resources.LoadAll("Music/OnTheRoad", typeof(AudioClip));
        playlistIsPlayed = new bool[playlist.Length];
        playRandomSong();
    }

    void Start()
    {
        audio.ignoreListenerPause = true;
        audio.Play();

        audio.volume = 0.5f;
    }

    void Update()
    {
        if (Input.GetKeyDown(KeyCode.F2) == true)
        {
            isStoped = false;
            playRandomSong();
        }

        if (Input.GetKeyDown(KeyCode.F3) == true && isStoped == false)
        {
            isStoped = true;
            audio.Stop();
        }
    }

    void playRandomSong()
    {
        randomSong = Random.Range(0, playlist.Length);
        if (playlistIsPlayed[randomSong] != true)
        {
            playlistIsPlayed[randomSong] = true;
            counter++;
            audio.clip = playlist[randomSong] as AudioClip;
            audio.Play();
            string[] track = audio.clip.name.Split('-');
            Debug.Log(track[0]);
            Debug.Log(track[1]);
        }

        if (playlistIsPlayed.Length == counter)
        {
            counter = 0;
            for (int i = 0; i < playlistIsPlayed.Length; i++)
            {
                playlistIsPlayed[i] = false;
            }
        }
    }

    void OnApplicationPause(bool isPaused)
    {
        if (isPaused == true)
        {
            audio.Pause();
        }
    }
}