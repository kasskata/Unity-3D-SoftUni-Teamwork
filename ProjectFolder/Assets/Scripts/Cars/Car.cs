using UnityEngine;
using System;
using System.Collections;

public abstract class Car : MonoBehaviour
{
    private string iDCar;

    // ColidersAndJoints
    protected WheelCollider wheelL;
    protected WheelCollider wheelR;
    protected WheelCollider wheelRL;
    protected WheelCollider wheelRR;
    protected WheelCollider[] wheels;

    // GameObjects tires
    protected Transform wheelLRotation;
    protected Transform wheelRRotation;
    protected Transform wheelRLRotation;
    protected Transform wheelRRRotation;
    protected Transform[] wheelsRotation;

    // Constraints
    private TransmisionType transmision; // Change
    private int transmisionWheels; // Change = (int)transmision;
    private int wheelCounter;
    private float topSpeed;// Change = 1200f;
    private const float RearTopSpeed = -100f;
    private float torgue;// Change = 860f;
    private float maxSteаr;// Change = 15f;
    private float minSteаr;// Change = 1f;
    private float lowStearSpeed;
    private const float Desceleration = 400f;
    private float brakeForce;//Change = 550f;
    private const float HandBrakeForce = 5000f;
    public float currentSpeed;
    private int gears;// Change = 6;
    private int[] gearRatio;// Change;
    private float rPInSecond;
    private int currentGear;
    private int gearBefore;

    // Friction
    private float sideway;
    private float forward;
    private float slipSideway;
    private float slipForward;

    // NOS
    private bool hasNOSSystem = false;// Change = true;
    private bool isEmptyBottles = false;// Change = false;
    private float nitroTopSpeed;
    private float nitroTorgue;
    private float usualTopSpeed;
    private float usualTorgue;
    private float nitroTopSpeedFactor;
    private float nitroTorgueFactor;
    protected GameObject nitroPfb;
    protected GameObject cloneNitroPfb;
    private float nOSBottleTime;// Change = 10f;

    // Shukaritets - Lights(Stop , Reverse)
    private GameObject backLights;
    private GameObject frontLights;
    private bool isLightsOn;
    private Color redLight = Color.red;
    private Color whiteLight = Color.white;
    private Light backLeftLight;
    private Light backRightLight;

    //Skid
    private float skidLimit = 1f;
    private float skidEmission = 5f;
    private float timer;

    //Audio
    private AudioSource[] audioSources;
    private GameObject skidingPfb;
    private GameObject[] skiddingTracks = new GameObject[4];
    private GameObject[] skidingSmokes = new GameObject[4];
    private float sleep = 0;

    private bool isPlayer;

    /// <summary>
    /// Create new Car from factory without parameters. When create that car expect to add manually ALL 14 parameters from properties.
    /// </summary>
    public Car()
    {

    }

