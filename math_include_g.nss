////////////////////////////////////////////////////////////////////////////////
//:: math_include_g.nss
//:: AML computational geometry include file
//::
//:: This file is part of "Auxiliary Math Library" project by NWShacker
//:: Version 2.0
////////////////////////////////////////////////////////////////////////////////


#include "math_include_b"
#include "math_include_l"


////////////////////////////////////////////////////////////////////////////////
// ANGLE FUNCTIONS /////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////


// Calculates planar angle formed by vRay1, vVertex and vRay2. Angle value is in
// [-180, 180] range. Positive value means vRay2 is on the left of vector from
// vCenter to vRay1. Negative values means it is on the right of it.
// -vRay1: end of first ray (begin) of the angle
// -vVertex: vertex (tip) of the angle
// -vRay2: end of second ray (end) of the angle
// -i3D: if set to FALSE, Z components of input vectors are treated as 0
// Return value: angle between vRay1, vVertex and vRay2.
float MATH_Angle(vector vRay1, vector vVertex, vector vRay2, int i3D=FALSE);
float MATH_Angle(vector vRay1, vector vVertex, vector vRay2, int i3D=FALSE)
{
    if(!i3D)
    {
        vRay1.z = 0.0;
        vVertex.z = 0.0;
        vRay2.z = 0.0;
    }

    vRay1 = VectorNormalize(vRay1 - vVertex);
    vRay2 = VectorNormalize(vRay2 - vVertex);

    return MATH_SignFloat(MATH_CrossProduct(vRay1, vRay2).z, TRUE) *
        acos(MATH_DotProduct(vRay1, vRay2));
}


////////////////////////////////////////////////////////////////////////////////
// ROTATION FUNCTIONS //////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////


// Rotates vPoint around Z-axis going through vOrigin using the right hand rule
// (counter-clockwise when looking at the rotation plane from the perspective of
// pointing end of Z-axis) by fAngle degrees. This function returns the same
// vector as MATH_Rotation3D(vPoint, vOrigin, <0, 0, 1>, fAngle), but is faster.
// -vPoint: position to rotate
// -vOrigin: rotation origin
// -fDegrees: rotation angle
// Return value: rotated vPoint.
vector MATH_Rotation2D(vector vPoint, vector vOrigin, float fAngle);
vector MATH_Rotation2D(vector vPoint, vector vOrigin, float fAngle)
{
    if(fAngle == 0.0 || vPoint == vOrigin)
    {
        return vPoint;
    }

    float fCos;
    float fSin;

    fCos = cos(fAngle);
    fSin = sin(fAngle);
    vPoint = vPoint - vOrigin;

    return Vector(
        vPoint.x * fCos - vPoint.y * fSin,
        vPoint.x * fSin + vPoint.y * fCos,
        vPoint.z) + vOrigin;
}


// Rotates vPoint around vAxis going through vOrigin using the right hand rule
// (counter-clockwise when looking at the rotation plane from the perspective of
// pointing end of vAxis) by fAngle degrees. This function is an implementation
// of Rodrigues' formula which avoids explicit calculation of rotation matrices.
// -vPoint: position to rotate
// -vOrigin: rotation origin
// -vAxis: rotation axis
// -fDegrees: rotation angle
// Return value: rotated vPoint or vPoint if vAxis is <0, 0, 0>.
vector MATH_Rotation3D(vector vPoint, vector vOrigin, vector vAxis, float fAngle);
vector MATH_Rotation3D(vector vPoint, vector vOrigin, vector vAxis, float fAngle)
{
    if(fAngle == 0.0 || vPoint == vOrigin || VectorMagnitude(vAxis) == 0.0)
    {
        return vPoint;
    }

    vPoint = vPoint - vOrigin;
    vAxis = VectorNormalize(vAxis);

    return MATH_MulScalar(vPoint, cos(fAngle)) +
        MATH_MulScalar(MATH_CrossProduct(vAxis, vPoint), sin(fAngle)) +
            MATH_MulScalar(MATH_MulScalar(vAxis, MATH_DotProduct(vAxis, vPoint)),
            (1.0 - cos(fAngle))) + vOrigin;
}


////////////////////////////////////////////////////////////////////////////////
// PROJECTION FUNCTIONS ////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////


