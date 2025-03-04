////////////////////////////////////////////////////////////////////////////////
//:: math_include_b.nss
//:: AML base math include file
//::
//:: This file is part of "Auxiliary Math Library" project by NWShacker
//:: Version 2.0
////////////////////////////////////////////////////////////////////////////////


////////////////////////////////////////////////////////////////////////////////
// CONSTANTS ///////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////


// Maximum integer value that doesn't cause overflow (+/- 2^31-1).
const int MATH_INT_MAX = 2147483647;
// Maximum integer value that can be exactly represented as float (+/- 2^24).
const int MATH_INT_SAFE = 16777216;
// Euler's constant (natural logarithm base).
const float MATH_E = 2.71828182846;


////////////////////////////////////////////////////////////////////////////////
// RANDOM SAMPLE FUNCTIONS /////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////


// Samples random int from uniform distribution over iMin (inclusive) and iMax
// (exclusive) range. Bounds may be negative. They are also automatically sorted
// to correct order. This function overcomes the limitations of vanilla NWN's
// PRNG, which can only generate numbers from either (-32768, 0] or [0, 32768)
// ranges. It is also efficient: it performs only four vanilla NWN Random calls.
// -iMin: lower bound
// -iMax: upper bound
// Return value: generated random int between iMin and iMax - 1.
int MATH_RandInt(int iMin, int iMax);
int MATH_RandInt(int iMin, int iMax)
{
    int iTemp;

    if(iMin > iMax)
    {
        iTemp = iMin; iMin = iMax; iMax = iTemp;
    }

    iTemp = (iMax + iMin) / 2;

    if(iTemp == iMin || iTemp == iMax)
    {
        return iMin;
    }

    if(Random(2))
    {
        return iMin +
            (Random(32768) << 16 | Random(32768) << 1 | Random(2)) % (iTemp - iMin);
    }
    else
    {
        return iTemp +
            (Random(32768) << 16 | Random(32768) << 1 | Random(2)) % (iMax - iTemp);
    }
}


// Samples random float from uniform distribution over iMin and iMax range (both
// (bounds inclusive). Ends may be negative. They are also automatically sorted
// to correct order. Caveat: there is no uniformity guarantee if the absolute
// value of iMin or iMax (or their difference) is larger than 2^24 (16 777 216).
// -fMin: lower bound
// -fMax: upper bound
// Return value: generated random float between fMin and fMax.
float MATH_RandUniform(float fMin, float fMax);
float MATH_RandUniform(float fMin, float fMax)
{
    if(fMin > fMax)
    {
        float fTemp;

        fTemp = fMin; fMin = fMax; fMax = fTemp;
    }

    return fMin + IntToFloat(Random(4096) << 12 | Random(4096)) / 16777215.0 *
        (fMax - fMin);
}


// Samples random float from normal (Gaussian or "bell curve") distribution with
// mean fMean and standard deviation fStandardDeviation. Because this function
// is an implementation of Marsaglia polar method, it contains a loop that calls
// MATH_RandUniform twice per iteration. This loop normally terminates quickly,
// but in some very rare cases it may not. Therefore exerting caution is advised
// when calling this function in loops.
// -fMean: mean (expected value)
// -fStandardDeviation: standard deviation (may be negative)
// Return value: generated random value or fMean if fStandardDeviation is zero.
float MATH_RandNormal(float fMean, float fStandardDeviation);
float MATH_RandNormal(float fMean, float fStandardDeviation)
{
    float fX;
    float fY;
    float fZ;

    do
    {
        fX = MATH_RandUniform(-1.0, 1.0);
        fY = MATH_RandUniform(-1.0, 1.0);
        fZ = fX * fX + fY * fY;
    }
    while(fZ == 0.0 || fZ > 1.0);

    return fMean + fStandardDeviation * fX * sqrt(-2.0 * log(fZ) / fZ);
}


////////////////////////////////////////////////////////////////////////////////
// ROUNDING FUNCTIONS //////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////


