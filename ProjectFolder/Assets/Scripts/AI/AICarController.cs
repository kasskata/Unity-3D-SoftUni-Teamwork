using UnityEngine;
using System.Collections;
using System.Collections.Generic;

public class AICarController : MonoBehaviour
{
    public Transform path;
    public WheelCollider frontLeftWheel;
    public WheelCollider frontRightWheel;

    public float sensorLength = 3f;
    public float frontSensorStartPoint = 2.3f;
    public float frontSensorSideDist = 1f;
    public float frontSensorsAngle = 15f;
    public float sidewaySensorLength = 1f;
    public float avoidSpeed = 2f;

    public bool isPlayer;

    private List<Transform> pathCheckPoints = new List<Transform>();
    private int currentPathObject;
    private float distanceFromCheckPoint = 7f;
    private float maxSteer;
    private float torgue;

    private int flag = 0;
    private float avoidSensitivity = 0f;

    public float MaxSteer
    {
        set { this.maxSteer = value; }
    }

    public float Torgue
    {
        set { this.torgue = value; }
    }

    private void Start()
    {
        GetPath();
    }

    private void Update()
    {
        GetSteer();
        Sensors();
    }

    private void GetPath()
    {
        for (int i = 0; i < this.path.childCount; i++)
        {
            this.pathCheckPoints.Add(this.path.GetChild(i));
        }
    }

    private void GetSteer()
    {
        Vector3 nextCheckPointPosition = new Vector3(
            this.pathCheckPoints[currentPathObject].position.x,
            transform.position.y,
            this.pathCheckPoints[currentPathObject].position.z);
        Vector3 steerVector = transform.InverseTransformPoint(nextCheckPointPosition);
        float newSteer = this.maxSteer * (steerVector.x / steerVector.magnitude);

        if (this.flag == 0)
        {
            this.frontLeftWheel.steerAngle = newSteer;
            this.frontRightWheel.steerAngle = newSteer;
        }
        

        if (this.distanceFromCheckPoint >= steerVector.magnitude)
        {
            this.currentPathObject++;
            if (this.currentPathObject >= this.pathCheckPoints.Count)
            {
                this.currentPathObject = 0;
            }
        }
    }