    /// <summary>
    /// Create new Car from factory with specified engine, transmision, handling.
    /// </summary>
    /// <param name="transmision">Transmision type of your car by real-world car catalog</param>
    /// <param name="topSpeed">Top speed from engine power. Units: Km/h</param>
    /// <param name="torgue">Torgue from engine power. Units: PS</param>
    /// <param name="maxSteаr">Handling of the car on usual speed (40% - 50% from base Top speed). Units: float angle</param>
    /// <param name="minSteаr">Handling of the car on high speed (50% - 100% from base Top speed). Units: float angle. Must be lower than MaxStear</param>
    /// <param name="brakeForce">The brake forse when use presure from brake callippers of the car on the transmision base wheels.</param>
    /// <param name="gears">Value holds gearbox shifts</param>
    /// <param name="gearRatio">Array hold values from where to where is all gears. Units: Revolutions Per Seconds. 1st gear hold first gear, second hold (first + second) ratio of the engine.</param>
    public Car(float topSpeed, float torgue, float maxSteаr, float minSteаr, float brakeForce, int gears, TransmisionType transmision = TransmisionType.Quatro, params int[] gearRatio)
    {
        this.Transmision = transmision;
        this.TopSpeed = topSpeed;
        this.Torgue = torgue;
        this.MaxStear = maxSteаr;
        this.MinStear = minSteаr;
        this.BrakeForce = brakeForce;
        this.Gears = gears;
        this.GearRatio = new int[this.Gears];
        this.GearRatio = gearRatio;
        this.HasNOSSystem = false;
    }
    /// <summary>
    /// Create object NOS to your car
    /// </summary>
    /// <param name="nitroTopSpeed">Top speed with nitro</param>
    /// <param name="nitroTorgue">Torgue with nitro</param>
    /// <param name="nitroTopSpeedFactor"></param>
    /// <param name="NitroTorgueFactor"></param>
    /// <param name="NOSBottleTime"></param>
    public Car(float nitroTopSpeed, float nitroTorgue, float nitroTopSpeedFactor, float nitroTorgueFactor, float nOSBottleTime)
    {
        this.NitroTopSpeed = nitroTopSpeed;
        this.NitroTorgue = nitroTorgue;
        this.NitroTopSpeedFactor = nitroTopSpeedFactor;
        this.NitroTorgueFactor = nitroTorgueFactor;
        this.NOSBottleTime = nOSBottleTime;
        this.HasNOSSystem = true;
        isEmptyBottles = false;
    }

    public string IDCar
    {
        get
        {
            return iDCar;
        }
        set
        {

            iDCar = value;
        }
    }