// Truncates fFloat towards zero to nearest integer.
// -fFloat: float to truncate
// Return value: truncated fFloat.
float MATH_TruncFloat(float fFloat);
float MATH_TruncFloat(float fFloat)
{
    string sString;

    sString = FloatToString(fFloat, 0, 1);

    return StringToFloat(GetSubString(sString, 0, GetStringLength(sString) - 2));
}


// Truncates components of vVector towards zero to nearest integers.
// -vVector: vector to truncate
// -iChangeZ: if set to FALSE, Z component of vVector is not modified
// Return value: vector of MATH_TruncFloat results for components of vVector.
vector MATH_TruncVector(vector vVector, int iChangeZ=TRUE);
vector MATH_TruncVector(vector vVector, int iChangeZ=TRUE)
{
    return Vector(
        MATH_TruncFloat(vVector.x),
        MATH_TruncFloat(vVector.y),
        iChangeZ ? MATH_TruncFloat(vVector.z) : vVector.z);
}


// Rounds fFloat towards nearest integer (up or down).
// -fFloat: float to round
// Return value: rounded fFloat.
float MATH_RoundFloat(float fFloat);
float MATH_RoundFloat(float fFloat)
{
    return StringToFloat(FloatToString(fFloat, 0, 0));
}


// Rounds components of vVector towards nearest integers (up or down).
// -vVector: vector to round
// -iChangeZ: if set to FALSE, Z component of vVector is not modified
// Return value: vector of MATH_RoundFloat results for components of vVector.
vector MATH_RoundVector(vector vVector, int iChangeZ=TRUE);
vector MATH_RoundVector(vector vVector, int iChangeZ=TRUE)
{
    return Vector(
        MATH_RoundFloat(vVector.x),
        MATH_RoundFloat(vVector.y),
        iChangeZ ? MATH_RoundFloat(vVector.z) : vVector.z);
}


// Rounds fFloat to largest integer not larger than it.
// -fFloat: float to calculate floor for
// Return value: floor of fFloat.
float MATH_FloorFloat(float fFloat);
float MATH_FloorFloat(float fFloat)
{
    float fTruncated;

    fTruncated = MATH_TruncFloat(fFloat);

    return fTruncated - ((fTruncated == fFloat || fFloat >= 0.0) ? 0.0 : 1.0);
}


// Rounds components of vVector to largest integers not larger than them.
// -vVector: vector to calculate floor for
// -iChangeZ: if set to FALSE, Z component of vVector is not modified
// Return value: vector of MATH_FloorFloat results for components of vVector.
vector MATH_FloorVector(vector vVector, int iChangeZ=TRUE);
vector MATH_FloorVector(vector vVector, int iChangeZ=TRUE)
{
    return Vector(
        MATH_FloorFloat(vVector.x),
        MATH_FloorFloat(vVector.y),
        iChangeZ ? MATH_FloorFloat(vVector.z) : vVector.z);
}


// Rounds fFloat to smallest integer not smaller than it.
// -fFloat: float to calculate ceiling for
// Return value: ceiling of fFloat.
float MATH_CeilFloat(float fFloat);
float MATH_CeilFloat(float fFloat)
{
    float fTruncated;

    fTruncated = MATH_TruncFloat(fFloat);

    return fTruncated + ((fTruncated == fFloat || fFloat <= 0.0) ? 0.0 : 1.0);
}


// Rounds components of vVector to smallest integers not smaller than them.
// -vVector: vector to calculate ceiling for
// -iChangeZ: if set to FALSE, Z component of vVector is not modified
// Return value: vector of MATH_CeilFloat results for components of vVector.
vector MATH_CeilVector(vector vVector, int iChangeZ=TRUE);
vector MATH_CeilVector(vector vVector, int iChangeZ=TRUE)
{
    return Vector(
        MATH_CeilFloat(vVector.x),
        MATH_CeilFloat(vVector.y),
        iChangeZ ? MATH_CeilFloat(vVector.z) : vVector.z);
}


////////////////////////////////////////////////////////////////////////////////
// COMPARISON FUNCTIONS ////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////


