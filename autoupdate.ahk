#NoEnv
#SingleInstance, Force
SendMode, Input
SetBatchLines, -1
SetWorkingDir, %A_ScriptDir%

pullFromSource() {
    ; Save current directory
    currentDir := A_WorkingDir
    
    ; Run git pull
    RunWait, git pull, %A_ScriptDir%, Hide
    if (ErrorLevel) {
        MsgBox, Failed to pull updates from source!
        return false
    }
    
    return true
}

; Function to be called before reload
autoUpdate() {
    if (pullFromSource()) {
        Reload
    }
} 