// Calculates projection of vPoint onto a line segment with end points at vStart
// and vEnd (vector leading from vPoint to the closest point on this segment).
// The result is an orthogonal projection if possible, or otherwise a vector
// towards either vStart or vEnd, whichever is closer to vPoint.
// -vPoint: position to project
// -vStart: begin of line segment
// -vEnd: end of line segment
// -i3D: if set to FALSE, Z components of input vectors are treated as 0
// Return value: projection vector of vPoint.
vector MATH_LineProjection(vector vPoint, vector vStart, vector vEnd, int i3D=FALSE);
vector MATH_LineProjection(vector vPoint, vector vStart, vector vEnd, int i3D=FALSE)
{
    if(!i3D)
    {
        vPoint.z = 0.0;
        vStart.z = 0.0;
        vEnd.z = 0.0;
    }

    vector vAxis;

    vAxis = VectorNormalize(vEnd - vStart);

    if(VectorMagnitude(vAxis) == 0.0)
    {
        return vStart - vPoint;
    }

    return MATH_ClipVector(MATH_MulScalar(vAxis,
        MATH_DotProduct(vPoint - vStart, vAxis) /
        MATH_DotProduct(vAxis, vAxis)) + vStart,
        vStart, vEnd) - vPoint;
}


// Calculates projection of vPoint onto a sphere (circle if i3D is set to FALSE)
// with center at vCenter and radius fRadius (vector leading from vPoint to the
// closest point on this segment). If vPoint and vCenter are the same, a random
// vector with fRadius length is generated.
// -vPoint: position to project
// -vCenter: center of sphere
// -fRadius: radius of sphere
// -i3D: if set to FALSE, Z components of input vectors are treated as 0
// Return value: projection vector of vPoint.
vector MATH_SphereProjection(vector vPoint, vector vCenter, float fRadius, int i3D=FALSE);
vector MATH_SphereProjection(vector vPoint, vector vCenter, float fRadius, int i3D=FALSE)
{
    if(!i3D)
    {
        vPoint.z = 0.0;
        vCenter.z = 0.0;
    }

    if(fRadius == 0.0)
    {
        return vCenter - vPoint;
    }

    fRadius = fabs(fRadius);

    if(vPoint == vCenter)
    {
        return MATH_MulScalar(VectorNormalize(Vector(
            MATH_RandUniform(-1.0, 1.0),
            MATH_RandUniform(-1.0, 1.0),
            i3D ? MATH_RandUniform(-1.0, 1.0) : 0.0)), fRadius);
    }

    vector vProjection;
    float fProjection;

    vProjection = vCenter - vPoint;
    fProjection = VectorMagnitude(vProjection);

    if(fProjection == fRadius)
    {
        return Vector(0.0, 0.0, 0.0);
    }
    else
    {
        return MATH_MulScalar(vProjection, 1.0 - fRadius / fProjection);
    }
}


// Calculates shortest projection of vPoint onto a closest line segment from a
// given set of line segments, which can be connected, intersecting or disjoint.
// Start positions of these segments are stored in stListStart, while their end
// positions - in stListEnd. Both lists must have the same length.
// -vPoint: position to project
// -stListStart: vector list structure of line segment start positions
// -stListEnd: vector list structure of line segment end positions
// -i3D: if set to FALSE, Z components of input vectors are treated as 0
// Return value: projection vector of vPoint, or <0, 0, 0> on error.
vector MATH_MultiLineProjection(vector vPoint, struct list stListStart, struct list stListEnd, int i3D=FALSE);
vector MATH_MultiLineProjection(vector vPoint, struct list stListStart, struct list stListEnd, int i3D=FALSE)
{
    if(stListStart.type != MATH_LIST_TYPE_VECTOR ||
        stListEnd.type != MATH_LIST_TYPE_VECTOR ||
        stListStart.length != stListEnd.length)
    {
        return Vector(0.0, 0.0, 0.0);
    }

    vector vBest;
    vector vCurrent;
    float fBest;
    float fCurrent;
    int i;

    vBest = Vector(0.0, 0.0, 0.0);
    fBest = pow(100.0, 100.0);

    for(i = 0; i < stListStart.length; i++)
    {
        vCurrent = MATH_LineProjection(vPoint,
            MATH_ListGetVector(stListStart, i),
            MATH_ListGetVector(stListEnd, i), i3D);
        fCurrent = VectorMagnitude(vCurrent);
        if(fCurrent < fBest)
        {
            vBest = vCurrent;
            fBest = fCurrent;
        }
    }

    return vBest;
}