// Returns sign of iInt.
// -iInt: int to calculate sign for
// -iZeroPlus: if set to TRUE, zero is treated as "larger than zero"
// Return value: -1 if iInt < 0, 1 if iInt > 0, or otherwise 0.
int MATH_SignInt(int iInt, int iZeroPlus=FALSE);
int MATH_SignInt(int iInt, int iZeroPlus=FALSE)
{
    if(iZeroPlus)
    {
        return iInt < 0 ? -1 : 1;
    }
    else
    {
        return iInt < 0 ? -1 : iInt > 0 ? 1 : 0;
    }
}


// Returns sign of fFloat.
// -fFloat: float to calculate sign for
// -iZeroPlus: if set to TRUE, zero is treated as "larger than zero"
// Return value: -1.0 if fFloat < 0.0, 1.0 if fFloat > 0.0, or otherwise 0.0.
float MATH_SignFloat(float fFloat, int iZeroPlus=FALSE);
float MATH_SignFloat(float fFloat, int iZeroPlus=FALSE)
{
    if(iZeroPlus)
    {
        return fFloat < 0.0 ? -1.0 : 1.0;
    }
    else
    {
        return fFloat < 0.0 ? -1.0 : fFloat > 0.0 ? 1.0 : 0.0;
    }
}


// Returns vector containing signs of components of vVector.
// -vVector: vector to calculate sign for
// -iZeroPlus: if set to TRUE, zero is treated as "larger than zero"
// -iChangeZ: if set to FALSE, Z component of vVector is not modified
// Return value: vector of MATH_SignFloat results for components of vVector.
vector MATH_SignVector(vector vVector, int iZeroPlus=FALSE, int iChangeZ=TRUE);
vector MATH_SignVector(vector vVector, int iZeroPlus=FALSE, int iChangeZ=TRUE)
{
    return Vector(
        MATH_SignFloat(vVector.x, iZeroPlus),
        MATH_SignFloat(vVector.y, iZeroPlus),
        iChangeZ ? MATH_SignFloat(vVector.z, iZeroPlus) : vVector.z);
}


// Returns larger value between iInt1 and iInt2.
// -iInt1: first int to compare
// -iInt2: second int to compare
// Return value: iInt1 if iInt1 > iInt2, or iInt2 otherwise.
int MATH_MaxInt(int iInt1, int iInt2);
int MATH_MaxInt(int iInt1, int iInt2)
{
    return iInt1 > iInt2 ? iInt1 : iInt2;
}


// Returns larger value between fFloat1 and fFloat2.
// -fFloat1: first float to compare
// -fFloat2: second float to compare
// Return value: fFloat1 if fFloat1 > fFloat2, or fFloat2 otherwise.
float MATH_MaxFloat(float fFloat1, float fFloat2);
float MATH_MaxFloat(float fFloat1, float fFloat2)
{
    return fFloat1 > fFloat2 ? fFloat1 : fFloat2;
}


// Returns vector containing larger components between vVector1 and vVector2.
// -vVector1: first vector to compare
// -vVector2: second vector to compare
// -iKeepZ: decision regarding Z component: less than 0 - take vVector1.z, more
//  than 1 - take vVector2.z, 0 - take larger between vVector1.z and vVector2.z
// Return value: vector of MATH_MaxFloat results for pairs of corresponding
// components of vVector1 and vVector2.
vector MATH_MaxVector(vector vVector1, vector vVector2, int iKeepZ=0);
vector MATH_MaxVector(vector vVector1, vector vVector2, int iKeepZ=0)
{
    return Vector(
        MATH_MaxFloat(vVector1.x, vVector2.x),
        MATH_MaxFloat(vVector1.y, vVector2.y),
        iKeepZ == 0 ? MATH_MaxFloat(vVector1.z, vVector2.z) :
            iKeepZ < 0 ? vVector1.z : vVector2.z);
}


// Returns smaller value between iInt1 and iInt2.
// -iInt1: first int to compare
// -iInt2: second int to compare
// Return value: iInt1 if iInt1 < iInt2, or iInt2 otherwise.
int MATH_MinInt(int iInt1, int iInt2);
int MATH_MinInt(int iInt1, int iInt2)
{
    return iInt1 < iInt2 ? iInt1 : iInt2;
}


