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
    ; SendInput, {Blind}{LShift down}{Blind}{LAlt down}{Blind}{LCtrl down} 
    ; sleep 10
    ; SendInput, {LShift up}{LAlt up}{LCtrl up}  ; Ensure no modifier keys are stuck

    if (modifier = "shift") {
        SendInput, {Blind}{LShift down}
        Sleep, 20  ; Small delay for key registration
        SendInput, {%key%}
        Sleep, 20
        SendInput, {LShift up}
    } else if (modifier = "alt") {
        SendInput, {Blind}{LAlt down}
        Sleep, 20
        SendInput, {%key%}
        Sleep, 20
        SendInput, {LAlt up}
    } else {
        SendInput, {%key% down}
        Sleep, 20
        SendInput, {%key% up}
    }

    ; SendInput, {Blind}{LShift down}{Blind}{LAlt down}{Blind}{LCtrl down} 
    ; sleep 10
    ; SendInput, {LShift up}{LAlt up}{LCtrl up}  ; Ensure no modifier keys are stuck
}

