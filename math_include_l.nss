////////////////////////////////////////////////////////////////////////////////
//:: math_include_l.nss
//:: AML list support include file
//::
//:: This file is part of "Auxiliary Math Library" project by NWShacker
//:: Version 2.0
////////////////////////////////////////////////////////////////////////////////


////////////////////////////////////////////////////////////////////////////////
// CONSTANTS ///////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////


// Homogeneous list structure.
// -type: type of list: one of MATH_LIST_TYPE_* constants (constant)
// -itemsize: length of string representation of each list item (constant)
// -length: number of items in list (variable), updated automatically
// -data: list item payload (variable), updated automatically
struct list
{
    int type;
    int itemsize;
    int length;
    string data;
};

// List type constants. MATH_LIST_TYPE_INVALID type is used by list functions to
// signal that an error has occurred. In such case, values of other fields in a
// returned list should be considered unreliable.
const int MATH_LIST_TYPE_INVALID = 0;
const int MATH_LIST_TYPE_INT = 1;
const int MATH_LIST_TYPE_FLOAT = 2;
const int MATH_LIST_TYPE_VECTOR = 3;
const int MATH_LIST_TYPE_STRING = 4;

// String with enough length to contain the string representations of list items
// of all variable types. The actual character used for padding is unimportant.
const string MATH_LIST_PADDING = "____________________________________________________________________________________________________";

// Number of decimals in string representations of float and vector list items
// (maximum: 9, reasonable 9). Warning: lower values cause stronger rounding.
const int MATH_LIST_DECIMALS = 9;

// Default length of string representation of an int list item (maximum: 11,
// minimum: 1, reasonable: 11).
const int MATH_LIST_SIZE_INT = 11;
// Default length of string representation of a float list item (maximum: 50,
// minimum: 1 + MATH_LIST_DECIMALS, reasonable: 20).
const int MATH_LIST_SIZE_FLOAT = 20;
// Default length of string representation of a vector list item (maximum: 150,
// minimum: 3 + 3 x MATH_LIST_DECIMALS, reasonable: 60). This value must be
// dividable by 3 (1/3 for each vector component).
const int MATH_LIST_SIZE_VECTOR = 60;
// Default length of string representation of a string list item (maximum: ???,
// minimum: 2, reasonable: 18, to hold a 16-character tag or script name). This
// value must be large enough to contain the string length field: an int with
// maximum length of its string representation, calculated automatically as 1 +
// floor(log10(MATH_LIST_SIZE_STRING)).
const int MATH_LIST_SIZE_STRING = 18;


////////////////////////////////////////////////////////////////////////////////
// LIST ITEM CREATION FUNCTIONS ////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////


// Converts sString into a raw string representation of an item of a list with
// item size iSize. If length of sString exceeds iSize, it is truncated to first
// iSize characters. Otherwise it is padded (from the end) to iSize length using
// characters from MATH_LIST_PADDING. This is an internal function and it is not
// meant to be used directly. To convert standard variable types to list items,
// use their corresponding MATH_ListItem* functions.
// -sString: string to convert
// -iSize: list item size
// Return value: sString converted to a list item.
string MATH_ListItemRaw(string sString, int iSize);
string MATH_ListItemRaw(string sString, int iSize)
{
    int iLength;

    iLength = GetStringLength(sString);

    if(iLength > iSize)
    {
        return GetStringLeft(sString, iSize);
    }
    else if(iLength < iSize)
    {
        return sString + GetStringLeft(MATH_LIST_PADDING, iSize - iLength);
    }
    else
    {
        return sString;
    }
}


// Converts iInt into string representation of an item of list with item size
// iSize. iSize value must match the item size of the target list.
// -iInt: int to convert
// -iSize: list item size
// Return value: iInt converted to a list item.
string MATH_ListItemInt(int iInt, int iSize=MATH_LIST_SIZE_INT);
string MATH_ListItemInt(int iInt, int iSize=MATH_LIST_SIZE_INT)
{
    return MATH_ListItemRaw(IntToString(iInt), iSize);
}


// Converts fFloat into string representation of an item of list with item size
// iSize. iSize value must match the item size of the target list.
// -fFloat: float to convert
// -iSize: list item size
// Return value: fFloat converted to a list item.
string MATH_ListItemFloat(float fFloat, int iSize=MATH_LIST_SIZE_FLOAT);
string MATH_ListItemFloat(float fFloat, int iSize=MATH_LIST_SIZE_FLOAT)
{
    return MATH_ListItemRaw(FloatToString(fFloat, 0, MATH_LIST_DECIMALS), iSize);
}


// Converts vVector into string representation of an item of list with item size
// iSize. iSize value must match the item size of the target list.
// -vVector: value to convert
// -iSize: list item size
// Return value: vVector converted to a list item.
string MATH_ListItemVector(vector vVector, int iSize=MATH_LIST_SIZE_VECTOR);
string MATH_ListItemVector(vector vVector, int iSize=MATH_LIST_SIZE_VECTOR)
{
    iSize /= 3;

    return MATH_ListItemRaw(FloatToString(vVector.x, 0, MATH_LIST_DECIMALS), iSize) +
        MATH_ListItemRaw(FloatToString(vVector.y, 0, MATH_LIST_DECIMALS), iSize) +
        MATH_ListItemRaw(FloatToString(vVector.z, 0, MATH_LIST_DECIMALS), iSize);
}


