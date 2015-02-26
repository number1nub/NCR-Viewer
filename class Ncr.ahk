class Ncr
{
	t := new this.NcrTags()
	
	__New(path)
	{
		temp:=ComObjCreate("MSXML2.DOMDocument")
		temp.load(path)		
		if (this.tag(this.t.Status, temp)="Closed" || this.tag(this.t.Status, temp)="Archive")
			return temp:=1
		this.xml := temp
		temp := ""
	}
	
	__Call(p, v*)
	{
		if (x := this.t[p])
			return this.tag(x)
	}
	
	tag(name, x="")
	{
		x := x ? x : this.xml
		return x.getElementsByTagName(name).item(0).text
	}
		
	class NcrTags
	{
		static ID            := "my:NCRUniqueID"
		static Title         := "my:NCR_Title"
		static Job           := "my:TVDS_Number"
		static Status        := "my:NCRstatus"
		static RSS           := "my:RssNo"
		static BHA           := "my:RunNo"
		static AssignedTo    := "pc:DisplayName"
		static FinalReport   := "my:FCRRequested"
		static EquipLocation := "my:EquipLocation"
		static OpsComments   := "my:OpsOfficeComments"
		static EngComments   := "my:EngOfficeComments"
		static CloseNotes    := "my:CloseoutNotes"
		static Analysis      := "my:AnalysisEvent"
		static Findings      := "my:DetailsLoss"
		static RootCause     := "my:RootCause"
		static RecActions    := "my:ActionsPreventReoccurrence"
	}
}