    /// <summary>
    /// Type Constraint: Engine
    /// Top speed of that car you created. Must be real from Car catalog.
    /// </summary>
    public float TopSpeed
    {
        get
        {
            return this.topSpeed;
        }
        set
        {
            if (value < 10 || value > 5000)
            {
                throw new ArgumentException(string.Format("{0} value entered is {1}. Must be in range[10...1000]", "Top Speed", value));
            }
            this.topSpeed = value;
        }
    }
    /// <summary>
    /// Type Constraint: Engine
    /// Torgue of that car you created. Must be real from Car catalog. Units: NM
    /// </summary>
    public float Torgue
    {
        get
        {
            return this.torgue;
        }
        set
        {
            if (value < 10 || value > 6000)
            {
                throw new ArgumentException(string.Format("{0} value entered is {1}. Must be in range[10...1000]", "Torgue", value));
            }
            this.torgue = value;
        }
    }
    /// <summary>
    /// Type Constraint: Handling
    /// Top speed of that car you created. Must be real from Car catalog.
    /// </summary>
    public float MaxStear
    {
        get
        {
            return this.maxSteаr;
        }
        set
        {
            if (value < 5 || value > 25)
            {
                throw new ArgumentException(string.Format("{0} value entered is {1}. Must be in range[10...1000], because the car will be unstable in stearing", "Max Stear", value));
            }
            this.maxSteаr = value;
        }
    }
    /// <summary>
    /// Type Constraint: Handling
    /// Min stear of that car you created. Must be 1 to giotore. When acelerate the car that parameter is minimum stear angle of the car.
    /// </summary>
    public float MinStear
    {
        get
        {
            return this.minSteаr;
        }
        set
        {
            if (value < 0.1f || value > this.MaxStear)
            {
                throw new ArgumentException(string.Format("{0} value entered is {1}. Must be in range[1...{2}], because {0} is useless when is negative OR is bigger than {2}", "Min Stear", value, this.MaxStear));
            }
            this.minSteаr = value;
        }
    }
    /// <summary>
    /// Type Constraint: Brake-Handling
    /// Brake forse of that car you created. This forse is use to brake your speed.
    /// </summary>
    public float BrakeForce
    {
        get
        {
            return this.brakeForce;
        }
        set
        {
            if (value < this.Torgue || value > this.Torgue * 3)
            {
                throw new ArgumentException(string.Format("{0} value entered is {1}. Must be in range[{2}...{3}](the torgue of your car and the torgue*3) or will be useless or too hard brake", "Torgue", value, this.Torgue, this.Torgue * 3));
            }
            this.brakeForce = value;
        }
    }
    /// <summary>
    /// Type Constraint: Display HUD
    /// Display your current speed at the moment by formula. Read-only
    /// </summary>
    public float CurrentSpeed
    {
        get
        {
            return this.currentSpeed;
        }
        private set
        {
            this.currentSpeed = value;
        }
    }
    /// <summary>
    /// Type Constraint: Display HUD
    /// Display your current Revolution Per Seconds. Read-only
    /// </summary>
    public float RPInSecond
    {
        get
        {
            return this.rPInSecond;
        }
        private set
        {
            this.rPInSecond = value;
        }
    }
    /// <summary>
    /// Type Constraint: Transmision
    /// Set Transmision of your car. Values is Quattro, Front & Back Wheels Driving. Back wheel drive by default.
    /// </summary>
    public TransmisionType Transmision
    {
        get
        {
            return this.transmision;
        }
        set
        {
            this.transmision = value;
        }
    }
    /// <summary>
    /// Type Constraint: Transmision
    /// Set Gears on your cars. Look car catalogue value. Can set another value if u want to brake it dynamically
    /// </summary>
    public int Gears
    {
        get
        {
            return this.gears;
        }
        set
        {
            this.gears = value;
        }
    }
    /// <summary>
    /// Type Constraint: Transmision
    /// Set Gear Ratio between the gears. Look car catalogue values. Can set another value if u want to change it dynamically
    /// </summary>
    public int[] GearRatio
    {
        get
        {
            return this.gearRatio;
        }
        set
        {
            this.gearRatio = value;
        }
    }
    /// <summary>
    /// Type Constraint: Nitro Oxide Boost
    /// Specify the weather when the car has NOS system instaled on the car. This value will be FALSE by default. When tune the car has NOS change it to TRUE, and specify other 3 values (NitroTopSpeed, NitroTorgue, NOSBottleTime)
    /// </summary>
    public bool HasNOSSystem
    {
        get
        {
            return this.hasNOSSystem;
        }
        set
        {
            this.hasNOSSystem = value;
        }
    }
    /// <summary>
    /// Type Constraint: Nitro Oxide Boost
    /// Tune Top Speed value on switching Nitro boost. Look nitro catalogue values. This value will be the top speed on nitro, when the nitro stop or ended the value will be normalized. 
    /// </summary>
    public float NitroTopSpeed
    {
        get
        {
            return this.nitroTopSpeed;
        }
        set
        {
            this.nitroTopSpeed = value;
        }
    }
    /// <summary>
    /// Type Constraint: Nitro Oxide Boost
    /// Tune torgue on switching Nitro boost. Look nitro catalogue values. This value will be the torgue on nitro, when the nitro stop or ended the value will be normalized.
    /// </summary>
    public float NitroTorgue
    {
        get
        {
            return this.nitroTorgue;
        }
        set
        {
            this.nitroTorgue = value;
        }
    }
    /// <summary>
    /// What is the Nitro factor in float will multiply whit normal top speed. Need it for different level of nitro for unlock.
    /// E.g. When nitro factor of top speed  is 12.32f => 12.32 * this.TopSpeed.
    /// </summary>
    public float NitroTopSpeedFactor { get; set; }
    /// <summary>
    /// What is the Nitro factor in float will multiply whit normal Torgue. Need it for different level of nitro for unlock.
    /// E.g. When factor of nitro torgue is 12.32f => 12.32 * this.Torgue.
    /// </summary>
    public float NitroTorgueFactor { get; set; }

    /// <summary>
    /// Type Constraint: Nitro Oxide Boost
    /// Tune the capacity of the bottles NOS mesured in time(float) when you have instaled in the game. When use NOS system in the game this value will reduce time like seconds. When is ZERO can't fill it again real-life NOS system like.
    /// </summary>
    public float NOSBottleTime { get; set; }

    public bool IsPlayer
    {
        get { return this.isPlayer; }
        set { this.isPlayer = value; }
    }

    /// <summary>
    /// Takes value from transmision property and automate configure wheel counter variable need for "for" loop for transmision count.
    /// </summary>
    public void ConfigureTransmision()
    {
        //Switch statement form if you prefer
        wheelCounter = this.Transmision == TransmisionType.Quatro ? 0 : this.Transmision == TransmisionType.FrontTwoWheels ? 0 : 2;
    }

