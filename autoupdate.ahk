#NoEnv
#SingleInstance, Force
SendMode, Input
SetBatchLines, -1
SetWorkingDir, %A_ScriptDir%

pullFromSource() {
    ; Save current directory
    currentDir := A_WorkingDir
    
    ; Find git executable (common locations)
    gitPaths := [
        "C:\Program Files\Git\cmd\git.exe",
        "C:\Program Files (x86)\Git\cmd\git.exe",
        A_ProgramFiles "\Git\cmd\git.exe",
        EnvGet("PROGRAMFILES") "\Git\cmd\git.exe"
    ]
    
    gitPath := ""
    for _, path in gitPaths {
        if (FileExist(path)) {
            gitPath := path
            break
        }
    }
    
    if (!gitPath) {
        MsgBox, Git executable not found! Please install Git or add it to PATH.
        return false
    }
    
    ; Run git pull with full path
    RunWait, "%gitPath%" pull, %A_ScriptDir%, Hide
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