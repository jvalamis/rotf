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
    Sleep, 50  ; Longer delay to ensure clean state

    if (modifier = "shift") {
        ; Hold shift longer and use Blind
        SendInput, {Blind}{LShift down}
        Sleep, 50
        SendInput, {Blind}{%key%}
        Sleep, 50
        SendInput, {LShift up}
    } else if (modifier = "alt") {
        ; Hold alt longer and use Blind
        SendInput, {Blind}{LAlt down}
        Sleep, 50
        SendInput, {Blind}{%key%}
        Sleep, 50
        SendInput, {LAlt up}
    } else {
        ; Just press the key normally
        SendInput, {%key% down}
        Sleep, 30
        SendInput, {%key% up}
    }

    ; Make sure all modifiers are released
    SendInput, {LShift up}{RShift up}{LAlt up}{RAlt up}{LCtrl up}{RCtrl up}
    Sleep, 50
}

