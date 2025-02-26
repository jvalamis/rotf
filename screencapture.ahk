#NoEnv
#SingleInstance, Force
SendMode, Input
SetBatchLines, -1
SetWorkingDir, %A_ScriptDir%

#Include %A_ScriptDir%\getpixelcolor.ahk
#Include %A_ScriptDir%\gdip\Gdip.ahk

; Capture the game window and save it
captureScreen() {
    ; Start up GDI+
    pToken := Gdip_Startup()
    
    ; Get active window handle
    WinGet, hwnd, ID, A
    
    ; Capture window to bitmap
    pBitmap := Gdip_BitmapFromHWND(hwnd)
    
    ; Save to file
    Gdip_SaveBitmapToFile(pBitmap, A_ScriptDir "\game_capture.png")
    
    ; Clean up
    Gdip_DisposeImage(pBitmap)
    Gdip_Shutdown(pToken)
    
    ; Show viewer
    ShowCaptureViewer()
}

ShowCaptureViewer() {
    ; Create a fullscreen GUI to display the image
    Gui, Viewer:New, +AlwaysOnTop
    Gui, Viewer:Add, Picture, x0 y0 vCapturedImage, %A_ScriptDir%\game_capture.png
    
    ; Get screen dimensions
    SysGet, MonitorWorkArea, MonitorWorkArea
    
    ; Show GUI fullscreen
    Gui, Viewer:Show, x0 y0 w%MonitorWorkAreaRight% h%MonitorWorkAreaBottom%, Game Capture Viewer
    
    ; Register hotkeys for the viewer
    Hotkey, IfWinActive, Game Capture Viewer
    Hotkey, Esc, ViewerGuiClose
    Hotkey, LButton, GetClickCoords
    return
}

GetClickCoords:
    getPixelColor()
return

ViewerGuiClose:
    Gui, Viewer:Destroy
    FileDelete, %A_ScriptDir%\game_capture.png
return 