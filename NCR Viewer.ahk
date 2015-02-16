#NoEnv
#SingleInstance, Force
SetWorkingDir, %A_ScriptDir%

global ncrs:=[]
ncrPath     := "\\hplynx.hpinc.com\DavWWWRoot\sites\tv\operations\OperationsNonConformance"
initFilter  := { attrib:"state", crit:"Assignment"}
custFilters := {"Final Report Required": {attrib:"report", crit:1}, "All": {}}
ncrs        := LoadNcrs(ncrPath)

Gui, 1:Default
Gui, +AlwaysOnTop +Resize +MinSize
Gui, Add, Radio, xm w45 h35 +0x1000 +0x8000 gStateSelect, All
Gui, Add, Radio, x+5 w80 h35 +0x1000 +0x8000 gStateSelect +Checked, Assignment
Gui, Add, Radio, x+5 w80 h35 +0x1000 +0x8000 gStateSelect, WIP - Eng
Gui, Add, Radio, x+5 w80 h35 +0x1000 +0x8000 gStateSelect, WIP - Ops
Gui, Add, Radio, x+5 w80 h35 +0x1000 +0x8000 gStateSelect, WIP - Mfg
Gui, Add, Radio, x+5 w80 h35 +0x1000 +0x8000 gStateSelect, Final Review
Gui, Add, Radio, x+5 w80 h35 +0x1000 +0x8000 gStateSelect, Final Report Required
Gui, Add, ListView, xm y+10 w555 h305 +Sort +AltSubmit +LV0x20 +LV0x1 vncrList gncrList_Click hwndncrListID, Id|Rpt|Name|State
Gui, Add, Button, x230 y+10 w100 h40 +Default +0xC00 +0x8000 vbtnOpenNcr hwndbtnOpenNcrID, Open NCR
Gui, Add, StatusBar,, % "Total Open NCRs: " GetNcrCount(ncrs)
SB_SetParts(150)
InsertRows(FilterNcrs(initFilter))
Gui, Show,, NCR Viewer
return


StateSelect:
	if (IsObject(custFilters[A_GuiControl]))
		InsertRows(FilterNcrs(custFilters[A_GuiControl]))
	else
		InsertRows(FilterNcrs("state", A_GuiControl))
	GuiControl, % "Enable" (LV_GetNext() ? 1 : 0), btnOpenNcr
return


ncrList_Click:
	if (A_GuiEvent != "DoubleClick")
	{
		GuiControl, % "Enable" (LV_GetNext() ? 1 : 0), btnOpenNcr
		return
	}
	buttonOpenNCR:
	curRow := LV_GetNext()
	if (!curRow)
		return
	LV_GetText(selID, curRow, 1)
	OpenNcr(selID)
return


GuiSize:
	Anchor(ncrListID, "wh")
	Anchor(btnOpenNcrID, "x.5y")
return

GuiClose:
ExitApp


#Include LoadNcrs.ahk
#Include m.ahk
#Include InsertRows.ahk
#Include GetNcrCount.ahk
#Include Anchor.ahk
#Include OpenNcr.ahk
#Include FilterNcrs.ahk