    private void Sensors()
    {
        Vector3 pos;
        RaycastHit hit;
        Vector3 rightAngle = Quaternion.AngleAxis(this.frontSensorsAngle, transform.up) * transform.forward;
        Vector3 leftAngle = Quaternion.AngleAxis(-this.frontSensorsAngle, transform.up) * transform.forward;
        this.avoidSensitivity = 0;
        this.flag = 0;

        //Front Mid Sensor
        pos = transform.position;
        pos += transform.forward * this.frontSensorStartPoint;
        if (Physics.Raycast(pos, transform.forward, out hit, this.sensorLength))
        {
            Debug.DrawLine(pos, hit.point, Color.white);
            if (hit.collider.GetComponentInParent<Rigidbody>() != null)
            {
                
            }
        }

        //Front Straight Right Sensor  
        pos += transform.right * frontSensorSideDist;
        if (Physics.Raycast(pos, transform.forward, out hit, sensorLength))
        {
            Debug.DrawLine(pos, hit.point, Color.white);
            if (hit.collider.GetComponentInParent<Rigidbody>() != null)
            {
                GameObject foundObject = hit.collider.GetComponentInParent<Rigidbody>().gameObject;
                if (foundObject.tag.Equals("Car") || foundObject.tag.Equals("Player'sCar"))
                {
                    if (this.frontLeftWheel.steerAngle > 0 && this.frontRightWheel.steerAngle > 0)
                    {
                        this.flag++;
                        this.avoidSensitivity -= 0.3f;
                    }
                    else
                    {
                        this.flag++;
                        this.avoidSensitivity -= 0.7f;
                    }
                }
            }
        }
        else if (Physics.Raycast(pos, rightAngle, out hit, sensorLength))
        {
            Debug.DrawLine(pos, hit.point, Color.white);
            if (hit.collider.GetComponentInParent<Rigidbody>() != null)
            {
                GameObject foundObject = hit.collider.GetComponentInParent<Rigidbody>().gameObject;
                if (foundObject.tag.Equals("Car") || foundObject.tag.Equals("Player'sCar"))
                {
                    if (this.frontLeftWheel.steerAngle > 0 && this.frontRightWheel.steerAngle > 0)
                    {
                        this.flag++;
                        this.avoidSensitivity -= 0.1f;
                    }
                    else
                    {
                        this.flag++;
                        this.avoidSensitivity -= 0.3f;
                    }
                }
            }
        }

        pos = transform.position;
        pos += transform.forward * frontSensorStartPoint;
        pos -= transform.right * frontSensorSideDist;
        if (Physics.Raycast(pos, transform.forward, out hit, sensorLength))
        {
            Debug.DrawLine(pos, hit.point, Color.white);
            if (hit.collider.GetComponentInParent<Rigidbody>() != null)
            {
                GameObject foundObject = hit.collider.GetComponentInParent<Rigidbody>().gameObject;
                if (foundObject.tag.Equals("Car") || foundObject.tag.Equals("Player'sCar"))
                {
                    if (foundObject.tag.Equals("Car") || foundObject.tag.Equals("Player'sCar"))
                    {
                        if (this.frontLeftWheel.steerAngle < 0 && this.frontRightWheel.steerAngle < 0)
                        {
                            this.flag++;
                            this.avoidSensitivity += 0.3f;
                        }
                        else
                        {
                            this.flag++;
                            this.avoidSensitivity += 0.7f;
                        }
                    }
                }
            }
        }
        else if (Physics.Raycast(pos, leftAngle, out hit, sensorLength))
        {
            Debug.DrawLine(pos, hit.point, Color.white);
            if (hit.collider.GetComponentInParent<Rigidbody>() != null)
            {
                GameObject foundObject = hit.collider.GetComponentInParent<Rigidbody>().gameObject;
                if (foundObject.tag.Equals("Car") || foundObject.tag.Equals("Player'sCar"))
                {
                    if (this.frontLeftWheel.steerAngle < 0 && this.frontRightWheel.steerAngle < 0)
                    {
                        this.flag++;
                        this.avoidSensitivity += 0.1f;
                    }
                    else
                    {
                        this.flag++;
                        this.avoidSensitivity += 0.2f;
                    }
                }
            }
        }

        //Right SideWay Sensor  
        if (Physics.Raycast(transform.position, transform.right, out hit, sidewaySensorLength))
        {
            Debug.DrawLine(transform.position, hit.point, Color.white);
            if (hit.collider.GetComponentInParent<Rigidbody>() != null)
            {
                GameObject foundObject = hit.collider.GetComponentInParent<Rigidbody>().gameObject;
                if (foundObject.tag.Equals("Car") || foundObject.tag.Equals("Player'sCar"))
                {
                    if (this.frontLeftWheel.steerAngle == 0 && this.frontRightWheel.steerAngle == 0)
                    {
                        this.flag++;
                        this.avoidSensitivity -= 0.1f;                        
                    }
                    
                }
            }
        }

        //Left SideWay Sensor  
        if (Physics.Raycast(transform.position, -transform.right, out hit, sidewaySensorLength))
        {
            Debug.DrawLine(transform.position, hit.point, Color.white);
            if (hit.collider.GetComponentInParent<Rigidbody>() != null)
            {
                GameObject foundObject = hit.collider.GetComponentInParent<Rigidbody>().gameObject;
                if (foundObject.tag.Equals("Car") || foundObject.tag.Equals("Player'sCar"))
                {
                    if (this.frontLeftWheel.steerAngle == 0 && this.frontRightWheel.steerAngle == 0)
                    {
                        this.flag++;
                        this.avoidSensitivity += 0.1f;
                    }
                }
            }
        }

        if (this.flag > 0)
        {
            AvoidSteer(this.avoidSensitivity);
        }
    }

    private void AvoidSteer(float sensitivity)
    {
        this.frontLeftWheel.steerAngle = avoidSpeed * sensitivity;
        this.frontRightWheel.steerAngle = avoidSpeed * sensitivity;
    }
}
