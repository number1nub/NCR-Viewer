OpenNcr(id)
{
	try Run, % "INFOPATH.exe """ ncrs[id].path """"
	catch e
		m("An error occurred while trying to open the NCR in InfoPath.`n`n" e.message, "!")
}