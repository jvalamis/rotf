#NoEnv
#SingleInstance, Force
SendMode, Input
SetBatchLines, -1
SetWorkingDir, %A_ScriptDir%

moveMouse(x, y) {
    DllCall("SetCursorPos", "Int", x, "Int", y)
}