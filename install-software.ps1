[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
while ((Get-Service RdAgent).Status -ne 'Running') { Start-Sleep -s 5 }
while ((Get-Service WindowsAzureGuestAgent).Status -ne 'Running') { Start-Sleep -s 5 }
Function Install-Terraform
{
    # Ensure to run the function with administrator privilege
    if (-not (New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator))
    { Write-Host -ForegroundColor Red -Object "!!! Please run as Administrator !!!"; return }
    # Local path to download the terraform zip file
    $DownloadPath = 'C:\Terraform\'
    $RegPathKey = 'HKLM:\System\CurrentControlSet\Control\Session Manager\Environment'
    if ((Test-Path -Path $DownloadPath) -eq $false) { $null = New-Item -Path $DownloadPath -ItemType Directory -Force }
    $DownloadLink='https://releases.hashicorp.com/terraform/0.13.5/terraform_0.13.5_windows_amd64.zip'
    $FileName = 'terraform_0.14.0_windows_amd64.zip'
    $DownloadFile = [string]::Concat( $DownloadPath, $FileName )
    Invoke-RestMethod -Method Get -Uri $DownloadLink -OutFile $DownloadFile
    # Extract & delete the zip file
    Expand-Archive -Path $DownloadFile -DestinationPath $DownloadPath -Force
    Remove-Item -Path $DownloadFile -Force
    # Setting the persistent path in the registry if it is not set already
    if ($DownloadPath -notin $($ENV:Path -split ';'))
    {
        $PathString = (Get-ItemProperty -Path $RegPathKey -Name PATH).Path
        $PathString += ";$DownloadPath"
        Set-ItemProperty -Path $RegPathKey -Name PATH -Value $PathString
        # Setting the path for the current session
        $ENV:Path += ";$DownloadPath"
    }
    # Verify the download
    Invoke-Expression -Command "terraform version"
}
function install-git {
    Param()
    if (!($IsLinux -or $IsOSX)) {
        $gitExePath = "C:\Program Files\Git\bin\git.exe"
        foreach ($asset in (Invoke-RestMethod https://api.github.com/repos/git-for-windows/git/releases/latest).assets) {
            if ($asset.name | Where-Object{($_ -match "Git") -and ($_ -match "64-bit.exe")}) {
                $dlurl = $asset.browser_download_url
                $newver = $asset.name
            }
        }
        try {
            $ProgressPreference = 'SilentlyContinue'
            if (!(Test-Path $gitExePath)) {
                Write-Host "`nDownloading latest stable git..." -ForegroundColor Yellow
                Remove-Item -Force $env:TEMP\git-stable.exe -ErrorAction SilentlyContinue
                Invoke-WebRequest -Uri $dlurl -OutFile $env:TEMP\git-stable.exe
                Write-Host "`nInstalling git..." -ForegroundColor Yellow
                Start-Process -Wait $env:TEMP\git-stable.exe -ArgumentList /silent
            }
            else {
                $updateneeded = $false
                Write-Host "`ngit is already installed. Check if possible update..." -ForegroundColor Yellow
                (git version) -match "(\d*\.\d*\.\d*)" | Out-Null
                $installedversion = $matches[0].split('.')
                $newver -match "(\d*\.\d*\.\d*)" | Out-Null
                $newversion = $matches[0].split('.')
                if (($newversion[0] -gt $installedversion[0]) -or ($newversion[0] -eq $installedversion[0] -and $newversion[1] -gt $installedversion[1]) -or ($newversion[0] -eq $installedversion[0] -and $newversion[1] -eq $installedversion[1] -and $newversion[2] -gt $installedversion[2])) {
                    $updateneeded = $true
                }
                if ($updateneeded) {
                    Write-Host "`nUpdate available. Downloading latest stable git..." -ForegroundColor Yellow
                    Remove-Item -Force $env:TEMP\git-stable.exe -ErrorAction SilentlyContinue
                    Invoke-WebRequest -Uri $dlurl -OutFile $env:TEMP\git-stable.exe
                    Write-Host "`nInstalling update..." -ForegroundColor Yellow
                    $sshagentrunning = get-process ssh-agent -ErrorAction SilentlyContinue
                    if ($sshagentrunning) {
                        Write-Host "`nKilling ssh-agent..." -ForegroundColor Yellow
                        Stop-Process $sshagentrunning.Id
                    }
                    Start-Process -Wait $env:TEMP\git-stable.exe -ArgumentList /silent
                } else {
                    Write-Host "`nNo update available. Already running latest version..." -ForegroundColor Yellow
                }
            }
                Write-Host "`nInstallation complete!`n`n" -ForegroundColor Green
        }
        finally {
            $ProgressPreference = 'Continue'
        }
    }
    else {
        Write-Error "This script is currently only supported on the Windows operating system."
    }
    $s = get-process ssh-agent -ErrorAction SilentlyContinue
    if ($s) {$true}
}
Invoke-WebRequest -Uri https://aka.ms/installazurecliwindows -OutFile .\AzureCLI.msi; Start-Process msiexec.exe -Wait -ArgumentList '/I AzureCLI.msi /quiet'; rm .\AzureCLI.msi
install-git
Install-Terraform
Install-PackageProvider NuGet -Force
Install-Module -Name PowerShellGet -Force
Update-Module -Name PowerShellGet -Force
Set-PSRepository PSGallery -InstallationPolicy Trusted
Install-Module -Name Az -AllowClobber -Force
Get-Module Az
