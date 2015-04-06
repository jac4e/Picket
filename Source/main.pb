#WindowWidth  = 768
#WindowHeight = 512
Result$ = GetCurrentDirectory()

ImportC "msvcrt.lib"
  system(str.p-ascii)
EndImport


XIncludeFile "window.pbf"



OpenWindow_0()
Define logo = CatchImage(#PB_Any, ?Img)
SetGadgetState(Image_2, ImageID(logo))



Procedure StartHandler(EventType)
    
    file$ = OpenFileRequester("Select Server", ".spigot","Java (*.jar)|*.jar|All files (*.*)|*.*", 0)
  
  If CreateFile(0, "Start.bat")
    WriteStringN(0, "@ECHO off")
    WriteStringN(0, "cd .spigot")
    WriteStringN(0, "java -Xmx1024M -jar " + file$ + " -o true")
    CloseFile(0)
  EndIf
  
  OpenConsole("Server Console")
  RunProgram("Start.bat")
EndProcedure


;These two procedures do not work at the moment, PrintN does pass the command to server
Procedure StopHandler(EventType)
  PrintN("stop")
EndProcedure

Procedure InputHandler(EventType) 
  command$ = GetGadgetText(String_0)
  PrintN(command$)
EndProcedure

Procedure UpdateHandler(EventType)
  RunProgram("Update.sh")
EndProcedure

Procedure InstallHandler(EventType)
  RunProgram("Install.bat")
  RunProgram("Update.sh")
EndProcedure

Procedure Git(EventType)
RunProgram("http://msysgit.github.io/")  
EndProcedure

Procedure WebHome(EventType)
  SetGadgetText(#WebView_0, "http://www.spigotmc.org")
EndProcedure

Procedure ForumLink(EventType)
  RunProgram("http://http://www.minecraftforum.net/forums/mapping-and-modding/minecraft-tools/2397414-wip-picket-a-simple-server-wrapper-spigot")
EndProcedure

Procedure GithubLink(EventType)
  RunProgram("https://github.com/jaclegonetwork/Picket")
EndProcedure 
If CreateFile(0, "Install.bat")
  WriteStringN(0, "@ECHO off")
  WriteStringN(0, "DEL /Q .spigot")
  WriteStringN(0, "mkdir .spigot")
  WriteStringN(0, "cd .spigot")
  WriteStringN(0, "bitsadmin /Transfer buildtools /Download https://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar " + Result$ + ".spigot\BuildTools.jar")
  WriteStringN(0, "java -jar BuildTools.jar")
  WriteStringN(0, "pause") 
  CloseFile(0)
EndIf

If CreateFile(0, "Update.sh")
  WriteStringN(0, "cd .spigot") 
  WriteStringN(0, "java -jar BuildTools.jar") 
  CloseFile(0)
EndIf 

  Repeat
    Event = WaitWindowEvent()
    
    Select EventWindow()
        
        
      Case Window_0
        Window_0_Events(Event)
    EndSelect
    
  Until Event = #PB_Event_CloseWindow ; Quit on any window close
  
DataSection
  Img: 
   IncludeBinary "logo.bmp"
EndDataSection 

  
End   ; All the opened windows are closed automatically by PureBasic

; IDE Options = PureBasic 5.31 (Windows - x64)
; CursorPosition = 30
; Folding = H9
; EnableUnicode
; EnableXP
; UseIcon = computer-icon.ico
; Executable = ..\..\..\Desktop\Launcher.exe
; DisableDebugger