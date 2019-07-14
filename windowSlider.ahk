; Set coord mode to the entire screen instead of active window
CoordMode, Mouse , Screen

; Initialize empty object for monitor information
Monitors := Array()

; Get monitor count
SysGet, count, MonitorCount

; gets monitor screen area coordinates stored into an object and saved to an array
Loop, %count% {
    SysGet, workArea, MonitorWorkArea, %A_Index%
    Monitors.push({"left": workAreaLeft, "right": workAreaRight, "top": workAreaTop, "bottom": workAreaBottom})
}

^`::
InputBox, display, Choose Display, Please choose a display as you have %count% displays:, , 350, 130
if (display < 1) or (display > count) {
    msgBox, Bad input: %display%
    Return
}

monitor := Monitors[display]
; MouseMove, monitor["left"], monitor["top"], 100
; WinMove, Task Manager, ,monitor["left"], monitor["top"]
; WinMove, monitor["left"], monitor["top"]
WinMove, 0, 0
Return

^Esc::
ExitApp

^r::
Reload
Return