// Converts sString into string representation of an item of list with item size
// iSize. iSize value must match the item size of the target list.
// -sString: value to convert
// -iSize: list item size
// Return value: sString converted to a list item.
string MATH_ListItemString(string sString, int iSize=MATH_LIST_SIZE_STRING);
string MATH_ListItemString(string sString, int iSize=MATH_LIST_SIZE_STRING)
{
    int iOffset;
    int iLength;

    iOffset = FloatToInt(log(IntToFloat(iSize)) / log(10.0)) + 1;
    iLength = GetStringLength(sString);

    if(iLength > iSize - iOffset)
    {
        iLength = iSize - iOffset;
        sString = GetStringLeft(sString, iLength);
    }

    return MATH_ListItemRaw(MATH_ListItemRaw(IntToString(iLength), iOffset) +
        sString, iSize);
}


////////////////////////////////////////////////////////////////////////////////
// LIST ITEM RETRIEVAL FUNCTIONS ///////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////


// Retrieves raw value of stList item at iIndex. This is an internal function
// and it is not meant to be used directly. To retrieve standard variable types
// from list items, use their corresponding MATH_ListGet* functions. iIndex must
// must be in [-L, L) range where L is the length of stList.
// -stList: list structure
// -iIndex: list item index
// Return value: raw stList item value, or "" on error.
string MATH_ListGetRaw(struct list stList, int iIndex);
string MATH_ListGetRaw(struct list stList, int iIndex)
{
    if(iIndex < 0)
    {
        iIndex += stList.length;
    }

    return GetSubString(stList.data, iIndex * stList.itemsize, stList.itemsize);
}


// Retrieves int value of stList item at iIndex. stList does not have to be an
// int list, but the result may be unexpected. iIndex must must be in [-L, L)
// range where L is the length of stList.
// -stList: list structure
// -iIndex: list item index
// Return value: stList item value as int, or 0 on error.
int MATH_ListGetInt(struct list stList, int iIndex);
int MATH_ListGetInt(struct list stList, int iIndex)
{
    if(iIndex < 0)
    {
        iIndex += stList.length;
    }

    return StringToInt(
        GetSubString(stList.data, iIndex * stList.itemsize, stList.itemsize));
}


// Retrieves float value of stList item at iIndex. stList does not have to be a
// float list, but the result may be unexpected. iIndex must must be in [-L, L)
// range where L is the length of stList.
// -stList: list structure
// -iIndex: list item index
// Return value: stList item value as float, or 0.0 on error.
float MATH_ListGetFloat(struct list stList, int iIndex);
float MATH_ListGetFloat(struct list stList, int iIndex)
{
    if(iIndex < 0)
    {
        iIndex += stList.length;
    }

    return StringToFloat(
        GetSubString(stList.data, iIndex * stList.itemsize, stList.itemsize));
}


// Retrieves vector value of stList item at iIndex. stList does not have to be a
// vector list, but the result may be unexpected. iIndex must must be in [-L, L)
// range where L is the length of stList.
// -stList: list structure
// -iIndex: list item index
// Return value: stList item value as vector, or <0, 0, 0> on error.
vector MATH_ListGetVector(struct list stList, int iIndex);
vector MATH_ListGetVector(struct list stList, int iIndex)
{
    vector vVector;
    string sItem;
    int iLength;

    if(iIndex < 0)
    {
        iIndex += stList.length;
    }

    sItem = GetSubString(stList.data, iIndex * stList.itemsize, stList.itemsize);

    iLength = stList.itemsize / 3;

    vVector.x = StringToFloat(GetSubString(sItem, 0, iLength));
    vVector.y = StringToFloat(GetSubString(sItem, iLength, iLength));
    vVector.z = StringToFloat(GetSubString(sItem, 2 * iLength, iLength));

    return vVector;
}


// Retrieves string value of stList item at iIndex. stList does not have to be a
// string list, but the result may be unexpected. iIndex must must be in [-L, L)
// range where L is the length of stList.
// -stList: list structure
// -iIndex: list item index
// Return value: stList item value as string, or "" on error.
string MATH_ListGetString(struct list stList, int iIndex);
string MATH_ListGetString(struct list stList, int iIndex)
{
    string sItem;
    int iOffset;

    if(iIndex < 0)
    {
        iIndex += stList.length;
    }

    sItem = GetSubString(stList.data, iIndex * stList.itemsize, stList.itemsize);

    iOffset = FloatToInt(log(IntToFloat(stList.itemsize)) / log(10.0)) + 1;

    return GetSubString(sItem, iOffset, StringToInt(GetSubString(sItem, 0, iOffset)));
}


////////////////////////////////////////////////////////////////////////////////
// LIST CREATION AND VALIDATION FUNCTIONS //////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////


// Creates new, empty list structure of type iType and item size iSize. Minimum
// item size for int and float lists is 1, for vector - 3, and for string - 2.
// -iType: type of list (MATH_LIST_TYPE_* constant)
// -iSize: list item size (default for given iType if set to 0 or less)
// Return value: new list (with MATH_LIST_TYPE_INVALID type on error).
struct list MATH_ListInit(int iType, int iSize=-1);
struct list MATH_ListInit(int iType, int iSize=-1)
{
    struct list stList;

    switch(iType)
    {
        case MATH_LIST_TYPE_INT:
        {
            if(iSize <= 0)
            {
                iSize = MATH_LIST_SIZE_INT;
            }
            break;
        }
        case MATH_LIST_TYPE_FLOAT:
        {
            if(iSize <= 0)
            {
                iSize = MATH_LIST_SIZE_FLOAT;
            }
            break;
        }
        case MATH_LIST_TYPE_VECTOR:
        {
            if(iSize <= 0)
            {
                iSize = MATH_LIST_SIZE_VECTOR;
            }
            break;
        }
        case MATH_LIST_TYPE_STRING:
        {
            if(iSize <= 0)
            {
                iSize = MATH_LIST_SIZE_STRING;
            }
            break;
        }
        default:
        {
            stList.type = MATH_LIST_TYPE_INVALID;
            return stList;
        }
    }

    stList.type = iType;
    stList.itemsize = iSize;

    return stList;
}


