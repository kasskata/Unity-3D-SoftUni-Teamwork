using UnityEngine;
using System.Collections;
using System.Collections.Generic;

public class PathScript : MonoBehaviour
{
    public Color pathColor = Color.white;
    private List<Transform> path;

    private void OnDrawGizmos()
    {
        Gizmos.color = this.pathColor;
        var checkPoints = transform.GetComponentsInChildren<Transform>();
        this.path = new List<Transform>();

        foreach (var checkPoint in checkPoints)
        {
            if (checkPoint != this.transform)
            {
                this.path.Add(checkPoint);                
            }
        }

        for (int i = 0; i < this.path.Count; i++)
        {
            Vector3 currentPos = this.path[i].position;
            if (i > 0)
            {
                Vector3 prevPos = this.path[i - 1].position;
                Gizmos.DrawLine(prevPos, currentPos);
                Gizmos.DrawWireSphere(currentPos, 0.5f);
            }
        }
    }
}
