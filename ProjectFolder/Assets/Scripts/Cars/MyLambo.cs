using UnityEngine;
using System.Collections;

public class MyLambo : Car
{
    //// ColidersAndJoints
    //protected WheelCollider wheelL;
    //protected WheelCollider wheelR;
    //protected WheelCollider wheelRL;
    //protected WheelCollider wheelRR;
    //protected WheelCollider[] wheels;

    //// GameObjects tires
    //protected Transform wheelLRotation;
    //protected Transform wheelRRotation;
    //protected Transform wheelRLRotation;
    //protected Transform wheelRRRotation;
    //protected Transform[] wheelsRotation;

    //// Constraints
    //protected static TransmisionType transmision = TransmisionType.Quatro;
    //protected int transmisionWheels = (int)transmision;
    //protected int wheelCounter;
    //protected float topSpeed = 1000f;
    //protected float rearTopSpeed = -100f;
    //protected float torgue = 640f;
    //protected float maxSteer = 15f;
    //protected float minSteer = 1f;
    //protected float lowStearSpeed = 15f;
    //protected float desceleration = 400f;
    //protected float brakeForce = 550f;
    //protected float handBrakeForce = 2000f;
    //public float currentSpeed;
    //public const int Gears = 6;
    //protected int[] gearRatio;
    //protected float rPInSecond;
    //public int currentGear;
    //int gearBetween;

    //// Friction
    //protected float sideway;
    //protected float forward;
    //protected float slipSideway;
    //protected float slipForward;

    //// NOS
    //protected bool hasNOSSystem = true;
    //protected bool isEmptyBottles = false;
    //protected float nitroTopSpeed;
    //protected float nitroTorgue;
    //protected float usualTopSpeed;
    //protected float usualTorgue;
    //protected float nitroTopSpeedFactor;
    //protected float nitroTorgueFactor;
    //protected GameObject nitroPfb;
    //protected float NOSBottle = 10f;

    //// Shukaritets - Lights(Stop , Reverse)
    //protected GameObject backLights;
    //protected GameObject frontLights;
    //protected bool isLightsOn;
    //protected Color redLight = Color.red;
    //protected Color whiteLight = Color.white;
    //protected Light backLeftLight;
    //protected Light backRightLight;

    ////Skid
    //protected float skidLimit = 1.5f;
    //protected float skidEmission = 5f;
    //protected float timer;

    ////Audio
    //protected AudioSource[] audioSources;
    //protected GameObject skidingPfb;
    //protected GameObject[] skiddingTracks = new GameObject[4];
    //protected GameObject[] skidingSmokes = new GameObject[4];

    //protected void ConfigureTransmision()
    //{
    //    //Switch statement if you prefer
    //    wheelCounter = transmision == TransmisionType.Quatro ? 0 : transmision == TransmisionType.FrontTwoWheels ? 0 : 2;
    //}

    //protected void AccelerateMotor(float value)
    //{
    //    for (int i = wheelCounter; i < transmisionWheels; i++)
    //    {
    //        wheels[i].motorTorque = value;
    //    }
    //}

    //protected void BrakeMotor(float value)
    //{
    //    for (int i = wheelCounter; i < transmisionWheels; i++)
    //    {
    //        wheels[i].brakeTorque = value;
    //    }
    //}

    //protected void SetSlip(float currentForward, float currentSideway)
    //{
    //    for (int i = 2; i < transmisionWheels; i++)
    //    {
    //        var curveBackWheels = wheels[i].forwardFriction;
    //        curveBackWheels.stiffness = currentForward;
    //        wheels[i].forwardFriction = curveBackWheels;

    //        curveBackWheels = wheels[i].sidewaysFriction;
    //        curveBackWheels.stiffness = currentSideway;
    //        wheels[i].sidewaysFriction = curveBackWheels;

    //        var curveFrontWheels = wheels[i - 2].forwardFriction;
    //        curveBackWheels.stiffness = currentForward + (currentForward);
    //        wheels[i - 2].forwardFriction = curveBackWheels;

    //        curveBackWheels = wheels[i - 2].sidewaysFriction;
    //        curveBackWheels.stiffness = currentSideway + (currentSideway);
    //        wheels[i - 2].sidewaysFriction = curveBackWheels;
    //    }
    //}

    //protected IEnumerator Countdown(float seconds)
    //{
    //    yield return new WaitForSeconds(seconds);
    //}

    //protected void EngineSound()
    //{
    //    if (currentSpeed == 0)
    //    {
    //        audioSources[0].pitch = 1f;
    //    }
    //    else
    //    {
    //        int i = 1;
    //        // Shift pause Sounds;
    //        if (gearBetween != currentGear)
    //        {
    //            float randomBаckFireSound = Random.Range(-2f, -1f);
    //            gearBetween = currentGear;
    //            audioSources[1].pitch = (randomBаckFireSound < -1 || randomBаckFireSound > 1f ? randomBаckFireSound : 1f);
    //            audioSources[1].Play();
    //        }

