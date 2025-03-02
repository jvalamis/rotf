#NoEnv
#SingleInstance Ignore
#MaxThreadsPerHotkey 1
Process, Priority, , High
SendMode Input
SetBatchLines -1
Thread, interrupt, 0

; Release all modifiers at startup
SendInput, {LShift up}{RShift up}{LAlt up}{RAlt up}{LCtrl up}{RCtrl up}

#Include %A_ScriptDir%\press.ahk
#Include %A_ScriptDir%\getpixelcolor.ahk
#Include %A_ScriptDir%\islowmana.ahk
#Include %A_ScriptDir%\getdebuffcoordinates.ahk
#Include %A_ScriptDir%\getskillcoordinates.ahk
#Include %A_ScriptDir%\smartdebuff.ahk
#Include %A_ScriptDir%\partybars.ahk
#Include %A_ScriptDir%\shieldself.ahk
#Include %A_ScriptDir%\mousemove.ahk
#Include %A_ScriptDir%\screencapture.ahk

; Release modifiers after x key press
press("x")
SendInput, {LShift up}{RShift up}{LAlt up}{RAlt up}{LCtrl up}{RCtrl up}

farm() {
    moveMouse(708, 893)  ; Move to first coordinate
    sleep 100
    click
    sleep 50
    moveMouse(827, 657)  ; Move to second coordinate
    click

    press("3")
    press("6")
    press("3", "shift")
    ; tryPrayerfulRest()
    press("3")
    press("e", "shift")
    press("2")

    ; healParty()
    ; tryPrayerfulRest()
}

technique() {
    moveMouse(708, 893)  ; Move to first coordinate
    sleep 100
    click
    sleep 50
    moveMouse(827, 657)  ; Move to second coordinate
    click
    
    press("1", "alt")
    press("4", "alt")
    press("3", "alt")
}

; craft() {
;     global toggle := false
;     loop {
;     if (toggle) {
;         toggle := true
;         break
;     }

;         click
;         sleep 1000
;     }
; }

`::farm()
; +e::craft()
; e::partybars()


; utility keys
F7::getDebuffSlotColors()
F8::getBuffPixelColor()
F9::getPixelColor()
; F10::getTechniquePixels()
F10::technique()
F12::captureScreen()

; debug key
; F11::isWeaknessReady()

reload() {
    ; Release modifiers before reload
    SendInput, {LShift up}{RShift up}{LAlt up}{RAlt up}{LCtrl up}{RCtrl up}
    Sleep, 20
    Reload 
}

Esc::reload()
