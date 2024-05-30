////////////////////////////////////////////
///////////////                        /////
/////////////// This is made by 187    /////
/////////////// DO NOT REMOVE THIS     /////
////////////////////////////////////////////
#include <YSI\y_hooks>
CMD:points(playerid, params[])
{
	szMiscArray[0] = 0;

	for(new i; i < MAX_POINTS; i++)
	{
		if(strcmp(DynPoints[i][poName], "NULL", true) != 0) {
			if(DynPoints[i][poID] != 0)
			{
				if (DynPoints[i][poType] >= 0)
				{
					if(DynPoints[i][poLocked] != 1)
					{
						if((0 <= DynPoints[i][poCaptureGroup] < MAX_GROUPS)) {
							format(szMiscArray, sizeof(szMiscArray), "%s {8B0000}Name: {FFFFFF}%s{8B0000} | Owner: {%s}%s{8B0000} | Captured By: {FFFFFF}%s{8B0000} | Hours: {FFFFFF}%d\n", szMiscArray, DynPoints[i][poName],Group_NumToDialogHex(arrGroupData[DynPoints[i][poCaptureGroup]][g_hDutyColour]),arrGroupData[DynPoints[i][poCaptureGroup]][g_szGroupName],DynPoints[i][poCaptureName],DynPoints[i][poTimer]);
						}
						else {
							format(szMiscArray, sizeof(szMiscArray), "%s {8B0000}Name: {FFFFFF}%s{8B0000} | Owner: {FFFFFF}Nobody{8B0000} | Captured By: {FFFFFF}Nobody{8B0000} | Hours: {FFFFFF}%d\n", szMiscArray, DynPoints[i][poName], DynPoints[i][poTimer]);
						}

					}
				}
			}
		}
	}
	ShowPlayerDialogEx(playerid, 0, DIALOG_STYLE_MSGBOX, "{8B0000}Points List", szMiscArray, "Close", "");
	return 1;
}
hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[]) {
    if(arrAntiCheat[playerid][ac_iFlags][AC_DIALOGSPOOFING] > 0) return 1;

    if (dialogid == 0) {
        if (response) {
            return 1;
        }
    }
    return 1;
}
