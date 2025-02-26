#NoEnv
#SingleInstance, Force
SendMode, Input
SetBatchLines, -1
SetWorkingDir, %A_ScriptDir%

#Include %A_ScriptDir%\getpixelcolor.ahk
#Include %A_ScriptDir%\gdip\Gdip.ahk

; Declare GUI control variable as global
global CapturedImage

; Capture the game window and save it
captureScreen() {
    ; Start up GDI+
    pToken := Gdip_Startup()
    
    ; Get the Pantheon window
    WinGetPos, gameX, gameY, gameWidth, gameHeight, Pantheon
    if (!gameWidth) {  ; If game window not found
        MsgBox, Pantheon window not found!
        return
    }
    
    ; Create bitmap from game window area
    pBitmap := Gdip_BitmapFromScreen(gameX "|" gameY "|" gameWidth "|" gameHeight)
    
    ; Save to file
    Gdip_SaveBitmapToFile(pBitmap, A_ScriptDir "\game_capture.png", 100)
    
    ; Clean up
    Gdip_DisposeImage(pBitmap)
    Gdip_Shutdown(pToken)
    
    ; Show viewer
    ShowCaptureViewer(gameWidth, gameHeight)
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