    /// <summary>
    /// Accelerate all wheels witch specify from transmission Type.
    /// </summary>
    /// <param name="value">Represent the accelerate power from engine. Units: PS</param>
    public void AccelerateMotor(float value)
    {
        for (int i = wheelCounter; i < transmisionWheels; i++)
        {

            wheels[i].motorTorque = value;
        }
    }

    /// <summary>
    /// Brake forse all wheels witch specify from transmission Type.
    /// </summary>
    /// <param name="value">Represent the brake power from engine. Units: PS</param>
    public void BrakeMotor(float value)
    {
        for (int i = wheelCounter; i < transmisionWheels; i++)
        {
            wheels[i].brakeTorque = value;
        }
    }

    /// <summary>
    /// Set new values for wheels friction for front and rear axes of the car.CAN'T modify the wheels friction one by one with that method.
    /// Expressed in Meters per Second (M/s). It's the relative speed between the wheel's contact point and the colliding surface.
    /// </summary>
    /// <param name="currentForward">Forward friction of the car you want in new frame</param>
    /// <param name="currentSideway">Sideway friction of the car you want in new frame</param>
    public void SetSlip(float currentForward, float currentSideway)
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
            curveBackWheels.stiffness = currentForward;
            wheels[i - 2].forwardFriction = curveBackWheels;

