#include <GUIConstants.au3>
#include <ColorConstants.au3>
$version="1.0"
RunWait(@ComSpec & " /c yt-dlp -U",@ScriptDir,@SW_SHOW)
$mainform=GUICreate("you tube downloader, version "&$version, 400, 400)
GUISetBkColor($COLOR_RED)
GUICtrlCreateLabel("Enter the URL link of the video you want to download here", 10, 10, 380, 40)
$edit=GUICtrlCreateInput("", 10, 10, 380, 20)
$clip=ClipGet()

if StringInStr($clip, "youtube.com") Then
GUICtrlSetData($edit, $clip)
EndIf
$paste=GUICtrlCreateButton("paste link", 350, 40, 30, 20)
$dl_video=GUICtrlCreateButton("download &video", 150, 80, 100, 20)
$dl_mp3=GUICtrlCreateButton("download with &mp3 format", 150, 120, 100, 20)
$dl_wav=GUICtrlCreateButton("download with &wav format", 150, 160, 100, 20)
GUISetState(@SW_SHOW, $mainform)


while 1
$msg=GUIGetMsg()
Switch $msg
	Case $GUI_EVENT_CLOSE
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
