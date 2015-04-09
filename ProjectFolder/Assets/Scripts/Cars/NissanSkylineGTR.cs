using UnityEngine;
using System.Collections;

public class NissanSkylineGTR : Car {

    public override void Start()
    {
        //Car Example
        this.IDCar = "NissanSkyline";
        this.TopSpeed = 320f;
        this.Torgue = 450f;
        this.MaxStear = 20f;
        this.MinStear = 0.3f;
        this.BrakeForce = 520f;
        this.Gears = 6;
        this.Transmision = TransmisionType.Quatro;
        this.GearRatio = new int[] { 430, 860, 1290, 1720, 2100, 2600 };

        //nitro Example
        this.NitroTopSpeedFactor = 1.3f;
        this.NitroTorgueFactor = 1.2f;
        this.NOSBottleTime = 20;
        this.HasNOSSystem = true;

        base.Start();
    }

    public override void VisualRotateWheels()
    {
        wheelLRotation.Rotate(-wheelL.rpm / 60 * 360 * Time.deltaTime, 0, 0);
        wheelRRotation.Rotate(wheelR.rpm / 60 * 360 * Time.deltaTime, 0, 0);
        wheelRLRotation.Rotate(-wheelRL.rpm / 60 * 360 * Time.deltaTime, 0, 0);
        wheelRRRotation.Rotate(wheelRR.rpm / 60 * 360 * Time.deltaTime, 0, 0);
    }

    protected override void BackFireNitro()
    {
        this.NitroTopSpeed = this.TopSpeed * this.NitroTopSpeedFactor;
        this.NitroTorgue = this.Torgue * this.NitroTorgueFactor;
        nitroPfb = Instantiate(Resources.Load("BackFireParticles")) as GameObject;
        nitroPfb.transform.parent = GameObject.Find(this.IDCar).transform;
        nitroPfb.transform.localPosition = new Vector3(-0.37f, 0.29f, -2.03f);
        nitroPfb.particleEmitter.emit = false;

        cloneNitroPfb = Instantiate(Resources.Load("BackFireParticles")) as GameObject;
        cloneNitroPfb.transform.parent = GameObject.Find(this.IDCar).transform;
        cloneNitroPfb.transform.localPosition = new Vector3(-0.37f, 0.29f, -2.03f);
        cloneNitroPfb.particleEmitter.emit = false;
    }
}
