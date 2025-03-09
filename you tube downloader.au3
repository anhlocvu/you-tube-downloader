#include <GUIConstants.au3>
#include <ColorConstants.au3>
$version="1.0"

if Not FileExists("download") Then
DirCreate("download")
EndIf
RunWait(@ComSpec & " /c yt-dlp -U",@ScriptDir,@SW_SHOW)
$mainform=GUICreate("you tube downloader, version "&$version, 400, 400)
GUISetBkColor($COLOR_BLUE)
GUICtrlCreateLabel("Enter the URL link of the video you want to download here", 10, 10, 380, 40)
$edit=GUICtrlCreateInput("", 10, 40, 380, 20)
$clip=ClipGet()

if StringInStr($clip, "youtube.com") Then
GUICtrlSetData($edit, $clip)
EndIf
$paste=GUICtrlCreateButton("paste link", 320, 80, 70, 20)
$dl_video=GUICtrlCreateButton("download &video", 150, 120, 150, 20)
$dl_mp3=GUICtrlCreateButton("download with &mp3 format", 150, 160, 150, 20)
$dl_wav=GUICtrlCreateButton("download with &wav format", 150, 200, 150, 20)
$openbtn=GUICtrlCreateButton("Open the download folder", 150, 240, 150, 20)
$menu=GUICtrlCreateMenu("help")
$menu1=GUICtrlCreateMenuItem("About and readme", $menu)
$menu2=GUICtrlCreateMenuItem("exit", $menu)
GUISetState(@SW_SHOW, $mainform)


while 1
$msg=GUIGetMsg()
Switch $msg
	Case $GUI_EVENT_CLOSE, $menu2
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



EndSwitch

WEnd

Func dlmp3($link)
GUISetState(@SW_HIDE, $mainform)
Global $cmd=' /c yt-dlp -P "./download/mp3" --ffmpeg-location "lib/ffmpeg.exe" -x --audio-format mp3 '
RunWait(@ComSpec & $cmd & $link, @ScriptDir, @SW_SHOW)
MsgBox(64, "Notice", "you downloaded the mp3 to complete")
GUISetState(@SW_SHOW, $mainform)


EndFunc

Func dlvideo($link)
	GUISetState(@SW_HIDE, $mainform)
Global $cmd=' /c yt-dlp -P "./download/video" '
RunWait(@ComSpec & $cmd & $link, @ScriptDir, @SW_SHOW)
MsgBox(64, "Notice", "you downloaded the video to complete")
GUISetState(@SW_SHOW, $mainform)
EndFunc

Func dlwav($link)
GUISetState(@SW_HIDE, $mainform)
Global $cmd=' /c yt-dlp -P "./download/wav" --ffmpeg-location "lib/ffmpeg.exe" -x --audio-format wav '
RunWait(@ComSpec & $cmd & $link, @ScriptDir, @SW_SHOW)
MsgBox(64, "Notice", "you downloaded the wav to complete")
GUISetState(@SW_SHOW, $mainform)


EndFunc

Func about()
$agui=GUICreate("about", 400, 400)
GUISetBkColor($COLOR_BLUE)
GUICtrlCreateTab(10, 10, 480, 20)
GUICtrlCreateTabItem("about")
$abouttext=FileRead(@ScriptDir & "\data\dock\about.txt")
$atxt=GUICtrlCreateEdit($abouttext, 10, 40, 380, 250, BitOR($ES_READONLY, $WS_TABSTOP))



GUICtrlCreateTabItem("read me")
$readmebox=GUICtrlCreateEdit("There is no guide for this application, we will update the instructions in the future", 10, 40, 380, 250)

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