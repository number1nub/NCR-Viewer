GetNcrFileCount(ncrPath)
{
	loop, %ncrPath%\*.xml
		total := A_Index
	return total
}