// Validates integrity of stList: checks type, item size and length, and whether
// the number and size of list items match those values. It does not check for
// correctness of list items. This function can be used for quick validation of
// results of other list-related function, which signal errors by setting the
// output list type to MATH_LIST_TYPE_INVALID.
// -stList: list structure
// -iTypeOnly: if set to TRUE, only list type is checked (faster, less precise)
// Return value: TRUE if stList appears valid, or FALSE otherwise.
int MATH_ListValidate(struct list stList, int iTypeOnly=FALSE);
int MATH_ListValidate(struct list stList, int iTypeOnly=FALSE)
{
    switch(stList.type)
    {
        case MATH_LIST_TYPE_INT:
        case MATH_LIST_TYPE_FLOAT:
        case MATH_LIST_TYPE_VECTOR:
        case MATH_LIST_TYPE_STRING:
        {
            if(iTypeOnly)
            {
                return TRUE;
            }
            else
            {
                break;
            }
        }
        default:
        {
            return FALSE;
        }
    }

    if(stList.itemsize <= 0)
    {
        return FALSE;
    }

    if((GetStringLength(stList.data) / stList.itemsize) != stList.length)
    {
        return FALSE;
    }

    return TRUE;
}


////////////////////////////////////////////////////////////////////////////////
// LIST CONVERSION AND PARSING FUNCTIONS ///////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////


// Converts stList into its string representation, for example to store it as a
// local variable. This is the opposite of MATH_ListStringLoad function.
// -stList: list structure
// Return value: representation string of stList.
string MATH_ListStringDump(struct list stList);
string MATH_ListStringDump(struct list stList)
{
    return MATH_ListItemRaw(IntToString(stList.type), 1) +
        MATH_ListItemRaw(IntToString(stList.itemsize), 10) +
        MATH_ListItemRaw(IntToString(stList.length), 10) +
        stList.data;
}


// Converts list from its string representation, for example after getting it
// from a local variable. This is the opposite of MATH_ListStringDump function.
// -sString: list representation string
// Return value: list structure (with MATH_LIST_TYPE_INVALID type on error).
struct list MATH_ListStringLoad(string sString);
struct list MATH_ListStringLoad(string sString)
{
    struct list stList;

    stList.type = StringToInt(GetSubString(sString, 0, 1));
    stList.itemsize = StringToInt(GetSubString(sString, 1, 10));
    stList.length = StringToInt(GetSubString(sString, 11, 10));
    stList.data = GetSubString(sString, 21, -1);

    if(MATH_ListValidate(stList))
    {
        return stList;
    }
    else
    {
        return MATH_ListInit(MATH_LIST_TYPE_INVALID);
    }
}


// Splits sString by sSeparator into a list of type iType and item size iSize.
// Warning: this is an O(n) operation.
// -sString: source string
// -iType: type of list (MATH_LIST_TYPE_* constant)
// -iSize: list item size (default for given iType if set to 0 or less)
// -sSeparator: string to split sString by
// -sSubSeparator: string to split vector components by (only for vector lists)
// Return value: generated list (with MATH_LIST_TYPE_INVALID type on error).
struct list MATH_ListParse(string sString, int iType, int iSize=-1, string sSeparator="|", string sSubSeparator=",");
struct list MATH_ListParse(string sString, int iType, int iSize=-1, string sSeparator="|", string sSubSeparator=",")
{
    struct list stList;
    string sValue;
    int iStart;
    int iEnd;

    stList = MATH_ListInit(iType, iSize);

    switch(stList.type)
    {
        case MATH_LIST_TYPE_INT:
        {
            while(iEnd >= 0)
            {
                iEnd = FindSubString(sString, sSeparator, iStart);
                sValue = GetSubString(sString, iStart, iEnd - iStart);
                stList.length += 1;
                stList.data += MATH_ListItemInt(StringToInt(sValue), stList.itemsize);
                iStart = iEnd + 1;
            }
            break;
        }
        case MATH_LIST_TYPE_FLOAT:
        {
            while(iEnd >= 0)
            {
                iEnd = FindSubString(sString, sSeparator, iStart);
                sValue = GetSubString(sString, iStart, iEnd - iStart);
                stList.length += 1;
                stList.data += MATH_ListItemFloat(StringToFloat(sValue), stList.itemsize);
                iStart = iEnd + 1;
            }
            break;
        }
        case MATH_LIST_TYPE_VECTOR:
        {
            float fX;
            float fY;
            float fZ;
            int iFirst;
            int iSecond;
            while(iEnd >= 0)
            {
                iEnd = FindSubString(sString, sSeparator, iStart);
                sValue = GetSubString(sString, iStart, iEnd - iStart);
                iFirst = FindSubString(sValue, sSubSeparator, 0);
                fX = StringToFloat(GetSubString(sValue, 0, iFirst));
                if(iFirst != -1)
                {
                    iSecond = FindSubString(sValue, sSubSeparator, iFirst + 1);
                    if(iSecond != -1)
                    {
                        fY = StringToFloat(GetSubString(sValue, iFirst + 1, iSecond - iFirst - 1));
                        fZ = StringToFloat(GetSubString(sValue, iSecond + 1, -1));
                    }
                    else
                    {
                        fY = StringToFloat(GetSubString(sValue, iFirst + 1, -1));
                        fZ = 0.0;
                    }
                }
                else
                {
                    fY = 0.0;
                    fZ = 0.0;
                }
                stList.length += 1;
                stList.data += MATH_ListItemVector(Vector(fX, fY, fZ), stList.itemsize);
                iStart = iEnd + 1;
            }
            break;
        }
        case MATH_LIST_TYPE_STRING:
        {
            while(iEnd >= 0)
            {
                iEnd = FindSubString(sString, sSeparator, iStart);
                sValue = GetSubString(sString, iStart, iEnd - iStart);
                stList.length += 1;
                stList.data += MATH_ListItemString(sValue, stList.itemsize);
                iStart = iEnd + 1;
            }
            break;
        }
    }

