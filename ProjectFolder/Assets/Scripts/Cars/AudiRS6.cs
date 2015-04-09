using UnityEngine;
using System.Collections;

public class AudiRS6 : Car
{
    public override void Start()
    {
        //Car Example
        this.IDCar = "AudiRS6";
        this.TopSpeed = 320f;
        this.Torgue = 650;
        this.MaxStear = 20f;
        this.MinStear = 0.3f;
        this.BrakeForce = 700f;
        this.Gears = 6;
        this.Transmision = TransmisionType.Quatro;
        this.GearRatio = new int[] { 430, 860, 1290, 1720, 2100, 2600 };

        //nitro Example

        this.NitroTopSpeedFactor = 1.3f;
        this.NitroTorgueFactor = 1.2f;
        this.NOSBottleTime = 20;
        this.HasNOSSystem = true;

        base.IsPlayer = this.gameObject.GetComponent<AICarController>().isPlayer;

        base.Start();

        if (!base.IsPlayer)
        {
            this.gameObject.GetComponent<AICarController>().MaxSteer = this.MaxStear;
            this.gameObject.GetComponent<AICarController>().Torgue = this.Torgue;
        }
        else
        {
            this.gameObject.GetComponent<AICarController>().enabled = false;
        }
    }

    public override void VisualRotateWheels()
    {
        wheelLRotation.Rotate(-wheelL.rpm / 60 * 360 * Time.deltaTime, 0, 0);
        wheelRRotation.Rotate(-wheelR.rpm / 60 * 360 * Time.deltaTime, 0, 0);
        wheelRLRotation.Rotate(-wheelRL.rpm / 60 * 360 * Time.deltaTime, 0, 0);
        wheelRRRotation.Rotate(-wheelRR.rpm / 60 * 360 * Time.deltaTime, 0, 0);
    }
    protected override void BackFireNitro()
    {
        this.NitroTopSpeed = this.TopSpeed * this.NitroTopSpeedFactor;
        this.NitroTorgue = this.Torgue * this.NitroTorgueFactor;
        nitroPfb = Instantiate(Resources.Load("BackFireParticles")) as GameObject;
        if (base.IsPlayer)
        {
            nitroPfb.transform.parent = GameObject.Find(this.IDCar + "Player").transform;
        }
        else
        {
            nitroPfb.transform.parent = GameObject.Find(this.IDCar).transform;
        }

        nitroPfb.transform.localPosition = new Vector3(-0.461f, -0.16f, -1.96f);
        nitroPfb.transform.localRotation = new Quaternion(0f, 0f, 0f, 0f);
        nitroPfb.particleEmitter.emit = false;

        cloneNitroPfb = Instantiate(Resources.Load("BackFireParticles")) as GameObject;
        if (base.IsPlayer)
        {
            cloneNitroPfb.transform.parent = GameObject.Find(this.IDCar + "Player").transform;
        }
        else
        {
            cloneNitroPfb.transform.parent = GameObject.Find(this.IDCar).transform;
        }

        cloneNitroPfb.transform.localPosition = new Vector3(0.446f, -0.16f, -1.96f);
        cloneNitroPfb.transform.localRotation = new Quaternion(0f, 0f, 0f, 0f);
        cloneNitroPfb.particleEmitter.emit = false;
    }

    private void OnTriggerStay(Collider other)
    {
        this.BrakeMotor(this.BrakeForce * 0.8f);
    }

    private void OnTriggerExit(Collider other)
    {
        this.BrakeMotor(0f);
    }
}
