#NoEnv
#SingleInstance, Force
SendMode, Input
SetBatchLines, -1
SetWorkingDir, %A_ScriptDir%

; press(key, modifier := "") {
;     SendInput, {LShift up}{LAlt up}{LCtrl up}
;     if (modifier = "shift") {
;         Send, {Blind}{LShift down}
;         Sleep 50
;         Send, {%key%}
;         Sleep 50
;         Send, {LShift up}
;     } else if (modifier = "alt") {
;         Send, {Blind}{LAlt down}
;         Sleep 50
;         Send, {%key%}
;         Sleep 50
;         Send, {LAlt up}
;     } else {
;         SendInput, {%key% down}
;         Sleep 50
;         SendInput, {%key% up}
;     }
;     SendInput, {LShift up}{LAlt up}{LCtrl up}
; }

press(key, modifier := "") {
    ; First release all modifiers to ensure clean state
    SendInput, {LShift up}{RShift up}{LAlt up}{RAlt up}{LCtrl up}{RCtrl up}
    Sleep, 20

    if (modifier = "shift") {
        ; Hold shift, press key twice, release shift
        SendInput, {LShift down}
        Sleep, 20
        SendInput, {%key%}
        Sleep, 20
        SendInput, {%key%}  ; Send key twice to ensure it registers
        Sleep, 20
        SendInput, {LShift up}
    } else if (modifier = "alt") {
        ; Hold alt, press key twice, release alt
        SendInput, {LAlt down}
        Sleep, 20
        SendInput, {%key%}
        Sleep, 20
        SendInput, {%key%}  ; Send key twice to ensure it registers
        Sleep, 20
        SendInput, {LAlt up}
    } else {
        ; Just press the key normally
        SendInput, {%key% down}
        Sleep, 20
        SendInput, {%key% up}
    }

    ; Make sure all modifiers are released
    SendInput, {LShift up}{RShift up}{LAlt up}{RAlt up}{LCtrl up}{RCtrl up}
    Sleep, 20
}

