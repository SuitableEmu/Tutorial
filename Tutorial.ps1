#Made by https://github.com/SuitableEmu
 
 #Basic Install script
 
 # You will need a MSI file for the silent installation, this example uses a EXE
 # To get a MSI file download 7-Zip and extract it from the exe.
 # and change $outpath to a where the MSI file is

# Other Do Not Touch #

#-------------------------------------------------------------------------------------------------#

$dir ="C:\temp" 
if (!(Test-Path $dir)) {New-Item -Path $dir -ItemType container}
$ok = $answer -ne $NULL
$Se = [System.Environment]::Is64BitOperatingSystem
$wsh = New-Object -ComObject Wscript.Shell
$url = "ftp://ftp.adobe.com/pub/adobe/reader/win/AcrobatDC/2001220048/AcroRdrDC2001220048_en_US.exe" 
 
#-------------------------------------------------------------------------------------------------#

# Deployments #


$outpath = "$dir\Adobe_Reader.exe"


# Functions Do Not Touch #

#---------------------------------------------------------------------------------------------------#


function P-P($seconds) {
    $doneDT = (Get-Date).AddSeconds($seconds)
    while($doneDT -gt (Get-Date)) {
        $secondsLeft = $doneDT.Subtract((Get-Date)).TotalSeconds
        $percent = ($seconds - $secondsLeft) / $seconds * 100
        Write-Progress -Activity "Processing" -Status "Processing Information.." -SecondsRemaining $secondsLeft -PercentComplete $percent
        [System.Threading.Thread]::Sleep(10)
    }
   Write-Progress -Activity "Processing" -Status "Processing Information.." -SecondsRemaining 0 -Completed
}


Function Bloat-B-Gone {

Get-AppxPackage -name "Microsoft.ZuneMusic" | Remove-AppxPackage
Get-AppxPackage -name "Microsoft.Music.Preview" | Remove-AppxPackage
Get-AppxPackage -name "Microsoft.XboxIdentityProvider" | Remove-AppxPackage
Get-AppxPackage -name "Microsoft.BingTravel" | Remove-AppxPackage
Get-AppxPackage -name "Microsoft.BingHealthAndFitness" | Remove-AppxPackage
Get-AppxPackage -name "Microsoft.BingFoodAndDrink" | Remove-AppxPackage
Get-AppxPackage -name "Microsoft.People" | Remove-AppxPackage
Get-AppxPackage -name "Microsoft.BingFinance" | Remove-AppxPackage
Get-AppxPackage -name "Microsoft.3DBuilder" | Remove-AppxPackage
Get-AppxPackage -name "Microsoft.BingNews" | Remove-AppxPackage
Get-AppxPackage -name "Microsoft.XboxApp" | Remove-AppxPackage
Get-AppxPackage -name "Microsoft.BingSports" | Remove-AppxPackage
Get-AppxPackage -name "Microsoft.Getstarted" | Remove-AppxPackage
Get-AppxPackage -name "Microsoft.Office.OneNote" | Remove-AppxPackage
Get-AppxPackage -name "Microsoft.WindowsMaps" | Remove-AppxPackage
Get-AppxPackage -name "Microsoft.MicrosoftSolitaireCollection" | Remove-AppxPackage
Get-AppxPackage -name "Microsoft.MicrosoftOfficeHub" | Remove-AppxPackage
Get-AppxPackage -name "Microsoft.BingWeather" | Remove-AppxPackage
}