    //        for (; i < gearRatio.Length; i++)
    //        {
    //            currentGear = i;
    //            if (gearRatio[i] > rPInSecond)
    //            {
    //                break;
    //            }
    //        }
    //        float gearMin = 0f;
    //        float gearMax = 0f;
    //        if (i == 0)
    //        {
    //            gearMin = 0f;
    //            gearMax = gearRatio[i];
    //        }
    //        else
    //        {
    //            gearMin = gearRatio[i - 1];
    //            gearMax = gearRatio[i];
    //        }
    //        audioSources[0].pitch = Mathf.Abs((rPInSecond / gearMin) * 1.5f);
    //    }
    //}

    //void Start()
    //{
    //    this.ConfigureTransmision();
    //    //rigidbody.centerOfMass += new Vector3(0, -0.2f, -0.2f);
    //    wheelL = GameObject.Find("ColliderFL").GetComponent<WheelCollider>() as WheelCollider;
    //    wheelR = GameObject.Find("ColliderFR").GetComponent<WheelCollider>() as WheelCollider;
    //    wheelRL = GameObject.Find("ColliderRL").GetComponent<WheelCollider>() as WheelCollider;
    //    wheelRR = GameObject.Find("ColliderRR").GetComponent<WheelCollider>() as WheelCollider;
    //    wheels = new WheelCollider[] { wheelL, wheelR, wheelRL, wheelRR };

    //    wheelLRotation = wheelL.transform.GetChild(0).transform.GetChild(0);
    //    wheelRRotation = wheelR.transform.GetChild(0).transform.GetChild(0);
    //    wheelRLRotation = wheelRL.transform.GetChild(0);
    //    wheelRRRotation = wheelRR.transform.GetChild(0);
    //    wheelsRotation = new Transform[] { wheelLRotation, wheelRRotation, wheelRLRotation, wheelRRRotation };

    //    backLights = GameObject.Find("BackLights");
    //    frontLights = GameObject.Find("FrontLights");
    //    frontLights.SetActive(false);
    //    backLeftLight = backLights.transform.GetChild(0).GetComponent<Light>();
    //    backRightLight = backLights.transform.GetChild(1).GetComponent<Light>();

    //    //Friction
    //    forward = wheelRR.forwardFriction.stiffness;
    //    sideway = wheelRR.sidewaysFriction.stiffness;
    //    slipForward = 0.08f;
    //    slipSideway = 0.03f;

    //    // NOS
    //    if (hasNOSSystem == true)
    //    {
    //        nitroTopSpeedFactor = 2f;
    //        nitroTorgueFactor = 3f;
    //        nitroTorgue = topSpeed * nitroTopSpeedFactor;
    //        nitroTopSpeed = torgue * nitroTorgueFactor;
    //        usualTopSpeed = topSpeed;
    //        usualTorgue = torgue;
    //        nitroPfb = Instantiate(Resources.Load("BackFireParticles")) as GameObject;
    //        nitroPfb.transform.parent = GameObject.Find("MURCIELAGO640").transform;
    //        nitroPfb.transform.localPosition = new Vector3(-0.005f, 0.31f, -2.09f);
    //        nitroPfb.particleEmitter.emit = false;
    //    }

    //    //Sounds - GearShift
    //    gearRatio = new int[Gears + 1] { -2000, 2000, 8000, 16000, 28000, 34000, 42800 };
    //    audioSources = gameObject.GetComponents<AudioSource>();
    //    //-Skid
    //    skidingPfb = new GameObject("SkidSound");
    //    skidingPfb.AddComponent<AudioSource>();
    //    skidingPfb.GetComponent<AudioSource>().clip = Resources.Load("Skidding") as AudioClip;
    //    skidingPfb.GetComponent<AudioSource>().playOnAwake = true;
    //    skidingPfb.GetComponent<AudioSource>().volume = 0.03f;
    //    TrailRenderer trail;
    //    for (int i = 0; i < 4; i++)
    //    {
    //        skiddingTracks[i] = new GameObject(string.Format("SkidingTrail-{0}", i));
    //        skiddingTracks[i].transform.parent = wheels[i].transform;
    //        float skidPositionX = i % 2 == 0 ? 0.12f : -0.12f;
    //        skiddingTracks[i].transform.localPosition = new Vector3(skidPositionX, -0.3f, -0.035f);
    //        trail = skiddingTracks[i].AddComponent<TrailRenderer>();
    //        trail.material = Resources.Load("Skidmarks") as Material;
    //        trail.time = 10f;
    //        trail.startWidth = 0.2f;
    //        trail.endWidth = 0.2f;

