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
Return

^Esc::
ExitApp

^r::
Reload
Return