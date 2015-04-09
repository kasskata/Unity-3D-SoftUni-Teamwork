using UnityEngine;
using System.Collections;

public class BertoneMantide : Car {

    public override void Start()
    {
        //Car Example
        this.IDCar = "BertoneMantide";
        this.TopSpeed = 320f;
        this.Torgue = 604f;
        this.MaxStear = 20f;
        this.MinStear = 0.3f;
        this.BrakeForce = 800f;
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
        nitroPfb.transform.localPosition = new Vector3(-0.12f, 0.32f, -2.26f);
        nitroPfb.particleEmitter.emit = false;

        cloneNitroPfb = Instantiate(Resources.Load("BackFireParticles")) as GameObject;
        cloneNitroPfb.transform.parent = GameObject.Find(this.IDCar).transform;
        cloneNitroPfb.transform.localPosition = new Vector3(0.13f, 0.28f, -2.16f);
        cloneNitroPfb.particleEmitter.emit = false;
    }
}
