#NoEnv
#SingleInstance, force
SendMode, Input
SetWorkingDir, %A_ScriptDir%
Menu, Tray, Tip, AHKlicker
Menu, Tray, Icon, %A_WorkingDir%\resources\images\icon.ico, 1, 1

; GLOBAL VARIABLES
global mainGUITitle := "AHKlicker"
global scriptExe
SplitPath, A_AhkPath, scriptExe
global okKey := "F9"
global cancelKey := "F10"
global resourcesPath := A_ScriptDir "\resources"
global language := GetConfig("General", "language")
if(!FileExist(resourcesPath "\languages\" language ".ini")){
    language := "en"
    SetConfig("General", "language", language)
}
global profile := GetConfig("General", "profile")

; Max number of actions and actions objects array
global maxActions := 35
global actions := []

ShowMainGui()

; FUNCTIONS

; Gets and returns a value from the config.ini file
GetConfig(section, key){
    IniRead, value, %resourcesPath%\config.ini, %section%, %key%, [{%key%}]
    return value
}

; Sets a value to the config.ini file
SetConfig(section, key, value){
    IniWrite, %value%,  %resourcesPath%\config.ini, %section%, %key%
}

; Gets and returns a value from the current (or the given) language file
Get(section, key, languageFile:=false, default:=False){
    languageFile := languageFile ? languageFile : language
    default := default ? default : key
    IniRead, value, %resourcesPath%\languages\%languageFile%.ini, %section%, %key%, %default%
    return value
}

; Shows the main GUI
global action1
global action2
global action3
global action4
global action5
global action6
global action7
global action8
global action9
global action10
global action11
global action12
global action13
global action14
global action15
global action16
global action17
global action18
global action19
global action20
global action21
global action22
global action23
global action24
global action25
global action26
global action27
global action28
global action29
global action30
global action31
global action32
global action33
global action34
global action35
ShowMainGui(){
    ; Creating main GUI
    Gui, main:New

    ; "File" menu
    Menu, FileMenu, Add, % Get("FileMenu", "Start"), Start
    Menu, FileMenu, Add, % Get("FileMenu", "Pause"), Pause
    Menu, FileMenu, Add, % Get("FileMenu", "Stop"), Stop
    Menu, FileMenu, Add, % Get("FileMenu", "Restart"), Stop
    Menu, FileMenu, Add
    Menu, FileMenu, Add, % Get("FileMenu", "Exit"), Exit
    Menu, MainMenuBar, Add, % Get("FileMenu", "File"), :FileMenu

    ; "Add Action" menu

    ; "Mouse" sub-menu
    Menu, MouseSubMenu, Add, % Get("Actions", "LeftClick"), LeftClickAction
    Menu, MouseSubMenu, Add, % Get("Actions", "LeftDrag"), LeftDragAction
    Menu, MouseSubMenu, Add, % Get("Actions", "RightClick"), RightClickAction
    Menu, MouseSubMenu, Add, % Get("Actions", "RightDrag"), RightDragAction
    Menu, MouseSubMenu, Add, % Get("Actions", "MiddleClick"), MiddleClickAction
    Menu, MouseSubMenu, Add, % Get("Actions", "MiddleDrag"), MiddleDragAction
    ; Click on Color sub sub-menu...
    Menu, ClickOnColorSubSubMenu, Add, % Get("Actions", "AtMousePosition"), ClickOnColorAtMousePositionAction
    Menu, ClickOnColorSubSubMenu, Add, % Get("Actions", "EnterColor"), ClickOnColorEnterColorAction
    Menu, MouseSubMenu, Add, % Get("Actions", "ClickOnColor"), :ClickOnColorSubSubMenu
    Menu, ActionsMenu, Add, % Get("Actions", "Mouse"), :MouseSubMenu

    ; "Keyboard" sub-menu
    Menu, KeyboardSubMenu, Add, % Get("Actions", "Write"), ConfirmTextInput
    Menu, KeyboardSubMenu, Add, % Get("Actions", "PressKey"), PressKeyAction
    Menu, KeyboardSubMenu, Add, % Get("Actions", "SendCommand"), SendCommandAction
    Menu, ActionsMenu, Add, % Get("Actions", "Keyboard"), :KeyboardSubMenu

    ; "Wait" sub-menu
    Menu, WaitSubMenu, Add, % Get("Actions", "Sleep") , SleepAction
    Menu, WaitSubMenu, Add, % Get("Actions", "WaitColor"), WaitColorAction
    Menu, WaitSubMenu, Add, % Get("Actions", "WaitImage"), WaitImageAction
    Menu, ActionsMenu, Add, % Get("Actions", "Wait"), :WaitSubMenu

    Menu, ActionsMenu, Add, % Get("Actions", "Repeat"), RepeatAction
    Menu, ActionsMenu, Add, % Get("Actions", "RunCommand"), RunCommandAction

    Menu, ActionsMenu, Add

    Menu, ActionsMenu, Add, % Get("Tools", "ColorPicker"), PickColorAction

    Menu, MainMenuBar, Add, % Get("Actions", "AddAction"), :ActionsMenu

    ; "Profile" menu
    Menu, ProfileMenu, Add, % Get("Profile", "Load"), LoadProfileAction
    Menu, ProfileMenu, Add, % Get("Profile", "Save"), SaveProfileAction
    Menu, ProfileMenu, Add, % Get("Profile", "Clear"), CleanProfileAction

    Menu, MainMenuBar, Add, % Get("Profile", "Profile"), :ProfileMenu

    ; "Configuration" menu

    ; "Language" sub-menu
    Loop, Files, %A_WorkingDir%\resources\languages\*.ini
    {
        currentLanguage := StrReplace(A_LoopFileName, "." A_LoopFileExt)
        setLanguageFunction := Func("SetLanguage").Bind(currentLanguage)
        Menu, LangaugeSubMenu, Add, % Get("Languages", currentLanguage), %setLanguageFunction%
    }
    Menu, LangaugeSubMenu, Check, % Get("Languages", language)
    Menu, ConfigMenu, Add, % Get("Languages", "Language"), :LangaugeSubMenu

    Menu, MainMenuBar, Add, % Get("Configuration", "Configuration"), :ConfigMenu

    ; "Help" menu
    Menu, HelpMenu, Add, % Get("HelpMenu", "About"), AboutAction
    Menu, MainMenuBar, Add, % Get("HelpMenu", "Help"), :HelpMenu

    ; Adding main menu bar to the GUI
    Gui, Menu, MainMenuBar

    ; Gui width and height
    guiWidth := 400
    guiHeight := 16 * maxActions

    ; Adding empty texts to the GUI
    Gui, Font, s11
    y := 0
    Loop, %maxActions%{
        Gui, Add, Text, x2 y%y% w%guiWidth% vaction%A_Index%
        y += 16
    }
    
    ; Showing main GUI
    Gui, +resize
    Gui, Show, % "w" guiWidth " h" guiHeight " y" Floor(A_ScreenHeight / 2 - guiHeight / 2 - maxActions), %mainGUITitle%
}
mainGuiClose(){ ; Action when the main gui is closed
    ExitApp
}

; About menu functions
global copyRepositoryButton
AboutAction(){
    Gui, about:New
    Gui, -Caption +ToolWindow +Border +AlwaysOnTop
    Gui, Font, s12
    Gui, Color, e9e9e9
    Gui, Add, Text, x4 y4, % "AHKlicker " GetConfig("About", "version")
    Gui, Font, c0000FF underline
    Gui, Add, Link, x4 y36 gGoRepository, % "<a>" GetConfig("About", "repo") "</a>"
    Gui, Add, Picture, x312 y32 w30 h30 Icon135 gCopyRepository vcopyRepositoryButton, Shell32.dll
    Gui, Font, s12 norm
    Gui, Add, Button, w80 x135 y70 gAboutOK Default, % Get("Dialogs", "OK")
    GuiControl, Focus, Button1
    Gui, Show, w348 h120
}
GoRepository(){ ; Open's the repository
    Run, % GetConfig("About", "repo")
    AboutOK()
}
CopyRepository(){ ; Copies the repository
    Clipboard := GetConfig("About", "repo")
    GuiControl, , copyRepositoryButton, *icon296 Shell32.dll
}
AboutOK(){ ; Closes de About dialog
    Gui, about:Destroy
}

; Show actions list in the GUI
ShowActions(actionDeleted:=false){
    for key, action in actions
        GuiControl, main:, action%A_Index%, % A_Index ": " action.displayName
    if(actionDeleted)
        Loop, % maxActions - actions.Length()
            GuiControl, main:, % "action" A_Index + actions.Length()
}

; File menu functions
Start(){ ; Start actions
    ExitApp
}
Pause(){ ; Pause actions
    ExitApp
}
Stop(){ ; Stops the actions
    ExitApp
}
Restart(){ ; Restarts the actions
    ExitApp
}
Exit(){ ; Close program
    ExitApp
}

; Actions menu funcitons

; Timer for confirmation tooltip message
global tooltipMessage
TooltipMessageTimer(){
    ToolTip, %tooltipMessage%
}

; Wait confirmation or cancelation...

; Confirming click
ConfirmClick(actionObject){
    Minimize()
    tooltipMessage := okKey " = " Get("Actions", actionObject.name) " " Get("Dialogs", "Here") "`n" cancelKey " = " Get("Dialogs", "Cancel")
    SetTimer, TooltipMessageTimer, 50
    while(!GetKeyState(okKey) && !GetKeyState(cancelKey))
        continue
    SetTimer, TooltipMessageTimer, Delete
    ToolTip
    if(GetKeyState(cancelKey)){
        Restore()
        return false
    }
    MouseGetPos, , , winId
    WinActivate, ahk_id %winId%
    MouseGetPos, mX, mY
    Restore()
    actionObject.x := mX
    actionObject.y := mY
    WinGet, winExe, ProcessName, ahk_id %winId%
    actionObject.process := winExe
    return true
}

; Confirmig mouse drag
ConfirmDrag(actionObject){
    Minimize()
    tooltipMessage := Get("Actions", actionObject.name) "`n" cancelKey " = " Get("Dialogs", "Cancel")
    SetTimer, TooltipMessageTimer, 50
    dragDone := false
    while(!GetKeyState(cancelKey)){
        if(!GetKeyState(actionObject.button))
            continue
        MouseGetPos, mX1, mY1, winId1
        while(GetKeyState(actionObject.button))
            MouseGetPos, mX2, mY2, winId2
        if(mX2 >= 0 && winId1 == winId2)
            if(Abs(mX2 - mX1) >= 5 || Abs(mY2 - mY1) >= 5){
                dragDone := true
                break
            }
        mX2 :=
    }
    SetTimer, TooltipMessageTimer, Delete
    ToolTip
    if(!dragDone){
        Restore()
        return false
    }
    MsgBox, % 4 + 32, % Get("Dialogs", "Confirmation"), % Get("Dialogs", "DragConfirmation")
    IfMsgBox Yes
    {
        actionObject.x1 := mX1
        actionObject.y1 := mY1
        actionObject.x2 := mX2
        actionObject.y2 := mY2
        WinGet, winExe, ProcessName, ahk_id %winId1%
        actionObject.process := winExe
        Restore()
        return true
    }
    else
        return ConfirmDrag(actionObject)
}

; Confirming color picking
ConfirmColorPick(colorObject, restore:=True){
    Minimize()
    SetTimer, TooltipMessageTimer, 50
    while(!GetKeyState(okKey) && !GetKeyState(cancelKey)){
        MouseGetPos, mX, mY, winId
        PixelGetColor, color, %mX%, %mY%, Slow RGB
        tooltipMessage := okKey " = " StrReplace(color, "0x", "#") "`n" cancelKey " = " Get("Dialogs", "Cancel")
    }
    confirmed := !GetKeyState(cancelKey)
    SetTimer, TooltipMessageTimer, Delete
    ToolTip
    if(restore)
        Restore()
    if(!confirmed)
        return false
    WinGet, winExe, ProcessName, ahk_id %winId%
    colorObject.pixelColor := StrReplace(color, "0x", "#")
    colorObject.process := winExe
    colorObject.winId := winId
    return true
}

; Confirm value input
ConfirmInput(mainGUITitle, prompt:="", hide:="", width:=300, height:=130, x:=-1, y:=-1, timeout:="", default:="", trimValue:=True, requiredPattern:=False){
    if(x == -1)
        x := A_ScreenWidth / 2 - width / 2 ; Centering on X
    if(y == -1)
        y := A_ScreenHeight / 2 - height / 2 ; Centering on Y

    while(True){
        InputBox, value, %mainGUITitle%, %prompt%, %hide%, %width%, %height%, %x%, %y%, Locale, %timeout%, %default%
        if ErrorLevel
            return ""
        if(trimValue)
            value := Trim(value, " `t`r`n")
        if(value == "")
            continue
        if(requiredPattern)
            if(!RegExMatch(value, requiredPattern))
                continue
        return value
    }
}

; Confirm text input
global textInput
ConfirmTextInput(actionLabel, actionIndex, menuName){
    switch menuName{
        case "KeyboardSubMenu":
            okCallback := "WriteAction"
    }
    Gui, input:New
    Gui, input:Default
    Gui, Font, s11
    Gui, Add, Text, x0 y2, Text to write...
    Gui, Add, Edit, r8 w350 vtextInput
    Gui, Add, Button, % "w70 x" 350/2 - 70/2 " g" okCallback, OK
    Gui, Show, w350 h208
}

; Confirm window where the mouse is
ConfirmWindow(){
    Minimize()
    tooltipMessage := ""
    SetTimer, TooltipMessageTimer, 50
    while(!GetKeyState(okKey) && !GetKeyState(cancelKey)){
        MouseGetPos, , , winId
        WinGet, winExe, ProcessName, ahk_id %winId%
        tooltipMessage := okKey " = " Get("Dialogs", "ThisWindow") " (" winExe ")`n" cancelKey " = " Get("Dialogs", "Cancel")
        continue
    }
    SetTimer, TooltipMessageTimer, Delete
    ToolTip
    if(GetKeyState(cancelKey)){
        Restore()
        return false
    }
    return {id: winId, process: winExe}
}

; Confirm zone selection
ConfirmZoneSelection(winId){ ;TO-DO
    minimize()
    Gui, zoneWindow:Destroy
    Gui, zoneWindow:New
    Gui, zoneWindow:Default
    Gui, +LastFound +AlwaysOnTop +Resize -MinimizeBox +ToolWindow
    WinSet, Transparent, 200
    Gui, Color, FFFFFF
    CoordMode, Mouse, Screen
    MouseGetPos, mX, mY
    CoordMode, Mouse, Window
    WinGetPos, winX, winY, winW, winH, ahk_id %winId%
    Gui, Show, % "w400 h300 x" mX - 200 " y" mY - 12, % Get("Dialogs", "SelectSearchZone")

    SetTimer, TooltipMessageTimer, 50
    tooltipMessage := okKey " = " Get("Dialogs", "SetSearchZone") "`n" cancelKey " = " Get("Dialogs", "Cancel")
    while(!GetKeyState(okKey) && !GetKeyState(cancelKey))
        if(!WinExist("ahk_id " winId) || !WinExist(Get("Dialogs", "SelectSearchZone") " ahk_exe " scriptExe))
            break

    confirmed := GetKeyState(okKey)
    SetTimer, TooltipMessageTimer, Delete
    ToolTip
    if(!confirmed){
        Gui, zoneWindow:Destroy
        Restore()
        return False
    }

    Gui, zoneWindow:+LastFound
    WinGetPos, zoneX, zoneY, zoneW, zoneH
    Gui, zoneWindow:Destroy

    WinGet, minMax, MinMax, ahk_id %winId%
    while(minMax == -1){
        WinRestore, ahk_id %winId%
        WinGet, minMax, MinMax, ahk_id %winId%
    }
    WinGetPos, winX, winY, winW, winH, ahk_id %winId%

    ; TODO
    MsgBox, , TO-DO, Window: %winX%`, %winY% (%winW%x%winH%)`n`n Zone: %zoneX%`, %zoneY% (%zoneW%x%zoneH%)

    return True
}

; MOUSE ACTIONS SUB-MENU FUNCTIONS

; Adds a Left Click
LeftClickAction(){
    action := {name: "LeftClick"}
    if(!ConfirmClick(action))
        return

    action.saveName := "{" action.name "}[" action.process "]("  action.x "," action.y ")"
    action.displayName := Get("Actions", action.name) " [" action.process " ] ("  action.x ", " action.y ")"

    actions.push(action)
    ShowActions()
}

; Adds a Left Button Drag
LeftDragAction(){
    action := {name: "LeftDrag", button: "LButton"}
    if(!ConfirmDrag(action))
        return

    action.saveName := "{" action.name "}[" action.process "]("  action.x1 "," action.y1 ")(" action.x2 "," action.y2 ")"
    action.displayName := Get("Actions", action.name) " [" action.process " ] ("  action.x1 ", " action.y1 ") => (" action.x2 ", " action.y2 ")"

    actions.push(action)
    ShowActions()
}

; Adds a Right Click
RightClickAction(){
    action := {name: "RightClick"}
    if(!ConfirmClick(action))
        return

    action.saveName := "{" action.name "}[" action.process "]("  action.x "," action.y ")"
    action.displayName := Get("Actions", action.name) " [" action.process " ] ("  action.x ", " action.y ")"

    actions.push(action)
    ShowActions()
}

; Adds Left Button Drag
RightDragAction(){
    action := {name: "RightDrag", button: "RButton"}
    if(!ConfirmDrag(action))
        return

    action.saveName := "{" action.name "}[" action.process "]("  action.x1 "," action.y1 ")(" action.x2 "," action.y2 ")"
    action.displayName := Get("Actions", action.name) " [" action.process " ] ("  action.x1 ", " action.y1 ") => (" action.x2 ", " action.y2 ")"

    actions.push(action)
    ShowActions()
}

; Adds a Middle Button Click
MiddleClickAction(){
    action := {name: "MiddleClick"}
    
    if(!ConfirmClick(action))
        return

    action.saveName := "{" action.name "}[" action.process "]("  action.x "," action.y ")"
    action.displayName := Get("Actions", action.name) " [" action.process " ] ("  action.x ", " action.y ")"

    actions.push(action)
    ShowActions()
}

; Adds a Middle Button Drag
MiddleDragAction(){
    action := {name: "MiddleDrag", button: "MButton"}
    if(!ConfirmDrag(action))
        return

    action.saveName := "{" action.name "}[" action.process "]("  action.x1 "," action.y1 ")(" action.x2 "," action.y2 ")"
    action.displayName := Get("Actions", action.name) " [" action.process " ] ("  action.x1 ", " action.y1 ") => (" action.x2 ", " action.y2 ")"

    actions.push(action)
    ShowActions()
}

; Adds a "Click on Color" over the color in the mouse position
ClickOnColorAtMousePositionAction(){ ;TO-DO
    action := {name: "ClickOnColor"}
    if(!ConfirmColorPick(action, False)){
        Restore()
        return
    }

    if(!searchZone := ConfirmZoneSelection(action.winId)){
        Restore()        
        return
    }

    Restore()

    action.saveName := "{" action.name "}[" action.process "](" action.pixelColor ")"
    action.displayName := Get("Actions", action.name) " [" action.process " ] (" action.pixelColor ")"

    actions.push(action)
    ShowActions()
}

; Adds a "Click on Color" by manully writing a color value
ClickOnColorEnterColorAction(){
    window := ConfirmWindow()
    if(!window)
        return

    if(!searchZone := ConfirmZoneSelection(window.id)){
        Restore()        
        return
    }

    color := ConfirmInput(Get("Dialogs", "EnterAColorValue"), Get("Dialogs", "ColorValue"), , , , , , , , , "^(?:0x|#)?[a-fA-F0-9]{6}$")
    Restore()
    if(color == "")
        return
    
    color := "#" RegExReplace(color, "(0x|#)")
    StringUpper, color, color
    
    action := {name: "ClickOnColor", process: window.process, pixelColor: color}

    action.saveName := "{" action.name "}[" action.process "](" action.pixelColor ")"
    action.displayName := Get("Actions", action.name) " [" action.process " ] (" action.pixelColor ")"

    actions.push(action)
    ShowActions()
}

; Keyboard actions sub-menu
WriteAction(){
    GuiControlGet, text, , textInput
    MsgBox, Text to write:`n"%text%"
    Gui, Destroy
}
PressKeyAction(){

}
SendCommandAction(){

}

; Other actions
SleepAction(){

}
WaitColorAction(){

}
WaitImageAction(){

}
RepeatAction(){

}
RunCommandAction(){

}

; Picks the color in the mouse position to the clipboard
PickColorAction(){
    colorObj := {name: "ColorPicker"}
    if(!ConfirmColorPick(colorObj))
       return

    Clipboard := colorObj.pixelColor
    while(ErrorLevel)
        Clipboard := colorObj.pixelColor

    ToolTip, % Get("Tools", "ColorPicked")
    Sleep, 1000
    ToolTip
}

; Profile menu actions
LoadProfileAction(){

}
SaveProfileAction(){

}
CleanProfileAction(){

}

; Minimize the GUI
Minimize(){
    WinMinimize, %mainGUITitle% ahk_exe %scriptExe%
}

; Restore the GUI
Restore(){
    WinActivate, %mainGUITitle% ahk_exe %scriptExe%
}

; Sets a new language
SetLanguage(newLanguage){
    if(language == newLanguage)
        return

    ; Getting all sections names in the current language file
    IniRead, sections, %resourcesPath%\languages\%language%.ini
    sections := StrSplit(sections, "`n")

    ; Unchecking current language
    Menu, LangaugeSubMenu, UnCheck, % Get("Languages", language)

    ; Changing language
    Loop, % sections.Length(){
        ; Getting current language values
        IniRead, sectionCurrentValues, %resourcesPath%\languages\%language%.ini, % sections[A_Index]
        sectionCurrentValues := StrSplit(sectionCurrentValues, "`n")

        ; Getting new language values
        IniRead, sectionNewValues, %resourcesPath%\languages\%newLanguage%.ini, % sections[A_Index]
        sectionNewValues := StrSplit(sectionNewValues, "`n")

        ; Changing values to the new language
        Loop, % sectionCurrentValues.Length(){
            currentValue := RegExReplace(sectionCurrentValues[A_Index], "(^[^=]+=)")
            newValue := RegExReplace(sectionNewValues[A_Index], "(^[^=]+=)")

            ; Changing menu bar items names
            Try{
                Menu, MainMenuBar, Rename, %currentValue%, %newValue%
                continue
            }
            Try{
                Menu, FileMenu, Rename, %currentValue%, %newValue%
                continue
            }
            Try{
                Menu, ActionsMenu, Rename, %currentValue%, %newValue%
                continue
            }
            Try{
                Menu, MouseSubMenu, Rename, %currentValue%, %newValue%
                continue
            }
            Try{
                Menu, ClickOnColorSubSubMenu, Rename, %currentValue%, %newValue%
                continue
            }
            Try{
                Menu, KeyboardSubMenu, Rename, %currentValue%, %newValue%
                continue
            }
            Try{
                Menu, WaitSubMenu, Rename, %currentValue%, %newValue%
                continue
            }
            Try{
                Menu, ProfileMenu, Rename, %currentValue%, %newValue%
                continue
            }
            Try{
                Menu, ConfigMenuProfileMenu, Rename, %currentValue%, %newValue%
                continue
            }
            Try{
                Menu, ConfigMenu, Rename, %currentValue%, %newValue%
                continue
            }
            Try{
                Menu, LangaugeSubMenu, Rename, %currentValue%, %newValue%
                continue
            }
            Try{
                Menu, HelpMenu, Rename, %currentValue%, %newValue%
            }
        }
    }

    ; Translating actions display names 
    Loop, % actions.Length()
        actions[A_Index].displayName := StrReplace(actions[A_Index].displayName, Get("Actions", actions[A_Index].name), Get("Actions", actions[A_Index].name, newLanguage))
    ShowActions()

    ; Saving language configuration
    language := newLanguage
    Menu, LangaugeSubMenu, Check, % Get("Languages", language)
    SetConfig("General", "language", language)
}