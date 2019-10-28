' Gain administrator execution rights; we use PsExec to run our PowerShell script as NT-AUTHORITY\SYSTEM, for which we require administrator privileges
If Not WScript.Arguments.Named.Exists("elevate") Then
  CreateObject("Shell.Application").ShellExecute WScript.FullName _
    , """" & WScript.ScriptFullName & """ /elevate", "", "runas", 1
  WScript.Quit
End If

' Obtain the folder path in which this file is located
' Note that this script assumes that all required files are in the same folder
Set objShell = WScript.CreateObject("WScript.Shell")
strPath = Wscript.ScriptFullName
Set objFSO = CreateObject("Scripting.FileSystemObject")
Set objFile = objFSO.GetFile(strPath)
strFolder = objFSO.GetParentFolderName(objFile)

' Verify that the required files are present
If Not objFSO.FileExists(strFolder & "\psexec.exe") Then
	WScript.Echo "Could not find PsExec.exe. Make sure it is present in the same folder as launcher.vbs."
	WScript.Quit
End If

If Not objFSO.FileExists(strFolder & "\disable_waketorun_tasks.ps1") Then
	WScript.Echo "Could not find disable_waketorun_tasks.ps1. Make sure it is present in the same folder as launcher.vbs."
	WScript.Quit
End If

' Run PowerShell script invisibly as NT-AUTHORITY\SYSTEM
' Set intWindowStyle to 0, since we want the script to be running invisibly
' Set bWaitOnReturn to False, since the script we are running will loop continuously
objShell.Run(strFolder & "\psexec -i -s powershell -windowstyle hidden " & strFolder & "\disable_waketorun_tasks.ps1"), 0, False

' Terminate this script once it has launched the PowerShell script
WScript.Quit