// Calculates shortest projection of vPoint onto a closest sphere (circle if i3D
// is set to FALSE) from a given set of spheres, which can be intersecting or
// disjoint. Centers of these spheres are stored in stListCenter, while their
// radii - in stListRadius. Both lists must have the same length.
// -vPoint: position to project
// -stListCenter: vector list structure of sphere centers
// -stListRadius: float list structure of sphere radii
// -i3D: if set to FALSE, Z components of input vectors are treated as 0
// Return value: projection vector of vPoint, or <0, 0, 0> on error.
vector MATH_MultiSphereProjection(vector vPoint, struct list stListCenter, struct list stListRadius, int i3D=FALSE);
vector MATH_MultiSphereProjection(vector vPoint, struct list stListCenter, struct list stListRadius, int i3D=FALSE)
{
    if(stListCenter.type != MATH_LIST_TYPE_VECTOR ||
        stListRadius.type != MATH_LIST_TYPE_FLOAT ||
        stListCenter.length != stListRadius.length)
    {
        return Vector(0.0, 0.0, 0.0);
    }

    vector vBest;
    vector vCurrent;
    float fBest;
    float fCurrent;
    int i;

    vBest = Vector(0.0, 0.0, 0.0);
    fBest = pow(100.0, 100.0);

    for(i = 0; i < stListCenter.length; i++)
    {
        vCurrent = MATH_SphereProjection(vPoint,
            MATH_ListGetVector(stListCenter, i),
            MATH_ListGetFloat(stListRadius, i), i3D);
        fCurrent = VectorMagnitude(vCurrent);
        if(fCurrent < fBest)
        {
            vBest = vCurrent;
            fBest = fCurrent;
        }
    }

    return vBest;
}


////////////////////////////////////////////////////////////////////////////////
// INTERSECTION FUNCTIONS //////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////


// Checks whether two line segments, with end points at vStart1 and vEnd1 and at
// vStart2 and vEnd2, both treated as lying on XY plane, intersect (meaning that
// they have at least one common point). All five cases are checked, including
// those two when the segments are co-linear but may or may not overlap.
// -vStart1: begin of first line segment
// -vEnd1: end of first line segment
// -vStart2: begin of second line segment
// -vEnd2: end of second line segment
// Return value: TRUE if segments intersect, or FALSE otherwise.
int MATH_LineIntersection(vector vStart1, vector vEnd1, vector vStart2, vector vEnd2);
int MATH_LineIntersection(vector vStart1, vector vEnd1, vector vStart2, vector vEnd2)
{
    vStart1.z = 0.0;
    vStart2.z = 0.0;
    vEnd1.z = 0.0;
    vEnd2.z = 0.0;

    if(vStart1 == vEnd1 || vStart2 == vEnd2)
    {
        return FALSE;
    }

    vector vSegment1;
    vector vSegment2;
    float fCross0;
    float fCross1;
    float fCross2;
    float fFraction1;
    float fFraction2;

    vSegment1 = vEnd1 - vStart1;
    vSegment2 = vEnd2 - vStart2;
    fCross0 = MATH_CrossProduct(vSegment1, vSegment2).z;
    fCross1 = MATH_CrossProduct(vStart2 - vStart1, vSegment2).z;
    fCross2 = MATH_CrossProduct(vStart2 - vStart1, vSegment1).z;

    if(fCross0 == 0.0)
    {
        if(fCross1 == 0.0 || fCross2 == 0.0)
        {
            fFraction1 = fabs(MATH_DotProduct(vStart2 - vStart1, vSegment1) /
                MATH_DotProduct(vSegment1, vSegment1));
            fFraction2 = fabs(fCross1 + MATH_DotProduct(vSegment2, vSegment1) /
                MATH_DotProduct(vSegment1, vSegment1));
            return MATH_ClipFloat(fFraction1, 0.0, 1.0) == fFraction1 ||
                MATH_ClipFloat(fFraction2, 0.0, 1.0) == fFraction2;
        }
        else
        {
            return FALSE;
        }
    }
    else
    {
        fFraction1 = fCross1 / fCross0;
        fFraction2 = fCross2 / fCross0;
        return MATH_ClipFloat(fFraction1, 0.0, 1.0) == fFraction1 &&
            MATH_ClipFloat(fFraction2, 0.0, 1.0) == fFraction2;
    }
}


// Checks whether two spheres (circles if i3D is set to FALSE), one with center
// at vCenter1 and radius fRadius1, second with center at vCenter2 and radius
// fRadius2, share at least one common point (are tangent or intersecting).
// -vCenter1: center of first sphere
// -vCenter2: center of second sphere
// -fRadius1: radius of first sphere
// -fRadius2: radius of second sphere
// -i3D: if set to FALSE, Z components of input vectors are treated as 0
// Return value: TRUE if spheres intersect, or FALSE otherwise.
int MATH_SphereIntersection(vector vCenter1, vector vCenter2, float fRadius1, float fRadius2, int i3D=FALSE);
int MATH_SphereIntersection(vector vCenter1, vector vCenter2, float fRadius1, float fRadius2, int i3D=FALSE)
{
    if(!i3D)
    {
        vCenter1.z = 0.0;
        vCenter2.z = 0.0;
    }

    return VectorMagnitude(vCenter1 - vCenter2) <= fabs(fRadius1) + fabs(fRadius2);
}


