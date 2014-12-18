; AOE 2 Key-to-button mapping
; (and some other remappings)

; This script sends a click to the button corresponding to its distance
; from the origin (Key Q => Top Left Button)
;
; To reset origin location, use Shift+CapsLock

#NoEnv
#Persistent
#SingleInstance force
SendMode, Input

CoordMode, Mouse, Screen
SetCapsLockState, Off
SetDefaultMouseSpeed, 0

; Variables

settingsFilename := "aoe2_settings.csv"

buttonSize := 42

; FE 1680 x 1050
offsetX := 266
offsetY := 892

keymapEnabled := False

; Load settings

LoadSettings()
SaveSettings()

; Functions

SaveSettings()
{
	global
	local settingsStr
	settingsStr = %offsetX%, %offsetY%, %buttonSize%
	IfExist, %settingsFilename%
	{
		FileDelete, %settingsFilename%
	}
	FileAppend, %settingsStr%, %settingsFilename%
}

LoadSettings()
{
	global
	local arr, str
	IfExist, %settingsFilename%
	{
		FileRead, str, %settingsFilename%
		StringSplit, arr, str, `,
		offsetX = %arr1%
		offsetY = %arr2%
		buttonSize = %arr3%
	}
}

SetOriginAtMouse()
{
	global offsetX, offsetY
	MouseGetPos, offsetX, offsetY
	;Msgbox, Offset %offsetX%, %offsetY%
	SaveSettings()
}

ClickButton(row, col)
{
	global offsetX, offsetY, buttonSize

	x := col * buttonSize + offsetX
	y := row * buttonSize + offsetY

	MouseGetPos, oldX, oldY
	Click %x%, %y%
	MouseMove %oldX%, %oldY%
}


; Keybindings

~Pause::
	SetCapsLockState, Off
	ExitApp
return
~+Pause::Reload

; Key-to-Button

#IfWinNotActive Age of Empires

~CapsLock::
	keymapEnabled := False
Return

#IfWinActive Age of Empires

~CapsLock::
	if (GetKeyState("CapsLock", "T"))
	{
		keymapEnabled := True
	}
	else
	{
		keymapEnabled := False
	}
Return

$+CapsLock::SetOriginAtMouse()

#If (keymapEnabled)

$+e::Send, {Up}
$+s::Send, {Left}
$+d::Send, {Down}
$+f::Send, {Right}
$+g::Send, g

$q::ClickButton(0, 0)
$w::ClickButton(0, 1)
$e::ClickButton(0, 2)
$r::ClickButton(0, 3)
$t::ClickButton(0, 4)

$a::ClickButton(1, 0)
$s::ClickButton(1, 1)
$d::ClickButton(1, 2)
$f::ClickButton(1, 3)
$g::ClickButton(1, 4)

$z::ClickButton(2, 0)
$x::ClickButton(2, 1)
$c::ClickButton(2, 2)
$v::ClickButton(2, 3)
$b::ClickButton(2, 4)

