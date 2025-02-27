#NoEnv
#SingleInstance, Force
SendMode, Input
SetBatchLines, -1
SetWorkingDir, %A_ScriptDir%

#Include %A_ScriptDir%\getpixelcolor.ahk
#Include %A_ScriptDir%\gdip\Gdip.ahk

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
    
    ; Activate window and wait a moment
    WinActivate, ahk_id %hwnd%
    Sleep, 100
    
    ; Take screenshot to clipboard
    Send, {PrintScreen}
    Sleep, 100
    
    ; Convert clipboard to file using GDI+
    pToken := Gdip_Startup()
    pBitmap := Gdip_CreateBitmapFromClipboard()
    Gdip_SaveBitmapToFile(pBitmap, A_ScriptDir "\game_capture.png", 100)
    Gdip_DisposeImage(pBitmap)
    Gdip_Shutdown(pToken)
    
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

SaveScreenshot(x, y, w, h, filename) {
    ; Create hidden GUI for screenshot
    Gui, Screenshot:New, +AlwaysOnTop -Caption
    Gui, Screenshot:Show, x%x% y%y% w%w% h%h% Hide
    
    ; Take screenshot
    WinWait, ahk_class AutoHotkeyGUI
    WinSet, Transparent, 0
    Gui, Screenshot:Show
    Sleep, 100
    
    ; Save to file
    Send, {PrintScreen}
    Sleep, 100
    
    ; Process the screenshot
    if FileExist(filename)
        FileDelete, %filename%
    
    ; Save using built-in clipboard handling
    SavePrScrn(filename)
    
    ; Cleanup
    Gui, Screenshot:Destroy
}

SavePrScrn(filename) {
    pToken := Gdip_Startup()
    pBitmap := Gdip_CreateBitmapFromClipboard()
    Gdip_SaveBitmapToFile(pBitmap, filename)
    Gdip_DisposeImage(pBitmap)
    Gdip_Shutdown(pToken)
} 