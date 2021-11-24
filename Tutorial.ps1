#Made by https://github.com/SuitableEmu
 
 #Basic Install script
 
 # You will need a MSI file for the silent installation, this example uses a EXE
 # To get a MSI file download 7-Zip and extract it from the exe.
 # and change $outpath to a where the MSI file is

# Other Do Not Touch #

#-------------------------------------------------------------------------------------------------#


$dir ="C:\temp" 

# Creates C:\temp if it does not exist #
if (!(Test-Path $dir)) {New-Item -Path $dir -ItemType container}


# Use to direct to Null can also use Out-Null #
$ok = $answer -ne $NULL

# Use to check if 64 bit operating system #
$Se = [System.Environment]::Is64BitOperatingSystem

# Is not used in this script but can be usefull if you want to build on this script #
$wsh = New-Object -ComObject Wscript.Shell
 
#-------------------------------------------------------------------------------------------------#

# Deployments #

# URL to FTP works the best, and is recommended #
$url = "ftp://ftp.adobe.com/pub/adobe/reader/win/AcrobatDC/2001220048/AcroRdrDC2001220048_en_US.exe" 

# This is where the MSI or EXE file location goes, can copy paste to $outpath1, 2, 3 etc.. #
$outpath = "$dir\Adobe_Reader.exe"


# Functions Do Not Touch #

#---------------------------------------------------------------------------------------------------#


# Processing message just input "P-P x" Where you want this to show up #

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


# This is what shows the "Press any key to shutdown computer message at the end of the script #

Function Pause ($Message = "Press any key to shutdown computer...") {
   # Check if running in PowerShell ISE
   If ($psISE) {
      # "Pause" not supported in PowerShell ISE.
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


# --------------------------------------------------------------------------------------------------#


######################################################################################################## --- Input Section --- ##################################################################################################

# Intro can type what you want here #

Write-Host "Please input some information before the script can run"

# Example #

# This creates $Adobe and gives it a value in this case "Y" or "N" #

Do {
 $Adobe = Read-Host "Do you want to Install Adobe Reader  Y/N"
if(($Adobe -ne "Y") -and ($Adobe -ne "N")){   
   Write-Host "Please Input Y or N"

}

else {

}

}while (( $Adobe -gt "Y" ) -or ( $Adobe -lt "N" )) 


# Clear just clears the text it has already outputted #
Clear
Write-Host "Thank you, Script will now run"
Clear

# Here you see an example of "P-P x" function
P-P 3
Write-Host "Running.."


################################################################################################################################### --- Script Starts Under here --- ###################################################################################


# This is the actual script, it gets the value from $Adobe "Y" or "N"
# "Y" = Yes and "N" = No #

# So If $Adobe equals Yes check to see if exe is downloded (It will check C:\Temp to see if the exe is there.)
# if it is, run it.
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
     # else download it and run it  
else { 
    try { 
        Invoke-WebRequest -Uri $url -OutFile $outpath -ErrorAction SilentlyContinue
} 
  # Catch is for if it fails, it will give you and error message      
 catch { 
    [System.Windows.MessageBox]::Show("An unexpected error occurred. Contact your System Administrator.","Error SEA0001")
        Throw $_.Exception.Message
}
     Start-Process -Filepath "$outpath" -ArgumentList /Quiet
     Break
     }


}
  # elseif $Adobe = No, Skip it
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
# Example of "Pause" function
Pause
# This command shuts the computer off, it is commented out but you can remove the "#" to bring it back
#Stop-Computer -ComputerName localhost
