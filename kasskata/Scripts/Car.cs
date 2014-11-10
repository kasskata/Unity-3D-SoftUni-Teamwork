using UnityEngine;
using System.Collections;

enum TransmisionType
{
    FrontTwoWheels = 2,
    BackTwoWheels = 4,
    Quatro = 4
}

public class Car: MonoBehaviour
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
    private static TransmisionType transmision = TransmisionType.Quatro;
    private int transmisionWheels = (int)transmision;
    private int wheelCounter;
    private float topSpeed = 860f;
    private float rearTopSpeed = -100f;
    private float torgue = 420f;
    private float maxSteer = 15f;
    private float minSteer = 2f;
    private float lowStearSpeed = 15f;
    private float desceleration = 200f;
    private float brakeForce = 700f;
    private float handBrakeForce = 1000f;
    public float currentSpeed;
    public const int Gears = 6;
    private int[] gearRatio;
    private float RPInSecond;
    public int currentGear;
    int gearBetween;

    //Friction
    private float sideway;
    private float forward;
    private float slipSideway;
    private float slipForward;

    // Shukaritets - Backlights(Stop , Reverse)
    private GameObject backlights;
    private Color redLight = Color.red;
    private Color whiteLight = Color.white;
    private Light backLeftLight;
    private Light backRightLight;
    private float skidLimit = 1.5f;
    private float skidEmission = 10f;
    private float timer;
    //Audio
    private AudioSource[] audioSources;
    private GameObject skidingPfb;

    private void ConfigureTransmision()
    {
        //Switch statement if you prefer
        wheelCounter = transmision == TransmisionType.Quatro ? 0 : transmision == TransmisionType.FrontTwoWheels ? 0 : 2;
    }

    private void AccelerateMotor(float value)
    {
        for (int i = wheelCounter; i < transmisionWheels; i++)
        {
            wheels[i].motorTorque = value;
        }
    }

    private void BrakeMotor(float value)
    {
        for (int i = wheelCounter; i < transmisionWheels; i++)
        {
            wheels[i].brakeTorque = value;
        }
    }

    private void SetSlip(float currentForward, float currentSideway)
    {
        for (int i = 2; i < transmisionWheels; i++)
        {
            var curveBackWheels = wheels[i].forwardFriction;
            curveBackWheels.stiffness = currentForward;
            wheels[i].forwardFriction = curveBackWheels;

            curveBackWheels = wheels[i].sidewaysFriction;
            curveBackWheels.stiffness = currentSideway;
            wheels[i].sidewaysFriction = curveBackWheels;

            var curveFrontWheels = wheels[i - 2].forwardFriction;
            curveBackWheels.stiffness = currentForward + (currentForward / 1.3f);
            wheels[i - 2].forwardFriction = curveBackWheels;

            curveBackWheels = wheels[i - 2].sidewaysFriction;
            curveBackWheels.stiffness = currentSideway + (currentSideway / 1.3f);
            wheels[i - 2].sidewaysFriction = curveBackWheels;
        }
    }

    private IEnumerator Countdown(float seconds)
    {
        yield return new WaitForSeconds(seconds);
    }

    private void EngineSound()
    {
        if (currentSpeed == 0)
        {
            audioSources[0].pitch = 1f;
        }
        else
        {
            int i = 1;
            //Here lies sound in shift pause;
            if (gearBetween != currentGear)
            {
                float randomBrakeFireSound = Random.Range(-2f, 2f);
                gearBetween = currentGear;
                audioSources[1].pitch = (randomBrakeFireSound < -1 || randomBrakeFireSound > 1f ? randomBrakeFireSound : 1f);
                audioSources[1].Play();
            }

            for (; i < gearRatio.Length; i++)
            {
                currentGear = i;
                if (gearRatio[i] > RPInSecond)
                {
                    break;
                }
            }
            float gearMin = 0f;
            float gearMax = 0f;
            if (i == 0)
            {
                gearMin = 0f;
                gearMax = gearRatio[i];
            }
            else
            {
                gearMin = gearRatio[i - 1];
                gearMax = gearRatio[i];
            }
            audioSources[0].pitch = Mathf.Abs((RPInSecond / gearMin )*1.5f);
        }
    }

    void Start()
    {
        this.ConfigureTransmision();
        rigidbody.centerOfMass += new Vector3(0, -0.7f, -0.7f);
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

        //Friction
        forward = wheelRR.forwardFriction.stiffness;
        sideway = wheelRR.sidewaysFriction.stiffness;
        slipForward = 0.03f;
        slipSideway = 0.01f;
        //Sounds - GearShift
        gearRatio = new int[Gears + 1] { -2000, 2000, 8000, 16000, 28000, 34000, 42800 };
        audioSources = gameObject.GetComponents<AudioSource>();
        //-Skid
        skidingPfb = new GameObject();
        skidingPfb.AddComponent<AudioSource>();
        skidingPfb.GetComponent<AudioSource>().clip = Resources.Load("Skidding") as AudioClip;
        skidingPfb.GetComponent<AudioSource>().playOnAwake = true;
        skidingPfb.GetComponent<AudioSource>().name = "Skid";
        skidingPfb.GetComponent<AudioSource>().volume = 0.2f;
    }

    void FixedUpdate()
    {
        // Current Speed indicator
        currentSpeed = Mathf.Round(2 * Mathf.PI * wheelRL.radius * wheelRL.rpm * 60 / 100);
        RPInSecond = wheelRL.rpm * 60;
        // Gas
        if (rearTopSpeed <= currentSpeed && currentSpeed <= topSpeed)
        {
            AccelerateMotor(torgue * Input.GetAxis("Vertical"));
        }
        else if (rearTopSpeed >= currentSpeed || currentSpeed >= topSpeed)
        {
            if (currentSpeed < rearTopSpeed)
            {
                if (Input.GetAxis("Vertical") > 0)
                {
                    AccelerateMotor(torgue * Input.GetAxis("Vertical"));
                }
                else
                {
                    AccelerateMotor(0);
                }
            }
            else if (currentSpeed > topSpeed)
            {
                if (Input.GetAxis("Vertical") < 0)
                {
                    AccelerateMotor(torgue * Input.GetAxis("Vertical"));
                }
                else
                {
                    AccelerateMotor(0);
                }
            }
        }
        else
        {
            AccelerateMotor(0);
        }

        // Speed reduce slip. Uncomplete Operation
        float speedFactor = rigidbody.velocity.magnitude / lowStearSpeed;
        float currentSteerAngle = Mathf.Lerp(maxSteer, minSteer, speedFactor);


        currentSteerAngle *= Input.GetAxis("Horizontal");
        if (Input.GetButton("Horizontal"))
        {
            BrakeMotor(80f);
        }

        // Stear
        wheelL.steerAngle = currentSteerAngle;
        wheelR.steerAngle = currentSteerAngle;

        //Deseleration
        if (Input.GetButton("Vertical") == true)
        {
            BrakeMotor(0f);
        }
        else if (Input.GetButton("Vertical") == false && currentSpeed != 0)
        {
            BrakeMotor(desceleration);
        }

        //Brake
        if (Input.GetAxis("Vertical") < 0 && currentSpeed > 0)
        {
            BrakeMotor(brakeForce);
        }

        //HandBrake
        if (Input.GetButton("Jump"))
        {
            wheelRL.brakeTorque = handBrakeForce;
            wheelRL.motorTorque = 0f;
            wheelRR.brakeTorque = handBrakeForce;
            wheelRR.motorTorque = 0f;
            if (rigidbody.velocity.magnitude > 1)
            {
                SetSlip(slipForward, slipSideway);
            }
            else
            {
                SetSlip(0.8f, 0.3f);
            }
        }
        else
        {
            SetSlip(forward, sideway);
        }
    }

    void Update()
    {

        // Rotate on move forward
        wheelLRotation.Rotate(0, -wheelL.rpm / 60 * 360 * Time.deltaTime, 0);
        wheelRRotation.Rotate(0, wheelR.rpm / 60 * 360 * Time.deltaTime, 0);
        wheelRLRotation.Rotate(0, (-wheelRL.rpm / 60 * 360 * Time.deltaTime), 0);
        wheelRRRotation.Rotate(0, (wheelRR.rpm / 60 * 360 * Time.deltaTime), 0);

        if (Input.GetButton("Jump"))
        {
            //TODO: Stop spinining of the rear wheels?!
        }


        // Rotate on steering
        wheelL.transform.localEulerAngles = new Vector3(0, wheelL.steerAngle * 2f, 0);
        wheelR.transform.localEulerAngles = new Vector3(0, wheelL.steerAngle * 2f, 0);


        // Backlights & Reverse effect
        if (currentSpeed < 0)
        {
            backRightLight.color = whiteLight;
            backLeftLight.color = whiteLight;
            backlights.SetActive(true);
        }
        else if (Input.GetAxis("Vertical") < 0 || currentSpeed == 0)
        {
            backRightLight.color = redLight;
            backLeftLight.color = redLight;
            backlights.SetActive(true);
        }
        else
        {
            backRightLight.color = redLight;
            backLeftLight.color = redLight;
            backlights.SetActive(false);
        }

        // SuspensionEffect
        RaycastHit suspensionHit;
        Vector3 wheelPos;
        for (int i = 0; i < 4; i++)
        {
            if (Physics.Raycast(wheels[i].transform.position, -wheels[i].transform.up, out suspensionHit, wheels[i].radius + wheels[i].suspensionDistance))
            {
                wheelPos = suspensionHit.point + wheels[i].transform.up * wheels[i].radius;
            }
            else
            {
                wheelPos = wheels[i].transform.position - wheels[i].transform.up * wheels[i].suspensionDistance;
            }
            wheelsRotation[i].position = wheelPos;
        }
        EngineSound();

        //Skiding
        WheelHit skiddingHit;
        for (int i = wheelCounter; i < transmisionWheels; i++)
        {
            wheels[i].GetGroundHit(out skiddingHit);
            float currentFrictionValue = Mathf.Abs(skiddingHit.sidewaysSlip);
            if (skidLimit <= currentFrictionValue && timer <= 0)
            {
                Destroy(Instantiate(skidingPfb, skiddingHit.point, Quaternion.identity), 1f);
                timer = 1.0f;
            }
            timer -= Time.deltaTime * skidEmission;
        }
    }
}
