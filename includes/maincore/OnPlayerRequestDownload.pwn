new SERVER_DOWNLOAD[] = "https://media.rg-rp.org/models";
public OnPlayerRequestDownload(playerid, type, crc)
{
	if(!IsPlayerConnected(playerid))
	return 0;

	new filename[64], filefound, final_url[256];

	if(type == DOWNLOAD_REQUEST_TEXTURE_FILE)
		filefound = FindTextureFileNameFromCRC(crc, filename, sizeof(filename));
 	else if(type == DOWNLOAD_REQUEST_MODEL_FILE)
		filefound = FindModelFileNameFromCRC(crc, filename, sizeof(filename));

	if(filefound)
	{
		format(final_url, sizeof(final_url), "%s/%s", SERVER_DOWNLOAD, filename);
		RedirectDownload(playerid, final_url);
	}
	return 1;
}
public OnPlayerFinishedDownloading(playerid, virtualworld)
{
	if(gPlayerLogged{playerid} != 0) return true;
	{
	    SendClientMessage(playerid, COLOR_GREEN, "[SERVER] Downloads finished, you can now log in.");
	}
    return 1;
}