    //        skidingSmokes[i] = Instantiate(Resources.Load("SkiddSmoke")) as GameObject;
    //        skidingSmokes[i].transform.parent = wheels[i].transform;
    //        float skidSmokePositionX = i % 2 == 0 ? 0.12f : -0.12f;
    //        skidingSmokes[i].transform.localPosition = new Vector3(skidSmokePositionX, -0.3f, -0.035f);
    //        skidingSmokes[i].particleEmitter.emit = false;


    //    }
    //}

    //void FixedUpdate()
    //{
    //    // Current Speed indicator
    //    currentSpeed = Mathf.Round(2 * Mathf.PI * wheelRL.radius * wheelRL.rpm * 60 / 100);
    //    rPInSecond = wheelRL.rpm * 60;

    //    // Gas
    //    float speedFactor = rigidbody.velocity.magnitude / lowStearSpeed;
    //    float currentSteerAngle;
    //    if (rearTopSpeed <= currentSpeed && currentSpeed <= topSpeed)
    //    {
    //        AccelerateMotor(torgue * Input.GetAxis("Vertical"));
    //    }
    //    else if (rearTopSpeed > currentSpeed || currentSpeed > topSpeed)
    //    {
    //        if (currentSpeed < rearTopSpeed)
    //        {
    //            if (Input.GetAxis("Vertical") > 0)
    //            {
    //                AccelerateMotor(torgue * Input.GetAxis("Vertical"));
    //            }
    //            else
    //            {
    //                AccelerateMotor(0);
    //            }
    //        }
    //        else if (currentSpeed > topSpeed)
    //        {
    //            if (Input.GetAxis("Vertical") < 0)
    //            {
    //                AccelerateMotor(torgue * Input.GetAxis("Vertical"));
    //            }
    //            else
    //            {
    //                AccelerateMotor(0);
    //            }
    //        }
    //    }

    //    //NOS
    //    if (Input.GetKey("left shift") == true && hasNOSSystem == true && isEmptyBottles == false)
    //    {
    //        topSpeed = nitroTopSpeed;
    //        torgue = nitroTorgue;
    //        NOSBottle -= Time.fixedDeltaTime;
    //        if (NOSBottle <= 0)
    //        {
    //            isEmptyBottles = true;
    //        }
    //    }
    //    else
    //    {
    //        topSpeed = usualTopSpeed;
    //        torgue = usualTorgue;
    //    }


    //    if (Input.GetAxis("Vertical") > 0 && Input.GetButton("Jump") == false)
    //    {
    //        // Speed reduce slip. Uncomplete Operation
    //        currentSteerAngle = Mathf.Lerp(maxSteer, minSteer, speedFactor);
    //        currentSteerAngle *= Input.GetAxis("Horizontal");

    //        if (Input.GetButton("Horizontal"))
    //        {
    //            BrakeMotor(80f);
    //        }

    //        // Stear
    //        wheelL.steerAngle = currentSteerAngle;
    //        wheelR.steerAngle = currentSteerAngle;
    //    }

    //    //Deseleration
    //    if (Input.GetButton("Vertical") == true && currentSpeed < topSpeed)
    //    {
    //        BrakeMotor(0f);
    //    }
    //    else if ((Input.GetButton("Vertical") == false && Input.GetButton("Jump") == false) || currentSpeed > topSpeed)
    //    {
    //        BrakeMotor(desceleration);
    //    }

    //    //Brake
    //    if (Input.GetAxis("Vertical") < 0 && currentSpeed > 0)
    //    {
    //        BrakeMotor(brakeForce);
    //    }

    //    //HandBrake
    //    if (Input.GetButton("Jump"))
    //    {
    //        wheelRL.brakeTorque = handBrakeForce;
    //        wheelRL.motorTorque = 0f;
    //        wheelRR.brakeTorque = handBrakeForce;
    //        wheelRR.motorTorque = 0f;

    //        if (rigidbody.velocity.magnitude > 1)
    //        {
    //            SetSlip(slipForward, slipSideway);
    //        }

    //    }
    //    else
    //    {
    //        var slipSmoothForward = Mathf.Lerp(slipForward, forward, 0.2f);
    //        var slipSmoothSideway = Mathf.Lerp(slipSideway, sideway, 0.2f);
    //        SetSlip(slipSmoothForward, slipSmoothSideway);
    //    }
    //}

    //void Update()
    //{

    //    // Rotating wheels

    //    wheelLRotation.Rotate(0, -wheelL.rpm / 60 * 360 * Time.deltaTime, 0);
    //    wheelRRotation.Rotate(0, wheelR.rpm / 60 * 360 * Time.deltaTime, 0);
    //    wheelRLRotation.Rotate(0, (-wheelRL.rpm / 60 * 360 * Time.deltaTime), 0);
    //    wheelRRRotation.Rotate(0, (wheelRR.rpm / 60 * 360 * Time.deltaTime), 0);

