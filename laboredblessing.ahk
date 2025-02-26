#NoEnv
#SingleInstance, Force
SendMode, Input
SetBatchLines, -1
SetWorkingDir, %A_ScriptDir%

tryLaboredBlessing() {
    pixelMatch := true

    ; Check first pixel
    PixelGetColor, color1, 694, 934
    if (color1 != 0x8F5B72) {
        pixelMatch := false
    }

    ; Check second pixel
    PixelGetColor, color2, 708, 948
    if (color2 != 0xBC6161) {
        pixelMatch := false
    }

    ; Check third pixel
    PixelGetColor, color3, 704, 929
    if (color3 != 0xD7C4A9) {
        pixelMatch := false
    }

    ; If all pixels match, press "1" with "alt"
    if (pixelMatch) {
        press("1", "alt")
    }
}