// Returns smaller value between fFloat1 and fFloat2.
// -fFloat1: first float to compare
// -fFloat2: second float to compare
// Return value: fFloat1 if fFloat1 < fFloat2, or fFloat2 otherwise.
float MATH_MinFloat(float fFloat1, float fFloat2);
float MATH_MinFloat(float fFloat1, float fFloat2)
{
    return fFloat1 < fFloat2 ? fFloat1 : fFloat2;
}


// Returns vector containing smaller components between vVector1 and vVector2.
// -vVector1: first vector to compare
// -vVector2: second vector to compare
// -iKeepZ: decision regarding Z component: less than 0 - take vVector1.z, more
//  than 1 - take vVector2.z, 0 - take smaller between vVector1.z and vVector2.z
// Return value: vector of MATH_MinFloat results for pairs of corresponding
// components of vVector1 and vVector2.
vector MATH_MinVector(vector vVector1, vector vVector2, int iKeepZ=0);
vector MATH_MinVector(vector vVector1, vector vVector2, int iKeepZ=0)
{
    return Vector(
        MATH_MinFloat(vVector1.x, vVector2.x),
        MATH_MinFloat(vVector1.y, vVector2.y),
        iKeepZ == 0 ? MATH_MinFloat(vVector1.z, vVector2.z) :
            iKeepZ < 0 ? vVector1.z : vVector2.z);
}


// Clips iInt to [iMin, iMax] range (inclusive). Bounds are automatically sorted
// to correct order.
// -iInt: int to clip
// -iMin: lower bound
// -iMax: upper bound
// Return value: iMin if iInt < iMin, iMax if iInt > iMax, or iInt otherwise.
int MATH_ClipInt(int iInt, int iMin, int iMax);
int MATH_ClipInt(int iInt, int iMin, int iMax)
{
    if(iMin > iMax)
    {
        int iTemp;

        iTemp = iMin; iMin = iMax; iMax = iTemp;
    }

    return iInt < iMin ? iMin : iInt > iMax ? iMax : iInt;
}


// Clips fFloat to [fMin, fMax] range (inclusive). Bounds are automatically
// sorted to correct order.
// -fFloat: float to clip
// -fMin: lower bound
// -fMax: upper bound
// Return value: fMin if fFloat < fMin, fMax if fFloat > fMax, or fFloat
// otherwise.
float MATH_ClipFloat(float fFloat, float fMin, float fMax);
float MATH_ClipFloat(float fFloat, float fMin, float fMax)
{
    if(fMin > fMax)
    {
        float fTemp;

        fTemp = fMin; fMin = fMax; fMax = fTemp;
    }

    return fFloat < fMin ? fMin : fFloat > fMax ? fMax : fFloat;
}


// Clips components of vVector to [vMin, vMax] range (inclusive). Bounds are
// automatically sorted to correct order.
// -vVector: vector to clip
// -vMin: lower bound
// -vMax: upper bound
// -iChangeZ: if set to FALSE, Z component of vVector is not modified
// Return value: vector of MATH_ClipFloat results for pairs of corresponding
// components of vVector, vMin and vMax.
vector MATH_ClipVector(vector vVector, vector vMin, vector vMax, int iChangeZ=TRUE);
vector MATH_ClipVector(vector vVector, vector vMin, vector vMax, int iChangeZ=TRUE)
{
    return Vector(
        MATH_ClipFloat(vVector.x, vMin.x, vMax.x),
        MATH_ClipFloat(vVector.y, vMin.y, vMax.y),
        iChangeZ ? MATH_ClipFloat(vVector.z, vMin.z, vMax.z) : vVector.z);
}


////////////////////////////////////////////////////////////////////////////////
// VECTOR ARITHMETIC FUNCTIONS /////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////


// Adds fScalar to each component of vVector. If vVector is <x, y, z> and
// fScalar is f, the return value is <x + f, y + f, z + f>.
// -vVector: vector operand
// -fScalar: scalar operand
// -iKeepZ: decision regarding Z component: less than 0 - take vVector.z, more
//  than 1 - take fScalar, 0 - take vVector.z + fScalar
// Return value: component-wise sum of vVector and fScalar.
vector MATH_AddScalar(vector vVector, float fScalar, int iKeepZ=0);
vector MATH_AddScalar(vector vVector, float fScalar, int iKeepZ=0)
{
    return Vector(
        vVector.x + fScalar,
        vVector.y + fScalar,
        iKeepZ == 0 ? vVector.z + fScalar :
            iKeepZ < 0 ? vVector.z : fScalar);
}


