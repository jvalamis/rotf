#NoEnv
#SingleInstance, Force
SendMode, Input
SetBatchLines, -1
SetWorkingDir, %A_ScriptDir%

; ;alt1
; Coordinates: 694, 934 Color: 0x925E72
; Coordinates: 708, 948 Color: 0xBF6762
; Coordinates: 704, 929 Color: 0xD7C3A8
; ;alt2
; Coordinates: 762, 949 Color: 0x6091A8
; Coordinates: 755, 930 Color: 0x40728C
; Coordinates: 763, 949 Color: 0x56748A

; ;alt3
; Coordinates: 815, 931 Color: 0x4D6AB5
; Coordinates: 820, 927 Color: 0x576EA7
; Coordinates: 827, 951 Color: 0x7D667C

; ;alt4
; Coordinates: 864, 944 Color: 0x371A1D
; Coordinates: 872, 933 Color: 0x4B0922
; Coordinates: 886, 948 Color: 0x77503B

getTechniquePixels() {
    ; Define coordinate groups
    alt1 := [{x: 694, y: 934}, {x: 708, y: 948}, {x: 704, y: 929}]
    alt2 := [{x: 762, y: 949}, {x: 755, y: 930}, {x: 763, y: 949}]
    alt3 := [{x: 815, y: 931}, {x: 820, y: 927}, {x: 827, y: 951}]
    alt4 := [{x: 864, y: 944}, {x: 872, y: 933}, {x: 886, y: 948}]

    output := ""

    loop, 4 {
        group := "alt" A_Index
        output .= ";" group "`n"
        for i, coord in %group% {
            PixelGetColor, color, % coord.x, % coord.y
            output .= "Coordinates: " . coord.x . ", " . coord.y . " Color: " . color . "`n"
        }
        output .= "`n"
    }

    clipboard := output
}


