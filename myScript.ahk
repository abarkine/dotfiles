;minimizer script
#Include MinimizeToTrayMenu.ahk
#NoEnv
SendMode Input

#h::
    ;window will stay on top
    Gui, +AlwaysOnTop

    ;grayish color will be background
    Gui, Color, 4A4F56

    ;font will be consolas, 14 point, white and bold
    Gui, Font, s14 Bold cWhite, Consolas

    ;insert text at point (x, y) without a background
    Gui, Add, Text, x10 y10 +BackgroundTrans, windows+1       -> chrome
    Gui, Add, Text, x10 y30 +BackgroundTrans, windows+2       -> visual studio code
    Gui, Add, Text, x10 y50 +BackgroundTrans, windows+3       -> git bash
    Gui, Add, Text, x10 y70 +BackgroundTrans, windows+4       -> spotify
    Gui, Add, Text, x10 y90 +BackgroundTrans, windows+5       -> putty
    Gui, Add, Text, x10 y110 +BackgroundTrans, windows+6       -> qbittorent
    Gui, Add, Text, x10 y130 +BackgroundTrans, windows+f1      -> steam
    Gui, Add, Text, x10 y150 +BackgroundTrans, windows+f2      -> paint.net
    Gui, Add, Text, x10 y170 +BackgroundTrans, windows+f3      -> mspaint
    Gui, Add, Text, x10 y190 +BackgroundTrans, windows+f4      -> notepad
    Gui, Add, Text, x10 y210 +BackgroundTrans, windows+f5      -> calculator
    Gui, Add, Text, x10 y230 +BackgroundTrans, windows+f6      -> snipping tool
    Gui, Add, Text, x10 y250 +BackgroundTrans, windows+f7      -> open leftmost folder on chrome
    Gui, Add, Text, x10 y270 +BackgroundTrans, windows+g       -> search text in clipboard on google
    Gui, Add, Text, x10 y290 +BackgroundTrans, windows+y       -> search text in clipboard on youtube
    Gui, Add, Text, x10 y310 +BackgroundTrans, windows+t       -> translate text in clipboard
    Gui, Add, Text, x10 y330 +BackgroundTrans, alt+1           -> hide active window to tray
    Gui, Add, Text, x10 y350 +BackgroundTrans, alt+2           -> bring back window from tray
    Gui, Add, Text, x10 y370 +BackgroundTrans, scrolllock      -> suspend/resume the script
    Gui, Add, Text, x10 y390 +BackgroundTrans, homeaddr        -> completes you with whole home address
    Gui, Add, Text, x10 y410 +BackgroundTrans, workaddr        -> completes you with whole work address
    Gui, Add, Text, x10 y430 +BackgroundTrans, escape          -> close this help
    Gui, Add, Link,, Asil Elik <a href="https://github.com/20percent">@Github</a>

    ;add margin for nicer look
    Gui, Margin, 5, 5

    ;determine window size automatically
    Gui, Show, AutoSize, Guide for Shortcuts

    ;if you want transparency, remove following semicolon
    ;WinSet, Transparent, 222, Guide for Shortcuts

    ;remove header in window
    WinSet, Style, -0x400000, Guide for Shortcuts

    ;get windows' height, width
    WinGetPos, X, Y, W, H, A

    ;according to height and width, create rounded window
    WinSet, Region, 0-0 W%W% H%H% R40-40, Guide for Shortcuts
Return

;when escape is pressed, if gui is being shown, destroy it
GuiEscape:
    Gui Destroy
Return

#1::Run C:\Program Files (x86)\Google\Chrome\Application\chrome.exe
#2::Run C:\Program Files (x86)\Microsoft VS Code\Code.exe
#3::Run C:\Program Files\Git\git-bash.exe
#4::Run C:\Users\username\AppData\Roaming\Spotify\Spotify.exe
#5::Run C:\putty.exe
#6::Run C:\Program Files (x86)\qBittorrent\qbittorrent.exe
#f1::Run C:\Program Files (x86)\Steam\Steam.exe
#f2::Run C:\Program Files\paint.net\PaintDotNet.exe
#f3::Run mspaint
#f4::Run notepad
#f5::Run calc
#f6::Run C:\Windows\Sysnative\SnippingTool.exe

;if chrome new tab is already opened, use that instance
;if not open new chrome instance
;after that, open leftmost folder in bookmarks bar(chrome)
#f7::
    IfWinActive, New Tab - Google Chrome
    {
        MouseClick, right, 30, 80
        MouseClick, left, 50, 85
        MouseClick, middle, 50, 20
    }
    else
    {
        run C:\Program Files (x86)\Google\Chrome\Application\chrome.exe
        WinWait, New Tab - Google Chrome, , 5
        MouseClick, right, 30, 80
        MouseClick, left, 50, 85
        MouseClick, middle, 50, 20
    }
Return

;search last clipboard text on youtube
#y::Run https://www.youtube.com/results?search_query=%clipboard%

;search last clipboard text on google
#g::Run http://www.google.com/search?q=%clipboard%

;translate last clipboard text on google translate
#t::Run http://translate.google.com/?source=osdd#auto|auto|%clipboard%

;win+e opens pc, instead of that, open c: directly
#e::Run "C:\"
Return

;suspend/resume the script
ScrollLock::Suspend
Return

;hotstrings
::homeaddr::home address number postal code etc
::workaddr::home address number postal code etc