    return stList;
}


////////////////////////////////////////////////////////////////////////////////
// LIST SLICING AND MERGING FUNCTIONS //////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////


// Slices stList - extracts all of its items between iIndex1 and iIndex2 (both
// inclusive). Slice is empty if iIndex1 is higher than iIndex2. However, unlike
// other functions, iIndex1 and iIndex2 may lie out of list length boundaries -
// they are automatically set to first or last index, respectively.
// -stList: list structure
// -iIndex1: index of first item in slice
// -iIndex2: index of last item in slice
// -iSafe: if set to FALSE, index validation is skipped (for internal use only)
// Return value: stList slice (with MATH_LIST_TYPE_INVALID type on error).
struct list MATH_ListSlice(struct list stList, int iIndex1, int iIndex2, int iSafe=TRUE);
struct list MATH_ListSlice(struct list stList, int iIndex1, int iIndex2, int iSafe=TRUE)
{
    if(iSafe)
    {
        if(iIndex1 < 0)
        {
            iIndex1 += stList.length;
            if(iIndex1 < 0)
            {
                return MATH_ListInit(MATH_LIST_TYPE_INVALID);
            }
        }
        else if(iIndex1 >= stList.length)
        {
            iIndex1 = stList.length - 1;
        }
        if(iIndex2 < 0)
        {
            iIndex2 += stList.length;
            if(iIndex2 < 0)
            {
                iIndex2 = 0;
            }
        }
        else if(iIndex2 >= stList.length)
        {
            return MATH_ListInit(MATH_LIST_TYPE_INVALID);
        }
    }

    if(iIndex1 > iIndex2)
    {
        stList.length = 0;
        stList.data = "";
    }
    else
    {
        stList.length = iIndex2 - iIndex1 + 1;
        stList.data = GetSubString(stList.data, iIndex1 * stList.itemsize, stList.length * stList.itemsize);
    }

    return stList;
}


// Merges stList1 and stList2 by appending all items of stList2 to stList1. Both
// lists must have the item size. Output list retains the list type of stList1.
// -stList1: first list structure
// -stList2: second list structure
// Return value: stList1 + stList2 (with MATH_LIST_TYPE_INVALID type on error).
struct list MATH_ListMerge(struct list stList1, struct list stList2);
struct list MATH_ListMerge(struct list stList1, struct list stList2)
{
    if(stList1.itemsize != stList2.itemsize)
    {
        return MATH_ListInit(MATH_LIST_TYPE_INVALID);
    }

    stList1.length += stList2.length;
    stList1.data += stList2.data;

    return stList1;
}


////////////////////////////////////////////////////////////////////////////////
// LIST ITEM ADDING FUNCTIONS //////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////


// Inserts sItem as the last item of stList. Attention: sItem is not validated.
// -stList: list structure
// -sItem: list item (preferably a result of MATH_ListItem* function call)
// Return value: extended stList.
struct list MATH_ListAppend(struct list stList, string sItem);
struct list MATH_ListAppend(struct list stList, string sItem)
{
    stList.length += 1;
    stList.data += sItem;

    return stList;
}


// Inserts sItem as the first item of stList. Attention: sItem is not validated.
// -stList: list structure
// -sItem: list item (preferably a result of MATH_ListItem* function call)
// Return value: extended stList.
struct list MATH_ListPrepend(struct list stList, string sItem);
struct list MATH_ListPrepend(struct list stList, string sItem)
{
    stList.length += 1;
    stList.data = sItem + stList.data;

    return stList;
}


// Inserts sItem at iIndex in stList. iIndex must must be in [-L, L) range where
// L is the length of stList. Attention: sItem is not validated.
// -stList: list structure
// -sItem: list item (preferably a result of MATH_ListItem* function call)
// -iIndex: list item index
// Return value: extended stList (with MATH_LIST_TYPE_INVALID type on error).
struct list MATH_ListInsert(struct list stList, string sItem, int iIndex);
struct list MATH_ListInsert(struct list stList, string sItem, int iIndex)
{
    if(iIndex < 0)
    {
        iIndex += stList.length;
        if(iIndex < 0)
        {
            return MATH_ListInit(MATH_LIST_TYPE_INVALID);
        }
    }
    else if(iIndex >= stList.length)
    {
        return MATH_ListInit(MATH_LIST_TYPE_INVALID);
    }

    stList.data = MATH_ListSlice(stList, 0, iIndex - 1, FALSE).data + sItem +
        MATH_ListSlice(stList, iIndex, stList.length - 1, FALSE).data;
    stList.length += 1;

    return stList;
}


////////////////////////////////////////////////////////////////////////////////
// LIST ITEM SETTING AND DELETING FUNCTIONS ////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////


// Replaces stList item at iIndex with sItem. iIndex must must be in [-L, L)
// range where L is the length of stList. Attention: sItem is not validated.
// -stList: list structure
// -sItem: list item (preferably a result of MATH_ListItem* function call)
// -iIndex: list item index
// Return value: updated stList (with MATH_LIST_TYPE_INVALID type on error).
struct list MATH_ListSet(struct list stList, string sItem, int iIndex);
struct list MATH_ListSet(struct list stList, string sItem, int iIndex)
{
    if(iIndex < 0)
    {
        iIndex += stList.length;
        if(iIndex < 0)
        {
            return MATH_ListInit(MATH_LIST_TYPE_INVALID);
        }
    }
    else if(iIndex >= stList.length)
    {
        return MATH_ListInit(MATH_LIST_TYPE_INVALID);
    }

