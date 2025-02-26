#NoEnv
#SingleInstance, Force
SendMode, Input
SetBatchLines, -1
SetWorkingDir, %A_ScriptDir%

getPixelColor() {
    MouseGetPos, mouseX, mouseY
    PixelGetColor, color, %mouseX%, %mouseY%
    clipboard := "Coordinates: " . mouseX . ", " . mouseY . " Color: " . color
}

; offsets the mouse to get around the tooltip
getBuffPixelColor() {
    MouseGetPos, mouseX, mouseY
    offsetX := 5  ; Adjust this value to set the desired offset in pixels
    newX := mouseX + offsetX  ; Calculate the new X-coordinate before passing it
    PixelGetColor, color, %newX%, %mouseY%
    clipboard := "Coordinates: " . newX . ", " . mouseY . " Color: " . color
}