            curveBackWheels = wheels[i - 2].sidewaysFriction;
            curveBackWheels.stiffness = currentSideway;
            wheels[i - 2].sidewaysFriction = curveBackWheels;
        }
    }

    /// <summary>
    /// Countdown timer. Use "StartCoroutine(Countdown(float value))" method template.
    /// </summary>
    /// <param name="seconds">How many second want wait. Units: seconds</param>
    /// <returns></returns>
    public IEnumerator Countdown(float seconds)
    {
        yield return new WaitForSeconds(seconds);
    }

    /// <summary>
    /// Play sounds from engine roaring, backfiring, turbo agregates, etc.
    /// </summary>
    public void EngineSound()
    {
        if (currentSpeed == 0)
        {
            sleep += Time.deltaTime;
            if (sleep <= 5f)
            {
                audioSources[0].pitch = 0.5f;
            }
            else
            {
                audioSources[0].pitch = 0f;
            }
        }
        else
        {
            sleep = 0;
            int i = 1;
            // Shift pause Sounds;
            if (gearBefore != currentGear)
            {
                gearBefore = currentGear;
                audioSources[1].Play();
            }

            for (; i < this.GearRatio.Length; i++)
            {
                currentGear = i;
                if (this.GearRatio[i] > this.RPInSecond)
                {
                    break;
                }
            }
            float gearMin = 0f;
            float gearMax = 0f;
            if (i == 0)
            {
                gearMin = 0f;
                gearMax = this.GearRatio[i];
            }
            else
            {
                gearMin = this.GearRatio[i - 1];
                gearMax = this.GearRatio[i];
            }
            audioSources[0].pitch = Mathf.Abs((this.RPInSecond / gearMin) * 1.5f);
        }
    }

    /// <summary>
    /// RotateWheels Vissually
    /// </summary>
    public virtual void VisualRotateWheels()
    {
        // Rotating wheels

        wheelLRotation.Rotate(0, -wheelL.rpm / 60 * 360 * Time.deltaTime, 0);
        wheelRRotation.Rotate(0, wheelR.rpm / 60 * 360 * Time.deltaTime, 0);
        wheelRLRotation.Rotate(0, (-wheelRL.rpm / 60 * 360 * Time.deltaTime), 0);
        wheelRRRotation.Rotate(0, (wheelRR.rpm / 60 * 360 * Time.deltaTime), 0);
    }

    /// <summary>
    /// Initilize all prefabs and values before game start render
    /// </summary>
    public virtual void Start()
    {
        transmisionWheels = (int)this.Transmision;
        this.ConfigureTransmision();
        lowStearSpeed = this.MaxStear;
        rigidbody.centerOfMass += new Vector3(0, -0.7f, 0);
        wheelL = this.gameObject.transform.Find("ColliderFL").GetComponent<WheelCollider>() as WheelCollider;
        wheelR = this.gameObject.transform.Find("ColliderFR").GetComponent<WheelCollider>() as WheelCollider;
        wheelRL = this.gameObject.transform.Find("ColliderRL").GetComponent<WheelCollider>() as WheelCollider;
        wheelRR = this.gameObject.transform.Find("ColliderRR").GetComponent<WheelCollider>() as WheelCollider;

        wheels = new WheelCollider[] { wheelL, wheelR, wheelRL, wheelRR };

        wheelLRotation = wheelL.transform.GetChild(0).transform.GetChild(0);
        wheelRRotation = wheelR.transform.GetChild(0).transform.GetChild(0);
        wheelRLRotation = wheelRL.transform.GetChild(0);
        wheelRRRotation = wheelRR.transform.GetChild(0);
        wheelsRotation = new Transform[] { wheelLRotation, wheelRRotation, wheelRLRotation, wheelRRRotation };

        backLights = this.gameObject.transform.Find("BackLights").gameObject;
        frontLights = this.gameObject.transform.Find("FrontLights").gameObject;
        frontLights.SetActive(false);
        backLeftLight = backLights.transform.GetChild(0).GetComponent<Light>();
        backRightLight = backLights.transform.GetChild(1).GetComponent<Light>();

        //Friction
        forward = wheelRR.forwardFriction.stiffness;
        sideway = wheelRR.sidewaysFriction.stiffness;
        slipForward = 0.5f;
        slipSideway = 0.3f;

        // NOS
        usualTopSpeed = this.TopSpeed;
        usualTorgue = this.Torgue;
        BackFireNitro();

        //Sounds - GearShift
        audioSources = gameObject.GetComponents<AudioSource>();
        //-Skid
        skidingPfb = new GameObject("SkidSound");
        skidingPfb.AddComponent<AudioSource>();
        skidingPfb.GetComponent<AudioSource>().clip = Resources.Load("Skidding") as AudioClip;
        skidingPfb.GetComponent<AudioSource>().playOnAwake = true;
        skidingPfb.GetComponent<AudioSource>().volume = 0.1f;
        TrailRenderer trail;

        for (int i = 0; i < 4; i++)
        {
            skiddingTracks[i] = new GameObject(string.Format("SkidingTrail-{0}", i));
            skiddingTracks[i].transform.parent = wheels[i].transform;
            float skidPositionX = i % 2 == 0 ? 0.12f : -0.12f;
            skiddingTracks[i].transform.localPosition = new Vector3(skidPositionX, -0.3f, -0.035f);
            trail = skiddingTracks[i].AddComponent<TrailRenderer>();
            trail.material = Resources.Load("Skidmarks") as Material;
            trail.time = 10f;
            trail.startWidth = 0.2f;
            trail.endWidth = 0.2f;

            skidingSmokes[i] = Instantiate(Resources.Load("SkiddSmoke")) as GameObject;
            skidingSmokes[i].transform.parent = wheels[i].transform;
            float skidSmokePositionX = i % 2 == 0 ? 0.12f : -0.12f;
            skidingSmokes[i].transform.localPosition = new Vector3(skidSmokePositionX, -0.3f, -0.035f);
            skidingSmokes[i].particleEmitter.emit = false;


        }
    }

    protected virtual void BackFireNitro()
    {
        if (this.HasNOSSystem == true)
        {
            this.isEmptyBottles = false;
            this.NitroTopSpeed = this.TopSpeed * this.NitroTopSpeedFactor;
            this.NitroTorgue = this.Torgue * this.NitroTorgueFactor;
            nitroPfb = Instantiate(Resources.Load("BackFireParticles")) as GameObject;
            if (this.IsPlayer)
            {
                nitroPfb.transform.parent = GameObject.Find(this.IDCar).transform;
            }
            else
            {
                nitroPfb.transform.parent = GameObject.Find(this.IDCar).transform;
            }

            nitroPfb.transform.localPosition = new Vector3(-0.005f, 0f, -2.09f);
            nitroPfb.transform.localRotation = new Quaternion(0f, 0f, 0f, 0f);
            nitroPfb.particleEmitter.emit = false;

            cloneNitroPfb = Instantiate(Resources.Load("BackFireParticles")) as GameObject;
            if (this.IsPlayer)
            {
                cloneNitroPfb.transform.parent = GameObject.Find(this.IDCar).transform;
            }
            else
            {
                cloneNitroPfb.transform.parent = GameObject.Find(this.IDCar).transform;
            }

            cloneNitroPfb.transform.localPosition = new Vector3(-0.005f, 0f, -2.09f);
            cloneNitroPfb.transform.localRotation = new Quaternion(0f, 0f, 0f, 0f);
            cloneNitroPfb.particleEmitter.emit = false;
        }
    }

    /// <summary>
    /// Phisics updating method. Here lies all car logics
    /// </summary>
    public void FixedUpdate()
    {
        // Current Speed indicator
        this.CurrentSpeed = Mathf.Round(2 * Mathf.PI * wheelRL.radius * wheelRL.rpm * 60 / 1000);
        this.RPInSecond = wheelRL.rpm;

        // Gas
        float currentSteerAngle;

        if (RearTopSpeed <= this.CurrentSpeed && this.CurrentSpeed <= this.TopSpeed)
        {
            if (this.IsPlayer)
            {
                this.AccelerateMotor(this.Torgue * Input.GetAxis("Vertical"));
            }
            else
            {
                this.AccelerateMotor(this.Torgue / 1.5f);
            }
        }
        else if (RearTopSpeed > this.CurrentSpeed || this.CurrentSpeed > this.TopSpeed)
        {
            if (this.CurrentSpeed < RearTopSpeed)
            {
                if (Input.GetAxis("Vertical") > 0 && this.IsPlayer)
                {
                    this.AccelerateMotor(this.Torgue * Input.GetAxis("Vertical"));
                }
                else
                {
                    this.AccelerateMotor(0);
                }
            }
            else if (this.CurrentSpeed > this.TopSpeed)
            {
                if (Input.GetAxis("Vertical") < 0 && this.IsPlayer)
                {
                    this.AccelerateMotor(this.Torgue * Input.GetAxis("Vertical"));
                }
                else
                {
                    this.AccelerateMotor(0);
                }
            }
        }

        //NOS
        if (Input.GetKey("left shift") == true &&
            this.IsPlayer &&
            this.HasNOSSystem == true &&
            isEmptyBottles == false)
        {
            this.TopSpeed = this.NitroTopSpeed;
            this.Torgue = this.NitroTorgue;

            this.NOSBottleTime -= Time.fixedDeltaTime;
            if (this.NOSBottleTime <= 0)
            {
                isEmptyBottles = true;
            }
        }
        else
        {
            this.TopSpeed = usualTopSpeed;
            this.Torgue = usualTorgue;

        }

        float speedFactor = rigidbody.velocity.magnitude / 45;

        // Speed reduce slip. Uncomplete Operation
        currentSteerAngle = Mathf.Lerp(this.MaxStear, this.MinStear, speedFactor);
        currentSteerAngle *= Input.GetAxis("Horizontal");

        //Debug.Log(currentSteerAngle);

        if (Input.GetButton("Horizontal") &&
            this.IsPlayer)
        {
            this.BrakeMotor(80f);
        }
        
        // Stear
        if (this.IsPlayer)
        {
            wheelL.steerAngle = currentSteerAngle;
            wheelR.steerAngle = currentSteerAngle;
        }

        //Deseleration
        if (Input.GetButton("Vertical") == true &&
            this.CurrentSpeed < this.TopSpeed &&
            this.IsPlayer)
        {
            this.BrakeMotor(0f);
        }
        else if ((Input.GetButton("Vertical") == false && Input.GetButton("Jump") == false && this.IsPlayer) ||
            this.CurrentSpeed > this.TopSpeed)
        {
            this.BrakeMotor(Desceleration);
        }

        //Brake
        if (Input.GetAxis("Vertical") < 0 &&
            this.CurrentSpeed > 0 &&
            this.IsPlayer)
        {
            this.BrakeMotor(this.BrakeForce);
        }

        //HandBrake
        if (Input.GetButton("Jump") &&
            this.IsPlayer)
        {
            wheelRL.brakeTorque = HandBrakeForce;
            wheelRL.motorTorque = 0f;
            wheelRR.brakeTorque = HandBrakeForce;
            wheelRR.motorTorque = 0f;

            if (rigidbody.velocity.magnitude > 1)
            {
                this.SetSlip(slipForward - 0.4f, slipSideway - 0.25f);
            }

        }
        else
        {
            var slipSmoothForward = Mathf.Lerp(slipForward, forward, 1f);
            var slipSmoothSideway = Mathf.Lerp(slipSideway, sideway, 1f);
            this.SetSlip(slipSmoothForward, slipSmoothSideway);
        }
    }

    /// <summary>
    /// Cosmetic audio visual effects method.
    /// </summary>
    public void Update()
    {

        VisualRotateWheels();

        if (Input.GetButton("Jump"))
        {
            //TODO: Stop spinining of the rear wheels?!
        }


        // Rotate on steering
        wheelL.transform.localEulerAngles = new Vector3(0, wheelL.steerAngle * 2f, 0);
        wheelR.transform.localEulerAngles = new Vector3(0, wheelL.steerAngle * 2f, 0);

        //FrontLights 
        if (Input.GetKeyDown(KeyCode.R))
        {
            if (isLightsOn == true)
            {
                isLightsOn = false;
                frontLights.SetActive(true);
            }
            else
            {
                isLightsOn = true;
                frontLights.SetActive(false);
            }
        }
        // Backlights & Reverse effect
        if (currentSpeed < 0)
        {
            backRightLight.color = whiteLight;
            backLeftLight.color = whiteLight;
            backLights.SetActive(true);
        }
        else if (Input.GetAxis("Vertical") < 0 ||
            currentSpeed == 0 &&
            this.IsPlayer)
        {
            backRightLight.color = redLight;
            backLeftLight.color = redLight;
            backLights.SetActive(true);
        }
        else
        {
            backRightLight.color = redLight;
            backLeftLight.color = redLight;
            backLights.SetActive(false);
        }

        //NOS fire
        if (this.HasNOSSystem == true &&
            this.IsPlayer)
        {
            if (Input.GetKey("left shift") == true && this.HasNOSSystem == true && isEmptyBottles == false)
            {
                nitroPfb.particleEmitter.emit = true;
                cloneNitroPfb.particleEmitter.emit = true;
            }
            else
            {
                nitroPfb.particleEmitter.emit = false;
                cloneNitroPfb.particleEmitter.emit = false;

            }
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

        //Skiding sound
        WheelHit wheelGrounded;
        for (int i = 0; i < 4; i++)
        {
            wheels[i].GetGroundHit(out wheelGrounded);
            float currentFrictionValue = Mathf.Abs(wheelGrounded.sidewaysSlip);

            if (skidLimit < currentFrictionValue && timer <= 0)
            {

                skiddingTracks[i].transform.parent = wheels[i].transform;
                float skidPositionX = i % 2 == 0 ? 0.12f : -0.12f;
                skiddingTracks[i].transform.localPosition = new Vector3(skidPositionX, -0.3f, -0.035f);
                Destroy(Instantiate(skidingPfb, wheelGrounded.point, Quaternion.identity), 1f);
                timer = 1.0f;
                skidingSmokes[i].particleEmitter.emit = true;


            }
            else if (skidLimit > currentFrictionValue)
            {
                for (int w = 0; w < wheels.Length; w++)
                {
                    skiddingTracks[w].transform.parent = null;
                    skidingSmokes[w].particleEmitter.emit = false;
                }
            }

            timer -= Time.deltaTime * skidEmission;
        }
    }


}
