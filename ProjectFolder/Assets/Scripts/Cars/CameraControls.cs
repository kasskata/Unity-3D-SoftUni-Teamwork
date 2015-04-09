using UnityEngine;
using System.Collections;
using System.Collections.Generic;

public class CameraControls : MonoBehaviour
{
    public List<Vector3> cameraPositions = new List<Vector3>();
    public string cameraKeyString;
    public float cameraSpeed = 0f;
    public float crotation;
    protected int currentCameraPosition = 0;
    protected Transform target;
    protected float heightDamping = 1f;
    protected float rotationDamping = 1f;

    internal void Start()
    {
        List<GameObject> cars = new List<GameObject>();
        GameObject[] carsArray = GameObject.FindGameObjectsWithTag("Player'sCar");
        cars.AddRange(carsArray);

        if (cars.Count > 1)
        {
            target = cars[0].transform;
            Debug.Log("There are more then one player`sCar object active on the scene");
        }
        else if (cars.Count == 1)
        {
            target = cars[0].transform;
        }
        else
        {
            Debug.Log("No game objects with Player`sCar found");
        }
    }

    internal void LateUpdate()
    {
        if (cameraKeyString == "")
        {
            cameraKeyString = "C";
        }

        KeyCode cameraKey = (KeyCode)System.Enum.Parse(typeof(KeyCode), cameraKeyString);
        if (Input.GetKeyDown(cameraKey) == true)
        {
            if (currentCameraPosition == cameraPositions.Count - 1)
            {
                currentCameraPosition = 0;
            }
            else
            {
                currentCameraPosition++;
            }
        }
        if (currentCameraPosition > 1)
        {
            RideWithTheCar();
        }
        else
        {
            FollowTheCar();
        }
    }

    private void FollowTheCar()
    {
        transform.parent = null;
        var wantedRotationAngle = target.eulerAngles.y;
        var wantedHeight = target.position.y + cameraPositions[currentCameraPosition].y;

        var currentRotationAngle = transform.eulerAngles.y;
        var currentHeight = transform.position.y;

        // Damp the rotation around the y-axis
        currentRotationAngle = Mathf.LerpAngle(currentRotationAngle, wantedRotationAngle, rotationDamping * Time.deltaTime);

        // Damp the height
        currentHeight = Mathf.Lerp(currentHeight, wantedHeight, heightDamping * Time.deltaTime);

        // Convert the angle into a rotation
        var currentRotation = Quaternion.Euler(0, currentRotationAngle, 0);

        // Set the position of the camera on the x-z plane to:
        transform.position = target.position;
        transform.position -= currentRotation * Vector3.forward * cameraPositions[currentCameraPosition].z;

        // Set the height of the camera
        transform.position = new Vector3(transform.position.x, currentHeight, transform.position.z);

        // Always look at the target
        transform.LookAt(target);

    }

    private void RideWithTheCar()
    {
        transform.parent = target.transform;
        this.transform.localPosition = cameraPositions[currentCameraPosition];
    }
}