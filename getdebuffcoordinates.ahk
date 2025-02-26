#NoEnv
#SingleInstance, Force
SendMode, Input
SetBatchLines, -1
SetWorkingDir, %A_ScriptDir%

; debuffs follow the same pattern as regular buffs longest debuff on the right to the left
; this function checks the coordinates on my specific debuffs above my specific target 
; change for yours
; get debuff slot colors only using 2 slots right now
getDebuffSlotColors() {
    ; Slot 1 Coordinates
    slot1 := []
    slot1.Push({x: 841, y: 571})
    slot1.Push({x: 847, y: 563})
    slot1.Push({x: 842, y: 566})

    ; Slot 2 Coordinates
    slot2 := []
    slot2.Push({x: 804, y: 571})
    slot2.Push({x: 806, y: 564})
    slot2.Push({x: 811, y: 561})

    output := ";slot1`n"
    for i, coord in slot1 {
        PixelGetColor, color, % coord.x, % coord.y
        output .= "Coordinates: " . coord.x . ", " . coord.y . " Color: " . color . "`n"
    }

    output .= "`n;slot2`n"
    for i, coord in slot2 {
        PixelGetColor, color, % coord.x, % coord.y
        output .= "Coordinates: " . coord.x . ", " . coord.y . " Color: " . color . "`n"
    }

    clipboard := output
}