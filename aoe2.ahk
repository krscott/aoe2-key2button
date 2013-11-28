; AOE 2 Key-to-button mapping
; (and some other remappings)

; This script sends a click to the button corresponding to its distance
; from the origin (Key Q => Top Left Button)
;
; To reset origin location, use Shift+CapsLock

#IfWinActive Age of Empires
#SingleInstance force

CoordMode, Mouse, Screen
SetCapsLockState Off
SetDefaultMouseSpeed 0

; Variables

buttonSize := 42

; FE 1680 x 1050
offsetX := 266
offsetY := 892

; States

keyToClickState := 0

; Keybindings

~Pause::
	SetCapsLockState Off
	ExitApp
return

;$+e::CapsKey("E", "{Up}")
;$+s::CapsKey("S", "{Left}")
;$+d::CapsKey("D", "{Down}")
;$+f::CapsKey("F", "{Right}")
$+g::CapsKey("G", "g")

; Key-to-Button

~CapsLock::
	if (GetKeyState("CapsLock", "T"))
	{
		keyToClickState := 0
	}
	else
	{
		keyToClickState := 1
	}
return

$+CapsLock::SetOriginAtMouse()

$q::MapKeyToButton("q", 0, 0)
$w::MapKeyToButton("w", 1, 0)
$e::MapKeyToButton("e", 2, 0)
$r::MapKeyToButton("r", 3, 0)
$t::MapKeyToButton("t", 4, 0)

$a::MapKeyToButton("a", 0, 1)
$s::MapKeyToButton("s", 1, 1)
$d::MapKeyToButton("d", 2, 1)
$f::MapKeyToButton("f", 3, 1)
$g::MapKeyToButton("g", 4, 1)

$z::MapKeyToButton("z", 0, 2)
$x::MapKeyToButton("x", 1, 2)
$c::MapKeyToButton("c", 2, 2)
$v::MapKeyToButton("v", 3, 2)
$b::MapKeyToButton("b", 4, 2)


; Helper functions

CapsKey(def, key)
{
	global keyToClickState
	if (0 = keyToClickState)
	{
		Send %key%
	}
	else
	{
		Send %def%
	}
}

SetOriginAtMouse()
{
	global offsetX, offsetY
	MouseGetPos, offsetX, offsetY
	;Msgbox, Offset %offsetX%, %offsetY%
}

MapKeyToButton(letter, x, y)
{
	global offsetX, offsetY, buttonSize, keyToClickState
	if (0 = keyToClickState)
	{
		;Msgbox, %x%, %y%, %buttonSize%, %offsetX%, %offsetY%

		x := x * buttonSize + offsetX, y := y * buttonSize + offsetY

		MouseGetPos, oldX, oldY
		Click %x%, %y%
		MouseMove %oldX%, %oldY%

		;Msgbox, Click %x%, %y%
	}
	else
	{
		Send %letter%
	}
}