////////////////////////////////////////////////////////////////////////////////
// CONTAINMENT FUNCTIONS ///////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////


// Checks whether vPoint lies at most fDistance away from a line segment between
// vStart and vEnd. If fDistance is equal to 0, vPoint must lie exactly on the
// line segment. If it is lower than 0, vPoint is allowed to lie beyond the line
// segment, but within absolute value of fDistance from vStart or vEnd.
// -vPoint: position to check
// -vStart: begin of line segment
// -vEnd: end of line segment
// -fDistance: maximum distance between vPoint and line segment
// -i3D: if set to FALSE, Z components of input vectors are treated as 0
// Return value: TRUE if vPoint is on the line, or FALSE otherwise.
int MATH_PointOnLine(vector vPoint, vector vStart, vector vEnd, float fDistance=0.0, int i3D=FALSE);
int MATH_PointOnLine(vector vPoint, vector vStart, vector vEnd, float fDistance=0.0, int i3D=FALSE)
{
    vector vProjection;

    vProjection = MATH_LineProjection(vPoint, vStart, vEnd, i3D);

    if(fDistance < 0.0)
    {
        return VectorMagnitude(vProjection) <= fabs(fDistance);
    }
    else
    {
        return VectorMagnitude(vProjection) <= fDistance &&
            fabs(MATH_Angle(vPoint, vPoint + vProjection, vStart, i3D)) <= 90.0 &&
            fabs(MATH_Angle(vPoint, vPoint + vProjection, vEnd, i3D)) <= 90.0;
    }
}

// Checks whether vPoint lies at most fDistance away from a sphere with center
// at vCenter and with radius fRadius (from inside or outside). If fDistance is
// equal to 0, vPoint must lie exactly on the sphere. If it is lower than 0, the
// return value contains information whether vPoint lies inside the sphere.
// -vPoint: position to project
// -vCenter: center of sphere
// -fRadius: radius of sphere
// -fDistance: maximum distance between vPoint and sphere
// -i3D: if set to FALSE, Z components of input vectors are treated as 0
// Return value: TRUE if vPoint is on / in the sphere, or FALSE otherwise.
int MATH_PointOnSphere(vector vPoint, vector vCenter, float fRadius, float fDistance=0.0, int i3D=FALSE);
int MATH_PointOnSphere(vector vPoint, vector vCenter, float fRadius, float fDistance=0.0, int i3D=FALSE)
{
    if(fDistance < 0.0)
    {
        return VectorMagnitude(vPoint - vCenter) <= fabs(fRadius);
    }

    return VectorMagnitude(MATH_SphereProjection(vPoint, vCenter, fRadius, i3D)) <= fDistance;
}


// Checks whether vPoint lies inside a polygon in XY plane, defined by a set of
// line segments. Each segment should be connected with at least two others (so
// they have a common start or end). They may form single or multiple polygons.
// To obtain meaningful results, polygons should not (self-)intersect or share
// vertices. Start positions of these segments are stored in stListStart, while
// their end positions - in stListEnd. Both lists must have the same length.
// -vPoint: position to check
// -stListStart: vector list structure of line segment start positions
// -stListEnd: vector list structure of line segment end positions
// -fDistance: maximum distance between vPoint and polygon
// Return value: TRUE if vPoint is on / in the polygon, or FALSE otherwise.
int MATH_PointOnPolygon(vector vPoint, struct list stListStart, struct list stListEnd, float fDistance=0.0);
int MATH_PointOnPolygon(vector vPoint, struct list stListStart, struct list stListEnd, float fDistance=0.0)
{
    if(stListStart.type != MATH_LIST_TYPE_VECTOR ||
        stListEnd.type != MATH_LIST_TYPE_VECTOR ||
        stListStart.length != stListEnd.length)
    {
        return FALSE;
    }

    int i;

    if(fDistance < 0.0)
    {
        vector vInfinity;
        int iInside;

        vInfinity = Vector(1000000.0, vPoint.y, vPoint.z);

        for(i = 0; i < stListStart.length; i++)
        {
            iInside += MATH_LineIntersection(vPoint, vInfinity,
                MATH_ListGetVector(stListStart, i),
                MATH_ListGetVector(stListEnd, i));
        }

        return iInside % 2 == 1;
    }
    else
    {
        for(i = 0; i < stListStart.length; i++)
        {
            if(VectorMagnitude(MATH_LineProjection(vPoint,
                MATH_ListGetVector(stListStart, i),
                MATH_ListGetVector(stListEnd, i), FALSE)) <= fDistance)
            {
                return TRUE;
            }
        }

        return FALSE;
    }
}