Function Pause ($Message = "Press any key to shutdown computer...") {
   # Check if running in PowerShell ISE
   If ($psISE) {
      # "ReadKey" not supported in PowerShell ISE.
      # Show MessageBox UI
      $Shell = New-Object -ComObject "WScript.Shell"
      $Button = $Shell.Popup("Click OK to continue.", 0, "Hello", 0)
      Return
   }
 
   $Ignore =
      16,  # Shift (left or right)
      17,  # Ctrl (left or right)
      18,  # Alt (left or right)
      20,  # Caps lock
      91,  # Windows key (left)
      92,  # Windows key (right)
      93,  # Menu key
      144, # Num lock
      145, # Scroll lock
      166, # Back
      167, # Forward
      168, # Refresh
      169, # Stop
      170, # Search
      171, # Favorites
      172, # Start/Home
      173, # Mute
      174, # Volume Down
      175, # Volume Up
      176, # Next Track
      177, # Previous Track
      178, # Stop Media
      179, # Play
      180, # Mail
      181, # Select Media
      182, # Application 1
      183  # Application 2
 
   Write-Host -NoNewline $Message
   While ($KeyInfo.VirtualKeyCode -Eq $Null -Or $Ignore -Contains $KeyInfo.VirtualKeyCode) {
      $KeyInfo = $Host.UI.RawUI.ReadKey("NoEcho, IncludeKeyDown")
   }
}


function Set-WindowStyle {
param(
    [Parameter()]
    [ValidateSet('FORCEMINIMIZE', 'HIDE', 'MAXIMIZE', 'MINIMIZE', 'RESTORE', 
                 'SHOW', 'SHOWDEFAULT', 'SHOWMAXIMIZED', 'SHOWMINIMIZED', 
                 'SHOWMINNOACTIVE', 'SHOWNA', 'SHOWNOACTIVATE', 'SHOWNORMAL')]
    $Style = 'SHOW',
    [Parameter()]
    $MainWindowHandle = (Get-Process -Id $pid).MainWindowHandle
)
    $WindowStates = @{
        FORCEMINIMIZE   = 11; HIDE            = 0
        MAXIMIZE        = 3;  MINIMIZE        = 6
        RESTORE         = 9;  SHOW            = 5
        SHOWDEFAULT     = 10; SHOWMAXIMIZED   = 3
        SHOWMINIMIZED   = 2;  SHOWMINNOACTIVE = 7
        SHOWNA          = 8;  SHOWNOACTIVATE  = 4
        SHOWNORMAL      = 1
    }
    Write-Verbose ("Set Window Style {1} on handle {0}" -f $MainWindowHandle, $($WindowStates[$style]))

    $Win32ShowWindowAsync = Add-Type –memberDefinition @” 
    [DllImport("user32.dll")] 
    public static extern bool ShowWindowAsync(IntPtr hWnd, int nCmdShow);
“@ -name “Win32ShowWindowAsync” -namespace Win32Functions –passThru

    $Win32ShowWindowAsync::ShowWindowAsync($MainWindowHandle, $WindowStates[$Style]) | Out-Null
}

# --------------------------------------------------------------------------------------------------#


######################################################################################################## --- Input Section --- ##################################################################################################



Write-Host "Please input some information before the script can run"

# Example #

Do {
 $Adobe = Read-Host "Do you want to Install Adobe Reader  Y/N"
if(($Adobe -ne "Y") -and ($Adobe -ne "N")){   
   Write-Host "Please Input AR or AP"

}

else {

}

}while (( $Adobe -gt "Y" ) -or ( $Adobe -lt "N" )) 



Clear
Write-Host "Thank you, Script will now run"
Clear
P-P 3
Write-Host "Running.."


################################################################################################################################### --- Script Starts Under here --- ###################################################################################



do {

if($Adobe -eq "Y") {
        Write-Host "Installing Adobe Reader"
        P-P 3
        Write-Host "Checking to see if Temp exists.."
        P-P 3
  if(Test-path $outpath) {
    Write-Host "Downloading from the server.."
        Start-Process -Filepath "$outpath" -ArgumentList /Quiet -Wait
        break
        } 
       
else { 
    try { 
        Invoke-WebRequest -Uri $url -OutFile $outpath -ErrorAction SilentlyContinue
} 
        
 catch { 
    [System.Windows.MessageBox]::Show("An unexpected error occurred. Contact your System Administrator.","Error SEA0001")
        Throw $_.Exception.Message
}
     Start-Process -Filepath "$outpath" -ArgumentList /Quiet
     Break
     }


}

elseif($Adobe -eq "N") {
        Write-Host "Skipping Adobe Reader"
        P-P 3
        Break
}
Else {
Break
}

}until($ok)

P-P 3
Write-Host "Script has Finished Running."
Pause
#Stop-Computer -ComputerName localhost
