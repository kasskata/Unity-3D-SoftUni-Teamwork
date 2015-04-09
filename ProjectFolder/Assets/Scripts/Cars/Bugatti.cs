using UnityEngine;
using System.Collections;

public class Bugatti : Car
{
    public override void Start()
    {
        //Car Example
        this.IDCar = "BugattiVayron";
        this.TopSpeed = 360f;
        this.Torgue = 700f;
        this.MaxStear = 15f;
        this.MinStear = 0.3f;
        this.BrakeForce = 1000f;
        this.Gears = 6;
        this.Transmision = TransmisionType.Quatro;
        this.GearRatio = new int[] { 430, 860, 1290, 1720, 2100, 2600 };

        //nitro Example
        this.NitroTopSpeedFactor = 1.3f;
        this.NitroTorgueFactor = 1.5f;
        this.NOSBottleTime = 20;
        this.HasNOSSystem = true;

        base.IsPlayer = this.gameObject.tag == "Player'sCar";

        base.Start();
    }

    public override void VisualRotateWheels()
    {
        wheelLRotation.Rotate(wheelL.rpm / 60 * 360 * Time.deltaTime, 0, 0);
        wheelRRotation.Rotate(-wheelR.rpm / 60 * 360 * Time.deltaTime, 0, 0);
        wheelRLRotation.Rotate(wheelRL.rpm / 60 * 360 * Time.deltaTime, 0, 0);
        wheelRRRotation.Rotate(-wheelRR.rpm / 60 * 360 * Time.deltaTime, 0, 0);
    }

    private void OnTriggerStay(Collider other)
    {
        this.BrakeMotor(this.BrakeForce);
    }

    private void OnTriggerExit(Collider other)
    {
        this.BrakeMotor(0f);
    }
}
