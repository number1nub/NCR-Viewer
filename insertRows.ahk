InsertRows(ncrObj)
{
	LV_Delete()
	for id, ncr in ncrObj
		LV_Add("", id, ncr.report ? "Y" : "", ncr.name, ncr.state)
	LV_ModifyCol()
	SB_SetText("Showing: " GetNcrCount(ncrObj), 2)
}