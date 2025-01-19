; Rewritten by garfieldthegripper on discord﻿
SetTimer, OpenScript, 100
ScriptActive := False
StartMouseX := 0
StartMouseY := 0
macVersion := "v1.5"

Gui, Add, Text, x10 y5 w375 h30, Welcome to Garfield's Macro
Gui, Add, Text, x10 y25 w375 h30, Make Sure You Have Read The Info On How To Set Up The Macro!
Gui, Add, Text, x10 y40 w375 h30, Also Make Sure You Have FULL Hunger Before Starting The Macro!
Gui, Add, Text, x10 y60 w200 h30, Controls:
Gui, Add, Text, x10 y80 w200 h30, K = Start Macro
Gui, Add, Text, x10 y100 w200 h30, L = Exit Macro
Gui, Add, Text, x10 y120 w200 h30, P = Pause/Resume Macro
Gui, Add, Text, x10 y140 w375 h30, Discord Webhook URL:
Gui, Add, Edit, x10 y160 w375 h17 vWebhookURL,
Gui, Add, Button, x10 y180 w150 h30 gSetWebhook, Set Webhook
Gui, Show, x204 y650 w400 h215, Garfield's Dura Pull Up Macro

return

SetWebhook:
Gui, Submit, NoHide
; You can use the WebhookURL variable here for further processing or validation
MsgBox, Discord Webhook URL Set To:`n%WebhookURL%

return

OpenScript:
SetTitleMatchMode, 2
WinActivate, % "ahk_id " Roblox
WinGet, Roblox, ID, ahk_exe RobloxPlayerBeta.exe
WinMove, % "ahk_id " Roblox, , 0, 0, 810, 610

return

Wait: 
if (ScriptActive) {
	Loop
		{
		ToolTip "Regening"
        	PixelSearch,,, 284, 114, 286, 114, 0x0000FF, 249, Fast ; detects blue pixel in the area aka stamina bar
        	If ErrorLevel {
            	ToolTip "Full Stamina"
            	Sleep, 500
            	Goto ClickDura
            	Break
		}
	}
}
return

FindFood:
if (ScriptActive) {
	Food = 1
	Loop
		{
		ImageFileName := A_ScriptDir . "\bin\food\food" . Food . ".bmp"
        	ImageSearch, FoundX, FoundY, 161, 580, 655, 624, *65 %ImageFileName%
        	If ErrorLevel = 0
        	{
            	FoundX += 20
		FoundY += 5
            	MouseMove, %FoundX%, %FoundY%
            	Sleep, 50
            	Click
            	Sleep, 50
            	MouseMove, 408, 470
            	Sleep, 50
            	Click
            	MouseMove, %FoundX%, %FoundY%
            	Sleep, 2000
            	Click
            	Sleep, 50
	    	MouseMove, 408, 470
           	Goto ClickDura
            	Break
        	}else{
            		Food++
            		if (Food >= 7)
            		{
                	ToolTip "No Food"
			Food = 1
                	MouseClick, left, 784, 14  ; Click at a specific pixel when out of food
                	Sleep, 500  ; Wait for 1 seconds before continuing
                	ExitApp ;Exit script when out of food
			}
		}
    	}
}
return

Train:
if (ScriptActive) {
	Sleep, 300
    	StartTime := A_TickCount
    	ToolTip "The Real Garfield Fan Club Is The Best Gang!"
    	Loop
		{
		MouseMove, 408, 470
        	ElapsedTime := A_TickCount - StartTime
        	ImageSearch,,, 200, 209, 590, 235, *70 %A_ScriptDir%\bin\W.bmp
        	if ErrorLevel = 0
        	{				
        		SendInput, w 
        	}		
        	ImageSearch,,, 200, 209, 590, 235, *70 %A_ScriptDir%\bin\A.bmp
        	if ErrorLevel = 0
        	{				
            		SendInput, a 
        	}
        	ImageSearch,,, 200, 209, 590, 235, *70 %A_ScriptDir%\bin\S.bmp
        	if ErrorLevel = 0
        	{				
            		Sendinput, s 
        	}			
        	ImageSearch,,, 200, 209, 590, 235, *70 %A_ScriptDir%\bin\D.bmp
        	if ErrorLevel = 0
        	{				
            		Sendinput, d 
        	}
		Sleep, 10
		PixelSearch,,, 85, 114, 90, 114, 0x0000FF, 226, Fast ; detects blue pixel in the area aka stamina bar
        	If !ErrorLevel
        	{
        	ToolTip "Low Stamina"
        	Goto Wait
        	}
        	if (ElapsedTime >= 60000)
        	{
		Goto ClickDura
		Break
		}
	}
}
return

ClickDura:
if (ScriptActive) {
	Loop
    		{
        	PixelSearch,,, 190, 125, 175, 125, 0x000000, 55, Fast ; detects food bar '190' default value
        	If ErrorLevel = 0
        	{
            	ToolTip "Hungry"
            	Goto FindFood
        	}
		PixelSearch,,, 85, 114, 90, 114, 0x0000FF, 226, Fast ; detects blue pixel in the area aka stamina bar
        	If !ErrorLevel
        	{
        	ToolTip "Low Stamina"
        	Goto Wait
        	}else{
            		MouseMove, %StartMouseX%, %StartMouseY%
            		Click
			ToolTip
            		ImageSearch,imagex, imagey, 310, 338, 502, 357, *100 %A_ScriptDir%\bin\dura.bmp
            		if ErrorLevel = 0
            		{			
                		FoundX += 15			
                		Sleep, 50
                		MouseMove, %imagex%, %imagey%
                		Sleep, 50
                		Click
                		Sleep, 50
                		MouseMove, %imagex%, %imagey%
                		Sleep, 50
				Click
				Sleep, 50
				MouseMove, 408, 470
                		Goto Train
                		Break
			}
		}
    	}
}
return

k:: ;main function to start the training process
ScriptActive := True ; Activate the script when you press "k"
SetTimer, OpenScript, On ; Start the timer
MouseGetPos, StartMouseX, StartMouseY ; Where to click to find the pull up bar
ImageSearch,,, 70, 50, 100, 67, *50 %A_ScriptDir%\bin\chat.bmp
if ErrorLevel = 0
{				
    MouseMove, 82, 54
    Sleep, 50
    Click
}
Sleep, 50
Goto ClickDura
return

p::Pause  ; Press "P" to pause/resume the script

l::ExitApp ; Press "l" to exit the script

GuiClose:
ExitApp

