set wsc = CreateObject("WScript.Shell")
Do
	wsc.SendKeys("{NUMLOCK}")
	wsc.SendKeys("{NUMLOCK}")
	WScript.Sleep(3*60*1000)
Loop