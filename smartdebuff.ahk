#NoEnv
#SingleInstance, Force
SendMode, Input
SetBatchLines, -1
SetWorkingDir, %A_ScriptDir%

#Include %A_ScriptDir%\press.ahk


smartdebuff() {
    ; Slot 1 (Weakness) Expected Colors - Updated
    slot1 := [{x: 841, y: 571, color: 0x100803}, {x: 847, y: 563, color: 0x5C2200}, {x: 842, y: 566, color: 0x7E422D}]

    ; Slot 2 (Open Gap) Expected Colors
    slot2 := [{x: 804, y: 571, color: 0x1F2020}, {x: 806, y: 564, color: 0x1F1E1F}, {x: 811, y: 561, color: 0x808482}]

    ; Updated Weakness Ready Check
    weaknessX := [892, 905, 897]
    weaknessY := [1017, 1024, 1031]
    weaknessColors := [0x532F0F, 0x281407, 0xE45507]

    ; Open Gap Ready Check
    openGap := [{x: 864, y: 944, color: 0x290918}, {x: 872, y: 933, color: 0x4A0421}, {x: 886, y: 948, color: 0x200416}]

    ; Check if Weakness is in Slot 1
    weaknessInSlot1 := true
    for i, coord in slot1 {
        PixelGetColor, color, % coord.x, % coord.y
        if (color != coord.color) {
            weaknessInSlot1 := false
            break
        }
    }

    ; Check if Weakness is Ready (using updated coordinates)
    weaknessReady := true
    loop, 3 {
        PixelGetColor, color, % weaknessX[A_Index], % weaknessY[A_Index]
        if (color != weaknessColors[A_Index]) {
            weaknessReady := false
            break
        }
    }

    ; If Weakness is missing from Slot 1 and it's ready → Press "4"
    if (!weaknessInSlot1 && weaknessReady) {
        press("4")
        return  ; Stop here, don't check Open Gap
    }

    ; Check if Open Gap is in Slot 2 (Only if Weakness is already in Slot 1)
    openGapInSlot2 := true
    for i, coord in slot2 {
        PixelGetColor, color, % coord.x, % coord.y
        if (color != coord.color) {
            openGapInSlot2 := false
            break
        }
    }

    ; Check if Open Gap is Ready
    openGapReady := true
    for i, coord in openGap {
        PixelGetColor, color, % coord.x, % coord.y
        if (color != coord.color) {
            openGapReady := false
            break
        }
    }

    ; If Open Gap is missing from Slot 2 and it's ready → Press "4" with "alt"
    if (!openGapInSlot2 && openGapReady) {
        press("4", "alt")
    }
}










