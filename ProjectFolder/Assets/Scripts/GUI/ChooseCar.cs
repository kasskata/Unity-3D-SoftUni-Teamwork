using UnityEngine;
using System.Collections;
using System.Collections.Generic;

public class ChooseCar : MonoBehaviour {
    public GameObject car;
    public bool isLocked;
    private const string DefaultButtonSpriteName = "car_unactive_button";
    private const string SelectedButtonSpriteName = "car_active_button";

    public void OnClick()
    {
        SetButtonSprites();
        GameObject.Find("ScriptMng").GetComponent<ScriptManager>().SelectCar(car, this.isLocked);
    }

    private void SetButtonSprites()
    {
        UIGrid parentGrid = this.gameObject.GetComponentInParent<UIGrid>();
        for (int i = 0; i < parentGrid.transform.childCount; i++)
        {
            parentGrid.GetChild(i).GetComponent<UISprite>().spriteName = DefaultButtonSpriteName;
        }

        this.gameObject.GetComponent<UISprite>().spriteName = SelectedButtonSpriteName;
    }
}
