; BEFORE RUNNING THIS SCRIPT, MAKE SURE TO CREATE A FOLDER CALLED images AT THE SAME LEVEL AS THIS SCRIPT AND PUT PNG IMAGES IN IT

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

; Gets a list of png files from the images folder
imageList := Array()
Loop, images\*.png {
    imageList.Push(A_LoopFileLongPath)
}

^`::
; Ask for which monitor if multiple monitors are detected, otherwise default to single monitor
if (count > 1) {
    InputBox, display, Choose Display, Please choose a display as you have %count% displays:, , 350, 130
    if (display < 1) or (display > count) {
        msgBox, Bad input: %display%
        Return
    }
    monitor := Monitors[display]
}
else {
    monitor := Monitors[1]
}

; SplashImage, images\red.png, BW100H100, , , Frame1
; WinGetPos, X, Y, , , ImageHandleFrame
; WinMove, Frame1, , 100, 0
; MsgBox, %X%, %Y%

Directions := Array()

for index, element in imageList {
    title := "Frame" . index
    ; Generate random position on screen
    Random, winX, monitor["left"], monitor["right"] - 100
    Random, winY, monitor["top"] + 100, monitor["bottom"] - 100
    SplashImage, %index%:%element%, BW100H100X%winX%Y%winY%, , , %index%

    ; Generate random direction for squares
    Random, x, -1, 1
    Random, y, -1, 1

    ; remove any 0 if random selected it
    if (x == 0) {
        x = 1
    }
    if ( y == 0 ) {
        y = 1
    }
    Directions.Push({"x": x, "y": y})
}

Loop {
    for index, direction in Directions {
        WinGetPos, X, Y, , , %index%
        if (X <= monitor["left"]) or (X + 100 >= monitor["right"])
            Directions[index]["x"] := Directions[index]["x"] * -1
        
        if (Y <= monitor["top"]) or (Y + 100 >= monitor["bottom"])
            Directions[index]["y"] := Directions[index]["y"] * -1
        ; MsgBox, %X%, %Y%
        WinMove, %index%, , X + direction["x"], Y + direction["y"]
    }
}



; WinMove, 1, , 0, 0
; WinMove, 2, , 100, 500

Return

^Esc::
ExitApp

^r::
Reload
Return