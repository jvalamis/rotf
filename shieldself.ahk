#NoEnv
#SingleInstance, Force
SendMode, Input
SetBatchLines, -1
SetWorkingDir, %A_ScriptDir%

shieldself() {
    press("F1")  ; Target self
    sleep 100
    press("3")   ; Perform action
}