    stList.data = MATH_ListSlice(stList, 0, iIndex - 1, FALSE).data + sItem +
        MATH_ListSlice(stList, iIndex + 1, stList.length - 1, FALSE).data;

    return stList;
}


// Swaps stList items at iIndex1 and iIndex2. iIndex1 and iIndex2 must be in
// [-L, L) range where L is the length of stList.
// -stList: list structure
// -iIndex1: first list item index
// -iIndex2: second list item index
// Return value: updated stList (with MATH_LIST_TYPE_INVALID type on error).
struct list MATH_ListSwap(struct list stList, int iIndex1, int iIndex2);
struct list MATH_ListSwap(struct list stList, int iIndex1, int iIndex2)
{
    if(iIndex1 < 0)
    {
        iIndex1 += stList.length;
        if(iIndex1 < 0)
        {
            return MATH_ListInit(MATH_LIST_TYPE_INVALID);
        }
    }
    else if(iIndex1 >= stList.length)
    {
        return MATH_ListInit(MATH_LIST_TYPE_INVALID);
    }
    if(iIndex2 < 0)
    {
        iIndex2 += stList.length;
        if(iIndex2 < 0)
        {
            return MATH_ListInit(MATH_LIST_TYPE_INVALID);
        }
    }
    else if(iIndex2 >= stList.length)
    {
        return MATH_ListInit(MATH_LIST_TYPE_INVALID);
    }

    if(iIndex1 == iIndex2)
    {
        return stList;
    }

    if(iIndex1 > iIndex2)
    {
        stList.data = MATH_ListSlice(stList, 0, iIndex2 - 1, FALSE).data +
            GetSubString(stList.data, iIndex1 * stList.itemsize, stList.itemsize) +
            MATH_ListSlice(stList, iIndex2 + 1, iIndex1 - 1, FALSE).data +
            GetSubString(stList.data, iIndex2 * stList.itemsize, stList.itemsize) +
            MATH_ListSlice(stList, iIndex1 + 1, stList.length - 1, FALSE).data;
    }
    else
    {
        stList.data = MATH_ListSlice(stList, 0, iIndex1 - 1, FALSE).data +
            GetSubString(stList.data, iIndex2 * stList.itemsize, stList.itemsize) +
            MATH_ListSlice(stList, iIndex1 + 1, iIndex2 - 1, FALSE).data +
            GetSubString(stList.data, iIndex1 * stList.itemsize, stList.itemsize) +
            MATH_ListSlice(stList, iIndex2 + 1, stList.length - 1, FALSE).data;
    }

    return stList;
}


// Deletes stList item at iIndex. iIndex must must be in [-L, L) range where L
// is the length of stList.
// -stList: list structure
// -iIndex: list item index
// Return value: shortened stList (with MATH_LIST_TYPE_INVALID type on error).
struct list MATH_ListDelete(struct list stList, int iIndex);
struct list MATH_ListDelete(struct list stList, int iIndex)
{
    if(iIndex < 0)
    {
        iIndex += stList.length;
        if(iIndex < 0)
        {
            return MATH_ListInit(MATH_LIST_TYPE_INVALID);
        }
    }
    else if(iIndex >= stList.length)
    {
        return MATH_ListInit(MATH_LIST_TYPE_INVALID);
    }

    stList.data = MATH_ListSlice(stList, 0, iIndex - 1, FALSE).data +
        MATH_ListSlice(stList, iIndex + 1, stList.length - 1, FALSE).data;
    stList.length -= 1;

    return stList;
}


// Deletes all items from stList. This function can be used to quickly create an
// empty list with the same type and item size as stList.
// -stList: list structure
// Return value: emptied stList.
struct list MATH_ListClear(struct list stList);
struct list MATH_ListClear(struct list stList)
{
    return MATH_ListInit(stList.type, stList.itemsize);
}


////////////////////////////////////////////////////////////////////////////////
// LIST INDEX MANIPULATION FUNCTIONS ///////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////


// Shifts all items of stList towards its end by iShift indexes and appends last
// iShift items at its start (wraps them around - no item is lost or replaced).
// If iShift is negative, direction of the roll is reversed (towards index 0).
// -stList: list structure
// -iShift: number of indexes to shift
// Return value: rolled stList.
struct list MATH_ListRoll(struct list stList, int iShift);
struct list MATH_ListRoll(struct list stList, int iShift)
{
    if(stList.length == 0)
    {
        return stList;
    }

    iShift = iShift % stList.length;

    if(iShift > 0)
    {
        stList.data = MATH_ListSlice(stList, stList.length - iShift, stList.length - 1, FALSE).data +
            MATH_ListSlice(stList, 0, stList.length - iShift - 1, FALSE).data;
    }
    else if(iShift < 0)
    {
        stList.data = MATH_ListSlice(stList, -iShift, stList.length - 1, FALSE).data +
            MATH_ListSlice(stList, 0, -iShift - 1, FALSE).data;
    }

    return stList;
}


// Reverses stList. Warning: this is an O(n) operation.
// -stList: list structure
// Return value: reversed stList.
struct list MATH_ListReverse(struct list stList);
struct list MATH_ListReverse(struct list stList)
{
    string sData;
    int i;

    for(i = stList.length; i >= 0; i--)
    {
        sData += GetSubString(stList.data, i * stList.itemsize, stList.itemsize);
    }

    stList.data = sData;

    return stList;
}


// Permutes stList by randomly changing indexes of its items. Warning: this is
// an O(n) operation.
// -stList: list structure
// Return value: randomized stList.
struct list MATH_ListShuffle(struct list stList);
struct list MATH_ListShuffle(struct list stList)
{
    string sData;
    int iLength;
    int iIndex;

    iLength = stList.length;