// Adds each component of vVector1 to corresponding component of vVector2. If
// vVector1 is <x1, y1, z1> and vVector2 is <x2, y2, z2>, the return value is
// <x1 + x2, y1 + y2, z1 + z2>.
// -vVector1: first vector operand
// -vVector2: second vector operand
// -iKeepZ: decision regarding Z component: less than 0 - take vVector1.z, more
//  than 1 - take vVector2.z, 0 - take vVector1.z + vVector2.z
// Return value: component-wise sum of vVector1 and vVector2.
vector MATH_AddVector(vector vVector1, vector vVector2, int iKeepZ=0);
vector MATH_AddVector(vector vVector1, vector vVector2, int iKeepZ=0)
{
    return Vector(
        vVector1.x + vVector2.x,
        vVector1.y + vVector2.y,
        iKeepZ == 0 ? vVector1.z + vVector2.z :
            iKeepZ < 0 ? vVector1.z : vVector2.z);
}


// Multiplies each component of vVector by fScalar. If vVector is <x, y, z> and
// fScalar is f, the return value is <x * f, y * f, z * f>.
// -vVector: vector operand
// -fScalar: scalar operand
// -iKeepZ: decision regarding Z component: less than 0 - take vVector.z, more
//  than 1 - take fScalar, 0 - take vVector.z * fScalar
// Return value: component-wise multiplication of vVector and fScalar.
vector MATH_MulScalar(vector vVector, float fScalar, int iKeepZ=0);
vector MATH_MulScalar(vector vVector, float fScalar, int iKeepZ=0)
{
    return Vector(
        vVector.x * fScalar,
        vVector.y * fScalar,
        iKeepZ == 0 ? vVector.z * fScalar :
            iKeepZ < 0 ? vVector.z : fScalar);
}


// Multiplies each component of vVector1 by corresponding component of vVector2.
// Example: if vVector1 is <x1, y1, z1> and vVector2 is <x2, y2, z2>, the return
// value is <x1 * x2, y1 * y2, z1 * z2>.
// -vVector1: first vector operand
// -vVector2: second vector operand
// -iKeepZ: decision regarding Z component: less than 0 - take vVector1.z, more
//  than 1 - take vVector2.z, 0 - take vVector1.z * vVector2.z
// Return value: component-wise multiplication of vVector1 and vVector2.
vector MATH_MulVector(vector vVector1, vector vVector2, int iKeepZ=0);
vector MATH_MulVector(vector vVector1, vector vVector2, int iKeepZ=0)
{
    return Vector(
        vVector1.x * vVector2.x,
        vVector1.y * vVector2.y,
        iKeepZ == 0 ? vVector1.z * vVector2.z :
            iKeepZ < 0 ? vVector1.z : vVector2.z);
}


////////////////////////////////////////////////////////////////////////////////
// LINEAR ALGEBRA FUNCTIONS ////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////


// Calculates dot product of vVector1 and vVector2.
// -vVector1: first vector operand
// -vVector2: second vector operand
// Return value: dot product of vVector1 and vVector2.
float MATH_DotProduct(vector vVector1, vector vVector2);
float MATH_DotProduct(vector vVector1, vector vVector2)
{
    return vVector1.x * vVector2.x + vVector1.y * vVector2.y + vVector1.z * vVector2.z;
}


// Calculates cross product of vVector1 and vVector2.
// -vVector1: first vector operand
// -vVector2: second vector operand
// Return value: cross product of vVector1 and vVector2.
vector MATH_CrossProduct(vector vVector1, vector vVector2);
vector MATH_CrossProduct(vector vVector1, vector vVector2)
{
    return Vector(
        vVector1.y * vVector2.z - vVector1.z * vVector2.y,
        vVector1.z * vVector2.x - vVector1.x * vVector2.z,
        vVector1.x * vVector2.y - vVector1.y * vVector2.x);
}
