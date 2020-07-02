function Install-Software {
    [CmdletBinding()]
    Param(
        [string]$ComputerName
        [string]$SoftwarePath
        [string]$DestinationPath = "C:\options\software\"
    )
}
    foreach ($computer in $ComputerName) 
    {
    #This section will copy the $SoftwarePath to the $DestinationPath. If the Folder does not exist it will create it.
    if (!(Test-Path -path $DestinationPath))
    {
    New-Item $DestinationPath -Type Directory
    }
    Copy-Item -Path $SoftwarePath -Destination $DestinationPath
    Invoke-Command -ComputerName $computer -ScriptBlock { & cmd /c "msiexec.exe /i c:\options\{MSI_NAME}" /qn ADVANCED_OPTIONS=1 CHANNEL=100}
    }#foreach

} #function