    while(iLength > 0)
    {
        iIndex = (Random(32768) << 16 | Random(32768) << 1 | Random(2)) % iLength;
        sData += GetSubString(stList.data, iIndex * stList.itemsize, stList.itemsize);
        stList.data = MATH_ListSlice(stList, 0, iIndex - 1, FALSE).data +
            MATH_ListSlice(stList, iIndex + 1, --iLength, FALSE).data;
    }

    stList.data = sData;

    return stList;
}


// Selects items of stList whose indexes are items of stListIndexes (a list of
// ints with every item in [-L, L) range where L is the length of stList). Not
// all stList indexes must to be present in stListIndexes and their multiple
// occurrences are allowed. Warning: this is an O(n) operation.
// -stList: list structure
// -stListIndexes: int list structure
// Return value: stList item subset (with MATH_LIST_TYPE_INVALID type on error).
struct list MATH_ListSelect(struct list stList, struct list stListIndexes);
struct list MATH_ListSelect(struct list stList, struct list stListIndexes)
{
    if(stList.length == 0)
    {
        return stList;
    }
    else if(stListIndexes.length == 0)
    {
        stList.length = 0;
        stList.data = "";
        return stList;
    }

    string sData;
    int iLength;
    int iIndex;
    int i;

    for(i = 0; i < stListIndexes.length; i++)
    {
        iIndex = StringToInt(GetSubString(stListIndexes.data,
            i * stListIndexes.itemsize, stListIndexes.itemsize));
        if(iIndex < 0)
        {
            iIndex += stList.length;
            if(iIndex < 0)
            {
                return MATH_ListInit(MATH_LIST_TYPE_INVALID);
            }
        }
        else if(iIndex >= stList.length)
        {
            return MATH_ListInit(MATH_LIST_TYPE_INVALID);
        }
        sData += GetSubString(stList.data, iIndex * stList.itemsize, stList.itemsize);
        iLength += 1;
    }

    stList.length = iLength;
    stList.data = sData;

    return stList;
}


////////////////////////////////////////////////////////////////////////////////
// LIST SEARCH FUNCTIONS ///////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////


// Returns index of iNumber-th occurrence of sItem in stList. Warning: this is
// an O(n) operation.
// -stList: list structure
// -sItem: list item (preferably a result of MATH_ListItem* function call)
// -iNumber: occurrence of sItem (1-based)
// Return value: index of iNumber-th sItem in stList, or -1 if it is not found.
int MATH_ListIndex(struct list stList, string sItem, int iNumber=1);
int MATH_ListIndex(struct list stList, string sItem, int iNumber=1)
{
    int iCount;
    int i;

    for(i = 0; i < stList.length; i++)
    {
        iCount += GetSubString(stList.data, i * stList.itemsize, stList.itemsize) == sItem;
        if(iCount == iNumber)
        {
            return i;
        }
    }

    return -1;
}


// Returns number of occurrences of sItem in stList. Warning: this is an O(n)
// operation.
// -stList: list structure
// -sItem: list item (preferably a result of MATH_ListItem* function call)
// Return value: number of sItem occurrences in stList.
int MATH_ListCount(struct list stList, string sItem);
int MATH_ListCount(struct list stList, string sItem)
{
    int iCount;
    int i;

    for(i = 0; i < stList.length; i++)
    {
        iCount += GetSubString(stList.data, i * stList.itemsize, stList.itemsize) == sItem;
    }

    return iCount;
}


////////////////////////////////////////////////////////////////////////////////
// LIST SORTING FUNCTIONS //////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////


// Sorts stList (a list of ints). Warning: this is an O(n log n) operation on
// average and O(n^2) in worst case. With current implementation it works only
// with small lists (safely up to 256 items, unsafely - 300).
// -stList: int list structure
// -iDescending: set to TRUE to sort in descending instead of ascending order
// Return value: sorted stList.
struct list MATH_ListSortInt(struct list stList, int iDescending=FALSE);
struct list MATH_ListSortInt(struct list stList, int iDescending=FALSE)
{
    if(stList.length <= 1)
    {
        return stList;
    }

    if(stList.length == 2)
    {
        string sLeft;
        string sRight;
        sLeft = GetSubString(stList.data, 0, stList.itemsize);
        sRight = GetSubString(stList.data, stList.itemsize, stList.itemsize);
        if(iDescending == (StringToInt(sLeft) < StringToInt(sRight)))
        {
            return MATH_ListReverse(stList);
        }
        else
        {
            return stList;
        }
    }

    struct list tLeft;
    struct list tCenter;
    struct list tRight;
    string sValue;
    int iPivot;
    int iValue;
    int i;

    iPivot = StringToInt(GetSubString(stList.data,
        (stList.length / 2) * stList.itemsize, stList.itemsize));

    for(i = 0; i < stList.length; i++)
    {
        sValue = GetSubString(stList.data, i * stList.itemsize, stList.itemsize);
        iValue = StringToInt(sValue);
        if(iValue == iPivot)
        {
            tCenter.data += sValue;
        }
        else if(iDescending == (iValue < iPivot))
        {
            tRight.data += sValue;
        }
        else
        {
            tLeft.data += sValue;
        }
    }

    tLeft.type = stList.type;
    tCenter.type = stList.type;
    tRight.type = stList.type;
    tLeft.itemsize = stList.itemsize;
    tCenter.itemsize = stList.itemsize;
    tRight.itemsize = stList.itemsize;
    tLeft.length = GetStringLength(tLeft.data) / stList.itemsize;
    tCenter.length = GetStringLength(tCenter.data) / stList.itemsize;
    tRight.length = GetStringLength(tRight.data) / stList.itemsize;

    tLeft = MATH_ListSortInt(tLeft, iDescending);
    tRight = MATH_ListSortInt(tRight, iDescending);

    tLeft.length += tCenter.length;
    tLeft.length += tRight.length;
    tLeft.data += tCenter.data;
    tLeft.data += tRight.data;

