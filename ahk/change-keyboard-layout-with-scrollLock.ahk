ScrollLock::
{
	; toggle layouts!

	; scroll lock state check?

	; remember current layout
	CurrentLayout := DllCall()

	; set layout defined in script (scroll locked layout)
	Locale=00000409
	DllCall("SendMessage", UInt, WinActive("A"), UInt, 80, UInt, 1,UInt, DllCall("LoadKeyboardLayout", Str, %Locale%, UInt, 257))
}
Return