#NoEnv
#SingleInstance, Force
SendMode, Input
SetBatchLines, -1
SetWorkingDir, %A_ScriptDir%

#Include %A_ScriptDir%\getpixelcolor.ahk

global CapturedImage

captureScreen() {
    ; Get the Pantheon window
    WinGet, hwnd, ID, Pantheon
    if (!hwnd) {
        MsgBox, Pantheon window not found!
        return
    }
    
    ; Get window dimensions
    WinGetPos, x, y, width, height, ahk_id %hwnd%
    
    ; Take screenshot
    WinActivate, ahk_id %hwnd%
    Sleep, 100  ; Give window time to activate
    
    ; Create GUI to hold screenshot
    Gui, Screenshot:New
    Gui, Screenshot:Add, Picture, x0 y0 w%width% h%height% vScreenshot
    Gui, Screenshot:Show, Hide w%width% h%height%
    
    ; Capture the window
    WinWaitActive, ahk_id %hwnd%
    Sleep, 100
    PrintWindow(hwnd, "Screenshot")
    
    ; Save to file
    SaveScreenshot("Screenshot", A_ScriptDir "\game_capture.png")
    Gui, Screenshot:Destroy
    
    ; Show viewer
    ShowCaptureViewer(width, height)
}

ShowCaptureViewer(imgWidth, imgHeight) {
    ; Create a GUI to display the image at original size
    Gui, Viewer:New, +AlwaysOnTop
    Gui, Viewer:Add, Picture, x0 y0 w%imgWidth% h%imgHeight% vCapturedImage, %A_ScriptDir%\game_capture.png
    
    ; Show GUI at original image size
    Gui, Viewer:Show, w%imgWidth% h%imgHeight%, Game Capture Viewer
    
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

; Helper functions for capturing window
PrintWindow(hwnd, control) {
    SendMessage, 0x0B, 0, 0,, ahk_id %hwnd%  ; WM_SETREDRAW
    ControlGet, hwndControl, Hwnd,, %control%, A
    DllCall("PrintWindow", "Ptr", hwnd, "Ptr", hwndControl, "Uint", 0)
    SendMessage, 0x0B, 1, 0,, ahk_id %hwnd%  ; WM_SETREDRAW
    WinRedraw, ahk_id %hwnd%
}

SaveScreenshot(control, filename) {
    ControlGet, hwnd, Hwnd,, %control%, A
    pBitmap := Gdip_CreateBitmapFromHBITMAP(DllCall("GetWindowDC", "Ptr", hwnd))
    Gdip_SaveBitmapToFile(pBitmap, filename)
    Gdip_DisposeImage(pBitmap)
} 