    //    if (Input.GetButton("Jump"))
    //    {
    //        //TODO: Stop spinining of the rear wheels?!
    //    }


    //    // Rotate on steering
    //    wheelL.transform.localEulerAngles = new Vector3(0, wheelL.steerAngle * 2f, 0);
    //    wheelR.transform.localEulerAngles = new Vector3(0, wheelL.steerAngle * 2f, 0);

    //    //FrontLights 
    //    if (Input.GetKeyDown(KeyCode.R))
    //    {
    //        if (isLightsOn == true)
    //        {
    //            isLightsOn = false;
    //            frontLights.SetActive(true);
    //        }
    //        else
    //        {
    //            isLightsOn = true;
    //            frontLights.SetActive(false);
    //        }
    //    }
    //    // Backlights & Reverse effect
    //    if (currentSpeed < 0)
    //    {
    //        backRightLight.color = whiteLight;
    //        backLeftLight.color = whiteLight;
    //        backLights.SetActive(true);
    //    }
    //    else if (Input.GetAxis("Vertical") < 0 || currentSpeed == 0)
    //    {
    //        backRightLight.color = redLight;
    //        backLeftLight.color = redLight;
    //        backLights.SetActive(true);
    //    }
    //    else
    //    {
    //        backRightLight.color = redLight;
    //        backLeftLight.color = redLight;
    //        backLights.SetActive(false);
    //    }

    //    //NOS Light
    //    if (Input.GetKey("left shift") == true && hasNOSSystem == true && isEmptyBottles == false)
    //    {
    //        nitroPfb.particleEmitter.emit = true;
    //    }
    //    else
    //    {
    //        nitroPfb.particleEmitter.emit = false;
    //    }

    //    // SuspensionEffect
    //    RaycastHit suspensionHit;
    //    Vector3 wheelPos;
    //    for (int i = 0; i < 4; i++)
    //    {
    //        if (Physics.Raycast(wheels[i].transform.position, -wheels[i].transform.up, out suspensionHit, wheels[i].radius + wheels[i].suspensionDistance))
    //        {
    //            wheelPos = suspensionHit.point + wheels[i].transform.up * wheels[i].radius;
    //        }
    //        else
    //        {
    //            wheelPos = wheels[i].transform.position - wheels[i].transform.up * wheels[i].suspensionDistance;
    //        }
    //        wheelsRotation[i].position = wheelPos;
    //    }
    //    EngineSound();

    //    //Skiding sound
    //    WheelHit wheelGrounded;
    //    for (int i = 0; i < 4; i++)
    //    {
    //        wheels[i].GetGroundHit(out wheelGrounded);
    //        float currentFrictionValue = Mathf.Abs(wheelGrounded.sidewaysSlip);

    //        if (skidLimit < currentFrictionValue && timer <= 0)
    //        {

    //            skiddingTracks[i].transform.parent = wheels[i].transform;
    //            float skidPositionX = i % 2 == 0 ? 0.12f : -0.12f;
    //            skiddingTracks[i].transform.localPosition = new Vector3(skidPositionX, -0.3f, -0.035f);
    //            Destroy(Instantiate(skidingPfb, wheelGrounded.point, Quaternion.identity), 1f);
    //            timer = 1.0f;
    //            skidingSmokes[i].particleEmitter.emit = true;


    //        }
    //        else if (skidLimit > currentFrictionValue)
    //        {
    //            for (int w = 0; w < wheels.Length; w++)
    //            {
    //                skiddingTracks[w].transform.parent = null;
    //                skidingSmokes[w].particleEmitter.emit = false;
    //            }
    //        }

    //        timer -= Time.deltaTime * skidEmission;
    //    }
    //}

    //public MyLambo(float topSpeed, float torgue, float maxSteаr, float minSteаr, float brakeForce, int gears, TransmisionType transmision = TransmisionType.Quatro, params int[] gearRatio)
    //    : base(360, 650, 15, 2, 700, 6, TransmisionType.Quatro, new int[] { 8000, 16000, 24000, 32000, 40000, 48000 })
    //{

    //}

    public override void Start()
    {
        //Car Example
        this.IDCar = "MURCIELAGO640";
        this.TopSpeed = 360f;
        this.Torgue = 650f;
        this.MaxStear = 20f;
        this.MinStear = 0.3f;
        this.BrakeForce = 1200f;
        this.Gears = 6;
        this.Transmision = TransmisionType.Quatro;
        this.GearRatio = new int[] { 430, 860, 1290, 1720, 2100, 2600 };

        //nitro Example
    
        this.NitroTopSpeedFactor = 1.3f;
        this.NitroTorgueFactor = 1.5f;
        this.NOSBottleTime = 20;
        this.HasNOSSystem = true;  

        base.Start();
    }
}
