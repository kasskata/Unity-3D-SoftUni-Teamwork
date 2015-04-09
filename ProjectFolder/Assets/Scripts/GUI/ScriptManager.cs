using UnityEngine;
using System.Collections;
using System.Collections.Generic;

public class ScriptManager : MonoBehaviour
{
    public GameObject[] cars;
    private List<GameObject> inactiveCars;
    private bool lockedCarSelected;

    void Start()
    {
        //Debug.Log(cars.Length);
        inactiveCars = new List<GameObject>();
        
        foreach (GameObject car in cars)
        {

            if (car.name == "lambo")
            {

                car.SetActive(true);
            }
            else
            {
                inactiveCars.Add(car);
                car.SetActive(false);
            }
        }

    }
    public void SelectCar(GameObject selectedCar, bool isLocked)
    {
        //Sets All Cars to inactive.
        foreach (GameObject car in cars)
        {
            if (car.activeSelf)
            {
                inactiveCars.Add(car);
                car.SetActive(false);

            }
        }

        //Checks which button is clicked and sets the corresponding car to Active state.
        foreach (GameObject icar in inactiveCars)
        {
            if (selectedCar.name == icar.name)
            {
                icar.SetActive(true);
            }
        }

        PlayerPrefs.SetString("selectedCar", selectedCar.name);
        this.lockedCarSelected = isLocked;
    }

    public void StartRace()
    {
        if (!this.lockedCarSelected)
        {
            Application.LoadLevelAsync("Track_Race_01");            
        }
    }
}
