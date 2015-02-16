m(txt, ico="", title="")
{
	MsgBox, % ico="i" ? 4160 : ico="!" ? 4144 : ico="?" ? 4128 : ico="x" ? 4112 : 4096, %title%, %txt%
}