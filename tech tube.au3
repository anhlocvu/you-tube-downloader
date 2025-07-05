#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Res_Comment=youtube downloader
#AutoIt3Wrapper_Res_Description=đây là phần mềm tải audio video từ youtube được phát triển bởi anh lộc
#AutoIt3Wrapper_Res_Fileversion=3.0
#AutoIt3Wrapper_Res_ProductName=youtube downloader
#AutoIt3Wrapper_Res_ProductVersion=3.0
#AutoIt3Wrapper_Res_CompanyName=technology entertainment studio
#AutoIt3Wrapper_Res_LegalCopyright=anhloc
#AutoIt3Wrapper_Res_LegalTradeMarks=anhloc
#AutoIt3Wrapper_Res_Language=1033
#AutoIt3Wrapper_Res_requestedExecutionLevel=None
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#include <GUIConstants.au3>
#include <ColorConstants.au3>
#include "module/dlp.au3"
$version="3.0"

if Not FileExists("download") Then
DirCreate("download")
EndIf
RunWait(@ComSpec & " /c yt-dlp -U",@ScriptDir,@SW_SHOW)
SoundPlay(@ScriptDir&"\data\sounds\start.mp3")
$mainform=GUICreate("tech tube, version "&$version, 400, 400)
GUISetBkColor($COLOR_BLUE)
GUICtrlCreateTab(10,300,380,40)
GUICtrlCreateTabItem("you tube &downloader")
GUICtrlCreateLabel("&Enter the URL link of the video you want to download here:", 10, 10, 380, 40)
$edit=GUICtrlCreateInput("", 10, 40, 380, 20)
$clip=ClipGet()

if StringInStr($clip, "youtube.com") Then
GUICtrlSetData($edit, $clip)
EndIf
$paste=GUICtrlCreateButton("&paste link", 320, 80, 70, 20)
$dl_video=GUICtrlCreateButton("download &video", 150, 120, 150, 20)
$dl_mp3=GUICtrlCreateButton("download with &mp3 format", 150, 160, 150, 20)
$dl_wav=GUICtrlCreateButton("download with &wav format", 150, 200, 150, 20)
$openbtn=GUICtrlCreateButton("&Open the download folder", 150, 240, 150, 20)
GUICtrlCreateTabItem("you tube &player")
GUICtrlCreateLabel("Enter the video link you want to play",10,10,380,20)
$linkedit=GUICtrlCreateInput("",10,30,380,20)
$play_btn=GUICtrlCreateButton("play with the default media player",200,80,100,40)
$online_play_btn=GUICtrlCreateButton("play in the default browser",200,140,100,40)
$menu=GUICtrlCreateMenu("help")
$menu1=GUICtrlCreateMenuItem("About and readme", $menu)
$menu2=GUICtrlCreateMenuItem("exit", $menu)
GUISetState(@SW_SHOW, $mainform)


while 1
$msg=GUIGetMsg()
Switch $msg
	Case $GUI_EVENT_CLOSE, $menu2
SoundPlay("data/sounds/exit.mp3", 1)
Exit
Case $dl_video
$url=GUICtrlRead($edit)
if $url="" Then
MsgBox(16,"Error", "Do not leave empty, enter a URL leading to the video link you want to download")
Else
dlvideo($url)
EndIf
Case $paste
GUICtrlSetData($edit, $clip)

Case $dl_mp3
$url=GUICtrlRead($edit)
if $url="" Then
MsgBox(16,"Error", "Do not leave empty, enter a URL leading to the video link you want to download")
Else
dlmp3($url)
EndIf

	Case $dl_wav
	$url=GUICtrlRead($edit)
if $url="" Then
MsgBox(16,"Error", "Do not leave empty, enter a URL leading to the video link you want to download")
Else
dlwav($url)
EndIf

	Case $openbtn
ShellExecute(@ScriptDir & "\download")

Case $menu1
about()


	Case $play_btn
$input_text=GUICtrlRead($linkedit)
If $input_text="" Then
MsgBox(16,"error","you must enter the video link you want to play")
ContinueLoop
EndIf
playmedia($input_text)
	Case $online_play_btn
$input_text=GUICtrlRead($linkedit)
If $input_text="" Then
MsgBox(16,"error","you must enter the video link you want to play")
ContinueLoop
EndIf
online_play($input_text)
EndSwitch

WEnd


Func about()
$agui=GUICreate("about", 400, 400)
GUISetBkColor($COLOR_BLUE)
GUICtrlCreateTab(10, 10, 480, 20)
GUICtrlCreateTabItem("about")
$abouttext=FileRead(@ScriptDir & "\data\dock\about.txt")
$atxt=GUICtrlCreateEdit($abouttext, 10, 40, 380, 250, BitOR($ES_READONLY, $WS_TABSTOP))



GUICtrlCreateTabItem("read me")
$readmebox=GUICtrlCreateEdit(FileRead(@ScriptDir &"\\data\dock\readme.txt"), 10, 40, 380, 250)

GUICtrlCreateTabItem("contact")
$fb=GUICtrlCreateButton("face book", 10, 40, 180, 20)
$email=GUICtrlCreateButton("email", 10, 80, 180, 20)
$telegram=GUICtrlCreateButton("telegram", 10, 120, 180, 20)

GUICtrlCreateTabItem("")
$Close=GUICtrlCreateButton("close", 320, 300, 70, 20)
GUISetState(@SW_SHOW, $agui)

while 1
$msg=GUIGetMsg()
Switch $msg


	Case $GUI_EVENT_CLOSE, $Close
GUIDelete($agui)
ExitLoop
Case $fb
ShellExecute("https://www.facebook.com/anhloc2004/")
	Case $email
ClipPut("locvuu2105@gmail.com")
MsgBox(64,"Email has been copied","locvuu2105@gmail.com")
	Case $telegram
ShellExecute("https://t.me/Loc2004")

EndSwitch

WEnd

EndFunc