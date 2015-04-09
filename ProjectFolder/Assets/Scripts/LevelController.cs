using UnityEngine;
using System.Collections;

public class LevelController : MonoBehaviour
{
    public AudioSource musicPlayer;
    public GameObject mainMenu;

    private void Awake()
    {
        string carName = PlayerPrefs.GetString("selectedCar");
        GameObject selectedCar = (GameObject)GameObject.Instantiate(Resources.Load("Prefabs/CarForGame/" + carName));
        selectedCar.transform.parent = GameObject.Find("Cars").transform;
        selectedCar.transform.position = GameObject.Find("PlayerStartPosition").transform.position;
        selectedCar.GetComponent<AICarController>().path = GameObject.Find("Path").transform;
        selectedCar.GetComponent<AICarController>().isPlayer = true;
        if (selectedCar.name.Contains("(Clone)"))
        {
            selectedCar.name = selectedCar.name.Replace("(Clone)", "Player");
        }
        else
        {
            selectedCar.name += "Player";
        }

        selectedCar.tag = "Player'sCar";
        PlayerPrefs.DeleteAll();
    }

    private void Update()
    {
        if (Input.GetKeyDown(KeyCode.Escape))
        {
            if (Time.timeScale == 1)
            {
                DisableEnableCarSounds(false);
                Time.timeScale = 0;
                this.mainMenu.SetActive(true);
                Screen.showCursor = true;
            }
            else if (Time.timeScale == 0)
            {
                DisableEnableCarSounds(true);
                Time.timeScale = 1;
                this.mainMenu.SetActive(false);
                Screen.showCursor = false;
            }
        }
    }

    public void LoadGarage()
    {
        Application.LoadLevelAsync("Garage");
    }

    public void ExitGame()
    {
        Application.Quit();
    }

    public void ChangeVolume()
    {
        this.musicPlayer.volume = UISlider.current.value;
        UISlider.current.GetComponentInChildren<UILabel>().text = (int)(UISlider.current.value * 100) + "%";
    }

    private void DisableEnableCarSounds(bool isEnabled)
    {
        GameObject[] cars = GameObject.FindGameObjectsWithTag("Car");
        for (int i = 0; i < cars.Length; i++)
        {
            cars[i].GetComponent<AudioSource>().enabled = isEnabled;
        }

        GameObject playerCar = GameObject.FindGameObjectWithTag("Player'sCar");
        playerCar.GetComponent<AudioSource>().enabled = isEnabled;
    }
}
