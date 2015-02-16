LoadNcrs(ncrPath, closed="", archive="")
{
	static ETA, Progress, Elapsed
	tmp := []
	total := GetNcrFileCount(ncrPath)
	
	Gui, Prog:Default
	Gui, +AlwaysOnTop +ToolWindow
	Gui, Font, s18
	Gui, Add, Text,, Loading NCRs...
	Gui, Font, s10
	Gui, Add, Text,, ETA:
	Gui, Add, Text, yp x+5 vETA, 0:00:00
	Gui, Add, Progress, xm w500 h50 cGreen vProgress Range1-%total%
	Gui, Add, Text, xm, Processed:
	Gui, Add, Text, vElapsed x+5 w20, 0
	Gui, add, text, x+1, / %total%
	Gui, Show

	StartTime := A_TickCount
	Loop, %ncrPath%\*.xml
	{
		FileRead, v, %A_LoopFileFullPath%
		RegExMatch(v, "i)<my:NCRstatus>(.+)</my:NCRstatus>", stat)
		RegExMatch(v, "i)<my:NCRUniqueID>(\d+)</my:NCRUniqueID>", id)
		RegExMatch(v, "i)<my:FCRRequested>(.+)</my:FCRRequested>", rept)
		if ((stat1 = "Closed" && !closed) || (stat1 = "Archive" && !archive))
			Continue			
		tmp[id1] := { state: stat1, name: A_LoopFileName, path: A_LoopFileFullPath, report: (rept1="true" ? 1 : 0) }
		
		GuiControl,,Progress, %A_Index%
		time := A_TickCount - StartTime
		SumX += A_Index
		SumY += time
		SumXY += A_Index * time
		SumX2 += A_Index**2
		m := (A_Index * SumXY - SumX * SumY) / (A_Index * SumX2 - SumX**2)
		b := (SumY - m * SumX) / A_Index
		ETA := (m * total + b) - (m * A_Index + b)
		T := A_Year
		T += ETA/1000, Seconds
		el += sumY/1000, Seconds
		FormatTime, ETA, %T%, H:mm:ss
		GuiControl,,ETA, %ETA%
		GuiControl,,Elapsed, %A_Index%
	}
	;m(A_TickCount - StartTime)
	Gui, Prog:Destroy
	return tmp

	ProgGuiClose:
		MsgBox, 4404, Are you sure??, Abort loading NCRs and exit?
		IfMsgBox, Yes
			ExitApp
	return
}