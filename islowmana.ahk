#NoEnv
#SingleInstance, Force
SendMode, Input
SetBatchLines, -1
SetWorkingDir, %A_ScriptDir%

isLowMana() {
    PixelGetColor, color, 270, 148
    ; Strip the 0x prefix and convert to integer
    colorNum := SubStr(color, 3)
    ; Extract RGB values 
    red := "0x" . SubStr(colorNum, 1, 2)
    green := "0x" . SubStr(colorNum, 3, 2)
    blue := "0x" . SubStr(colorNum, 5, 2)
    
    ; Check if color is very dark (close to black)
    return (red < 0x10 && green < 0x10 && blue < 0x10)
}

tryPrayerfulRest() {
    ; Prayerful Rest Availability Check
    prayerfulRestAvailable := true

    PixelGetColor, color1, 762, 949
    if (color1 != 0x488FAB) {
        prayerfulRestAvailable := false
    }

    PixelGetColor, color2, 755, 930
    if (color2 != 0x39718C) {
        prayerfulRestAvailable := false
    }

    PixelGetColor, color3, 763, 949
    if (color3 != 0x356F8C) {
        prayerfulRestAvailable := false
    }

    ; Check if low mana and Prayerful Rest is available
    if (isLowMana() && prayerfulRestAvailable) {
        press("2", "alt")
    }
}