    return tLeft;
}


// Sorts stList (a list of ints), but instead of values, this function returns
// item indexes. For example, if stList item at index 0 would be placed at index
// 5 after sorting, the output list will have 0 at index 5. This can be used to
// sort other lists in accordance with sort order of stList. Warning: this is an
// O(n log n) operation on average and O(n^2) in worst case. Currently, it works
// only with small lists (safely up to 128 items, unsafely - 200).
// -stList: int list structure
// -stListIndexes: int list structure - MUST BE AN EMPTY LIST
// -iDescending: set to TRUE to sort in descending instead of ascending order
// Return value: stList indexes (with MATH_LIST_TYPE_INVALID type on error).
struct list MATH_ListArgSortInt(struct list stList, struct list stListIndexes, int iDescending=FALSE);
struct list MATH_ListArgSortInt(struct list stList, struct list stListIndexes, int iDescending=FALSE)
{
    if(stList.length == 0)
    {
        return MATH_ListInit(MATH_LIST_TYPE_INT, stListIndexes.itemsize);
    }

    int i;

    if(stListIndexes.length == 0)
    {
        for(i = 0; i < stList.length; i++)
        {
            stListIndexes.data += MATH_ListItemInt(i, stListIndexes.itemsize);
        }
        stListIndexes.length = stList.length;
    }
    else if(stList.length != stListIndexes.length)
    {
        return MATH_ListInit(MATH_LIST_TYPE_INVALID);
    }

    if(stList.length == 1)
    {
        return stListIndexes;
    }
    else if(stList.length == 2)
    {
        string sLeft;
        string sRight;
        sLeft = GetSubString(stList.data, 0, stList.itemsize);
        sRight = GetSubString(stList.data, stList.itemsize, stList.itemsize);
        if(iDescending == (StringToInt(sLeft) < StringToInt(sRight)))
        {
            return MATH_ListReverse(stListIndexes);
        }
        else
        {
            return stListIndexes;
        }
    }

    struct list tLeft1;
    struct list tCenter1;
    struct list tRight1;
    struct list tLeft2;
    struct list tCenter2;
    struct list tRight2;
    string sValue1;
    string sValue2;
    int iPivot;
    int iValue;

    iPivot = StringToInt(GetSubString(stList.data,
        (stList.length / 2) * stList.itemsize, stList.itemsize));

    for(i = 0; i < stList.length; i++)
    {
        sValue1 = GetSubString(stList.data,
            i * stList.itemsize, stList.itemsize);
        sValue2 = GetSubString(stListIndexes.data,
            i * stListIndexes.itemsize, stListIndexes.itemsize);
        iValue = StringToInt(sValue1);
        if(iValue == iPivot)
        {
            tCenter1.data += sValue1;
            tCenter2.data += sValue2;
        }
        else if(iDescending == (iValue < iPivot))
        {
            tRight1.data += sValue1;
            tRight2.data += sValue2;
        }
        else
        {
            tLeft1.data += sValue1;
            tLeft2.data += sValue2;
        }
    }

    tLeft1.type = stList.type;
    tCenter1.type = stList.type;
    tRight1.type = stList.type;
    tLeft1.itemsize = stList.itemsize;
    tCenter1.itemsize = stList.itemsize;
    tRight1.itemsize = stList.itemsize;
    tLeft1.length = GetStringLength(tLeft1.data) / stList.itemsize;
    tCenter1.length = GetStringLength(tCenter1.data) / stList.itemsize;
    tRight1.length = GetStringLength(tRight1.data) / stList.itemsize;

    tLeft2.type = stListIndexes.type;
    tCenter2.type = stListIndexes.type;
    tRight2.type = stListIndexes.type;
    tLeft2.itemsize = stListIndexes.itemsize;
    tCenter2.itemsize = stListIndexes.itemsize;
    tRight2.itemsize = stListIndexes.itemsize;
    tLeft2.length = GetStringLength(tLeft2.data) / stListIndexes.itemsize;
    tCenter2.length = GetStringLength(tCenter2.data) / stListIndexes.itemsize;
    tRight2.length = GetStringLength(tRight2.data) / stListIndexes.itemsize;

    tLeft2 = MATH_ListArgSortInt(tLeft1, tLeft2, iDescending);
    tRight2 = MATH_ListArgSortInt(tRight1, tRight2, iDescending);

    tLeft2.length += tCenter2.length;
    tLeft2.length += tRight2.length;
    tLeft2.data += tCenter2.data;
    tLeft2.data += tRight2.data;

    return tLeft2;
}


// Sorts stList (a list of floats). Warning: this is an O(n log n) operation on
// average and O(n^2) in worst case. With current implementation it works only
// with small lists (safely up to 256 items, unsafely - 300).
// -stList: float list structure
// -iDescending: set to TRUE to sort in descending instead of ascending order
// Return value: sorted stList.
struct list MATH_ListSortFloat(struct list stList, int iDescending=FALSE);
struct list MATH_ListSortFloat(struct list stList, int iDescending=FALSE)
{
    if(stList.length <= 1)
    {
        return stList;
    }

    if(stList.length == 2)
    {
        string sLeft;
        string sRight;
        sLeft = GetSubString(stList.data, 0, stList.itemsize);
        sRight = GetSubString(stList.data, stList.itemsize, stList.itemsize);
        if(iDescending == (StringToFloat(sLeft) < StringToFloat(sRight)))
        {
            return MATH_ListReverse(stList);
        }
        else
        {
            return stList;
        }
    }

    struct list tLeft;
    struct list tCenter;
    struct list tRight;
    string sValue;
    float fPivot;
    float fValue;
    int i;

    fPivot = StringToFloat(GetSubString(stList.data,
        (stList.length / 2) * stList.itemsize, stList.itemsize));

