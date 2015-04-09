using UnityEngine;
using System.Collections;

public class AlfaRomeo : Car
{
    public override void Start()
    {
        //Car Example
        this.IDCar = "AlfaRomeoBrerra";
        this.TopSpeed = 250f;
        this.Torgue = 540f;
        this.MaxStear = 20f;
        this.MinStear = 0.3f;
        this.BrakeForce = 760f;
        this.Gears = 6;
        this.Transmision = TransmisionType.BackTwoWheels;
        this.GearRatio = new int[] { 430, 860, 1290, 1720, 2100, 2600 };

        //nitro Example

        this.NitroTopSpeedFactor = 1.3f;
        this.NitroTorgueFactor = 1.5f;
        this.NOSBottleTime = 20;
        this.HasNOSSystem = true;

        base.Start();
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
        nitroPfb.transform.parent = GameObject.Find(this.IDCar).transform;
        nitroPfb.transform.localPosition = new Vector3(-0.4f, 0.38f, -2f);
        nitroPfb.particleEmitter.emit = false;

        cloneNitroPfb = Instantiate(Resources.Load("BackFireParticles")) as GameObject;
        cloneNitroPfb.transform.parent = GameObject.Find(this.IDCar).transform;
        cloneNitroPfb.transform.localPosition = new Vector3(0.4f, 0.4f, -2.09f);
        cloneNitroPfb.particleEmitter.emit = false;
    }
}