GetNcrCount(ncrObj)
{
	for id, ncr in ncrObj
		ncrCount++
	return ncrCount
}

GetNcrFileCount(ncrPath)
{
	loop, %ncrPath%\*.xml
		total := A_Index
	return total
}
