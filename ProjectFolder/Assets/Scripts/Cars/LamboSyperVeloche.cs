using UnityEngine;
using System.Collections;

public class LamboSyperVeloche : Car
{
    

    public override void Start()
    {
        //Car Example
        this.IDCar = "LamboSyperVeloche";
        this.TopSpeed = 341f;
        this.Torgue = 600f;
        this.MaxStear = 16f;
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
