using UnityEngine;
using System.Collections;

public class Movement : MonoBehaviour
{
    // ColidersAndJoints
    private WheelCollider wheelL;
    private WheelCollider wheelR;
    private WheelCollider wheelRL;
    private WheelCollider wheelRR;
    private WheelCollider[] wheels;

    // GameObjects tires
    private Transform wheelLRotation;
    private Transform wheelRRotation;
    private Transform wheelRLRotation;
    private Transform wheelRRRotation;
    private Transform[] wheelsRotation;
    // Constraints
    private float lowStearSpeed = 10f;
    private float topSpeed = 1000f;
    private float torgue = 560f;
    private float maxSteer = 10f;
    private float minSteer = 1f;
    private float desceleration = 200f;
    public float currentSpeed;
    // Shukaritets - Backlights(Stop , Reverse)
    private GameObject backlights;
    private Color RedLight = new Color(159, 0, 0);
    private Light backLeftLight;
    private Light backRightLight;

    void Start()
    {
        rigidbody.centerOfMass += new Vector3(0, -0.7f, 0f);
        wheelL = GameObject.Find("ColliderFL").GetComponent<WheelCollider>() as WheelCollider;
        wheelR = GameObject.Find("ColliderFR").GetComponent<WheelCollider>() as WheelCollider;
        wheelRL = GameObject.Find("ColliderRL").GetComponent<WheelCollider>() as WheelCollider;
        wheelRR = GameObject.Find("ColliderRR").GetComponent<WheelCollider>() as WheelCollider;
        wheels = new WheelCollider[] { wheelL, wheelR, wheelRL, wheelRR };

        wheelLRotation = wheelL.transform.GetChild(0).transform.GetChild(0);
        wheelRRotation = wheelR.transform.GetChild(0).transform.GetChild(0);
        wheelRLRotation = wheelRL.transform.GetChild(0);
        wheelRRRotation = wheelRR.transform.GetChild(0);
        wheelsRotation = new Transform[] { wheelLRotation, wheelRRotation, wheelRLRotation, wheelRRRotation };

        backlights = GameObject.Find("BackLights");
        backLeftLight = backlights.transform.GetChild(0).GetComponent<Light>();
        backRightLight = backlights.transform.GetChild(1).GetComponent<Light>();

        backlights.SetActive(false);

    }


    void FixedUpdate()
    {
        // Gas
        currentSpeed = Mathf.Round(2 * Mathf.PI * wheelRL.radius * wheelRL.rpm * 60 / 100);

        if (currentSpeed <= topSpeed)
        {
            wheelRL.motorTorque = torgue * Input.GetAxis("Vertical");
            wheelRR.motorTorque = torgue * Input.GetAxis("Vertical");
        }
        else
        {
            wheelRL.motorTorque = 0;
            wheelRR.motorTorque = 0;
        }

        // Speed reduce slip
        float speedFactor = rigidbody.velocity.magnitude / lowStearSpeed;
        float currentSteerAngle = Mathf.Lerp(maxSteer, minSteer, speedFactor);


        currentSteerAngle *= Input.GetAxis("Horizontal");
        Debug.Log(currentSteerAngle);
        // Stear
        wheelL.steerAngle = currentSteerAngle;
        wheelR.steerAngle = currentSteerAngle;

        //Deseleration
        if (Input.GetButtonDown("Vertical") == true)
        {
            wheelRL.brakeTorque = 0f;
            wheelRR.brakeTorque = 0f;
        }
        else if (Input.GetButtonDown("Vertical") == true && currentSpeed < 0)
        {
             wheelRL.brakeTorque = desceleration * 3;
            wheelRR.brakeTorque = desceleration * 3;
        }
        else
        {
            wheelRL.brakeTorque = desceleration;
            wheelRR.brakeTorque = desceleration;
        }
    }
    void Update()
    {
        // Rotate on move forward
        wheelLRotation.Rotate(0, -wheelL.rpm / 60 * 360 * Time.deltaTime, 0);
        wheelRRotation.Rotate(0, wheelR.rpm / 60 * 360 * Time.deltaTime, 0);
        wheelRLRotation.Rotate(0, -wheelRL.rpm / 60 * 360 * Time.deltaTime, 0);
        wheelRRRotation.Rotate(0, wheelRR.rpm / 60 * 360 * Time.deltaTime, 0);

        // Rotate on steering
        wheelL.transform.localEulerAngles = new Vector3(0, Mathf.Clamp(wheelL.steerAngle, -45, 45f), 0);
        wheelR.transform.localEulerAngles = new Vector3(0, Mathf.Clamp(wheelR.steerAngle, -45f, 45f), 0);

        // Backlights & Reverse effect
        if (currentSpeed < 0)
        {
            backRightLight.color = Color.white;
            backLeftLight.color = Color.white;
            backlights.SetActive(true);
        }
        else if (Input.GetAxis("Vertical") < 0)
        {
            backRightLight.color = RedLight;
            backLeftLight.color = RedLight;
            backlights.SetActive(true);
        }
        else
        {
            backRightLight.color = RedLight;
            backLeftLight.color = RedLight;
            backlights.SetActive(false);
        }

        // SuspensionEffects
        RaycastHit hit;
        Vector3 wheelPos;
        for (int i = 0; i < 4; i++)
        {
            if (Physics.Raycast(wheels[i].transform.position,-wheels[i].transform.up,out hit,wheels[i].radius + wheels[i].suspensionDistance))
            {
                wheelPos = hit.point + wheels[i].transform.up * wheels[i].radius;
            }
            else
            {
                wheelPos = wheels[i].transform.position - wheels[i].transform.up * wheels[i].suspensionDistance;
            }
            wheelsRotation[i].position = wheelPos;
        }
    }
}
