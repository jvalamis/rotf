#NoEnv
#SingleInstance, Force
SendMode, Input
SetBatchLines, -1
SetWorkingDir, %A_ScriptDir%

#Include %A_ScriptDir%\mousemove.ahk

; targetHpBar := Coordinates: 603, 637 Color: 0x2CFF03

; me Coordinates: 273, 107 
; f2 Coordinates: 173, 256 
; f3 Coordinates: 179, 338 
; f4 Coordinates: 184, 436 
; f5 Coordinates: 169, 523 
; ; no tank coords

targetNeedsHeal(x, y) {
    static hdc := DllCall("GetDC", "UInt", 0)
    color := DllCall("GetPixel", "UInt", hdc, "Int", x, "Int", y, "UInt")

    ; Extract RGB components
    r := (color & 0xFF0000) >> 16
    g := (color & 0x00FF00) >> 8
    b := (color & 0x0000FF)

    threshold := 32
    return (r <= threshold && g <= threshold && b <= threshold)  ; Returns true if the target is in black range
}

healTarget(x, y) {
    moveMouse(x, y)
    DllCall("mouse_event", "UInt", 0x02, "UInt", 0, "UInt", 0, "UInt", 0, "UInt", 0)  ; Left Down
    DllCall("mouse_event", "UInt", 0x04, "UInt", 0, "UInt", 0, "UInt", 0, "UInt", 0)  ; Left Up
    ; Sleep, 1000  ; Allow target switch

    if (targetNeedsHeal(605, 636)) {  ; Checking if target's HP bar is black
        press("1")
        press("1")
    }
}

healParty() {
    healTarget(273, 107)  ; Me
    ; sleep 10
    healTarget(173, 256)  ; F2
    ; sleep 10  
    healTarget(179, 338)  ; F3
    ; sleep 10
    healTarget(184, 436)  ; F4
    ; sleep 10
    healTarget(169, 523)  ; F5
    ; sleep 10
}