    for(i = 0; i < stList.length; i++)
    {
        sValue = GetSubString(stList.data, i * stList.itemsize, stList.itemsize);
        fValue = StringToFloat(sValue);
        if(fValue == fPivot)
        {
            tCenter.data += sValue;
        }
        else if(iDescending == (fValue < fPivot))
        {
            tRight.data += sValue;
        }
        else
        {
            tLeft.data += sValue;
        }
    }

    tLeft.type = stList.type;
    tCenter.type = stList.type;
    tRight.type = stList.type;
    tLeft.itemsize = stList.itemsize;
    tCenter.itemsize = stList.itemsize;
    tRight.itemsize = stList.itemsize;
    tLeft.length = GetStringLength(tLeft.data) / stList.itemsize;
    tCenter.length = GetStringLength(tCenter.data) / stList.itemsize;
    tRight.length = GetStringLength(tRight.data) / stList.itemsize;

    tLeft = MATH_ListSortFloat(tLeft, iDescending);
    tRight = MATH_ListSortFloat(tRight, iDescending);

    tLeft.length += tCenter.length;
    tLeft.length += tRight.length;
    tLeft.data += tCenter.data;
    tLeft.data += tRight.data;

    return tLeft;
}


// Sorts stList (a list of floats), but instead of values, this function returns
// item indexes. For example, if stList item at index 0 would be placed at index
// 5 after sorting, the output list will have 0 at index 5. This can be used to
// sort other lists in accordance with sort order of stList. Warning: this is an
// O(n log n) operation on average and O(n^2) in worst case. Currently, it works
// only with small lists (safely up to 128 items, unsafely - 200).
// -stList: float list structure
// -stListIndexes: int list structure - MUST BE AN EMPTY LIST
// -iDescending: set to TRUE to sort in descending instead of ascending order
// Return value: stList indexes (with MATH_LIST_TYPE_INVALID type on error).
struct list MATH_ListArgSortFloat(struct list stList, struct list stListIndexes, int iDescending=FALSE);
struct list MATH_ListArgSortFloat(struct list stList, struct list stListIndexes, int iDescending=FALSE)
{
    if(stList.length == 0)
    {
        return MATH_ListInit(MATH_LIST_TYPE_INT, stListIndexes.itemsize);
    }

    int i;

    if(stListIndexes.length == 0)
    {
        for(i = 0; i < stList.length; i++)
        {
            stListIndexes.data += MATH_ListItemInt(i, stListIndexes.itemsize);
        }
        stListIndexes.length = stList.length;
    }
    else if(stList.length != stListIndexes.length)
    {
        return MATH_ListInit(MATH_LIST_TYPE_INVALID);
    }

    if(stList.length == 1)
    {
        return stListIndexes;
    }
    else if(stList.length == 2)
    {
        string sLeft;
        string sRight;
        sLeft = GetSubString(stList.data, 0, stList.itemsize);
        sRight = GetSubString(stList.data, stList.itemsize, stList.itemsize);
        if(iDescending == (StringToFloat(sLeft) < StringToFloat(sRight)))
        {
            return MATH_ListReverse(stListIndexes);
        }
        else
        {
            return stListIndexes;
        }
    }

    struct list tLeft1;
    struct list tCenter1;
    struct list tRight1;
    struct list tLeft2;
    struct list tCenter2;
    struct list tRight2;
    string sValue1;
    string sValue2;
    float fPivot;
    float fValue;

    fPivot = StringToFloat(GetSubString(stList.data,
        (stList.length / 2) * stList.itemsize, stList.itemsize));

    for(i = 0; i < stList.length; i++)
    {
        sValue1 = GetSubString(stList.data,
            i * stList.itemsize, stList.itemsize);
        sValue2 = GetSubString(stListIndexes.data,
            i * stListIndexes.itemsize, stListIndexes.itemsize);
        fValue = StringToFloat(sValue1);
        if(fValue == fPivot)
        {
            tCenter1.data += sValue1;
            tCenter2.data += sValue2;
        }
        else if(iDescending == (fValue < fPivot))
        {
            tRight1.data += sValue1;
            tRight2.data += sValue2;
        }
        else
        {
            tLeft1.data += sValue1;
            tLeft2.data += sValue2;
        }
    }

    tLeft1.type = stList.type;
    tCenter1.type = stList.type;
    tRight1.type = stList.type;
    tLeft1.itemsize = stList.itemsize;
    tCenter1.itemsize = stList.itemsize;
    tRight1.itemsize = stList.itemsize;
    tLeft1.length = GetStringLength(tLeft1.data) / stList.itemsize;
    tCenter1.length = GetStringLength(tCenter1.data) / stList.itemsize;
    tRight1.length = GetStringLength(tRight1.data) / stList.itemsize;

    tLeft2.type = stListIndexes.type;
    tCenter2.type = stListIndexes.type;
    tRight2.type = stListIndexes.type;
    tLeft2.itemsize = stListIndexes.itemsize;
    tCenter2.itemsize = stListIndexes.itemsize;
    tRight2.itemsize = stListIndexes.itemsize;
    tLeft2.length = GetStringLength(tLeft2.data) / stListIndexes.itemsize;
    tCenter2.length = GetStringLength(tCenter2.data) / stListIndexes.itemsize;
    tRight2.length = GetStringLength(tRight2.data) / stListIndexes.itemsize;

    tLeft2 = MATH_ListArgSortFloat(tLeft1, tLeft2, iDescending);
    tRight2 = MATH_ListArgSortFloat(tRight1, tRight2, iDescending);

    tLeft2.length += tCenter2.length;
    tLeft2.length += tRight2.length;
    tLeft2.data += tCenter2.data;
    tLeft2.data += tRight2.data;

    return tLeft2;
}
