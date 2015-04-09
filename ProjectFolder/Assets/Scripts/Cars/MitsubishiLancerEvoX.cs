using UnityEngine;
using System.Collections;

public class MitsubishiLancerEvoX : Car {

    public override void Start()
    {
        //Car Example
        this.IDCar = "MitsubishiLancerEvo_X";
        this.TopSpeed = 280f;
        this.Torgue = 422f;
        this.MaxStear = 18f;
        this.MinStear = 0.3f;
        this.BrakeForce = 600f;
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

    public override void VisualRotateWheels()
    {
        wheelLRotation.Rotate(wheelL.rpm / 60 * 360 * Time.deltaTime, 0, 0);
        wheelRRotation.Rotate(-wheelR.rpm / 60 * 360 * Time.deltaTime, 0, 0);
        wheelRLRotation.Rotate(wheelRL.rpm / 60 * 360 * Time.deltaTime, 0, 0);
        wheelRRRotation.Rotate(-wheelRR.rpm / 60 * 360 * Time.deltaTime, 0, 0);
    }

    protected override void BackFireNitro()
    {
        this.NitroTopSpeed = this.TopSpeed * this.NitroTopSpeedFactor;
        this.NitroTorgue = this.Torgue * this.NitroTorgueFactor;
        nitroPfb = Instantiate(Resources.Load("BackFireParticles")) as GameObject;
        nitroPfb.transform.parent = GameObject.Find(this.IDCar).transform;
        nitroPfb.transform.localPosition = new Vector3(-0.42f, 0.31f, -2.29f);
        nitroPfb.particleEmitter.emit = false;

        cloneNitroPfb = Instantiate(Resources.Load("BackFireParticles")) as GameObject;
        cloneNitroPfb.transform.parent = GameObject.Find(this.IDCar).transform;
        cloneNitroPfb.transform.localPosition = new Vector3(0.37f, 0.31f, -2.27f);
        cloneNitroPfb.particleEmitter.emit = false;
    }
}
