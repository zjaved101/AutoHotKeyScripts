; IF SCRIPT DOES NOT WORK, TRY SETTING AHK TO HAVE ADMIN PRIVELEGES

; removes any delay after window command
SetWinDelay, -1

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
; asks for which monitor only if it detects more than one
if (count > 1) {
    InputBox, display, Choose Display, Please choose a display as you have %count% displays:, , 350, 130
    if (display < 1) or (display > count) or (display is not Integer) {
        msgBox, Bad input: %display%
        Return
    }
    monitor := Monitors[display]
}
else {
    monitor := Monitors[1]
}

x := monitor["left"]
Loop {
    y := monitor["top"]
    Loop, % monitor["bottom"] {
        WinWait, Task Manager
        WinMove, Task Manager, , %x%, %y%
        y := y + 1
        Sleep, .01
    }
}
Return

^Esc::
ExitApp

^r::
Reload
Return