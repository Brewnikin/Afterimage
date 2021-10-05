#To run: powershell -ep Bypass C:\afterimage.ps1
$installPath = Test-Path C:\Installs

#If Installs Directory does not exists, create it.
if(!($installPath -eq $true))
{ 
New-Item -ItemType directory -Path C:\Installs #Make Directory for Installing Programs
}

do{
#Prompt for User Input
$Prompt = Read-host "`r`nSelect From The Options Below: 
1. Avast Antivirus Download
2. Box Tools Download
3. AVG Antivirus Download
4. Add new Local User Account
5. Set new IP Address
6. Get Serial Number
9. Quit
Select Number" 
Switch ($Prompt) #Switch statement for what ever needs to be done.
 {
   1 {Write-Host "License key: B4CC-X13V-AP4J-XYGR-F57J "; Invoke-WebRequest -Uri "https://www.avast.com/en-us/download-thank-you.php?product=FAV-ONLINE&locale=en-us&direct=1" -OutFile "C:\Installs\InstallerAVOne.exe"; & 'C:\\Installs\InstallerAVOne.exe'}
   2 {Invoke-WebRequest -Uri "https://e3.boxcdn.net/box-installers/boxedit/win/currentrelease/BoxToolsInstaller.exe" -OutFile "C:\Installs\BoxToolsInstall.exe"; & 'C:\\Installs\BoxToolsInstall.exe'}
   3 {Invoke-WebRequest -Uri "https://bits.avcdn.net/productfamily_ANTIVIRUS/insttype_FREE/platform_WIN_AVG/installertype_ONLINE/build_RELEASE/cookie_mmm_bav_003_999_a5c_m" -OutFile "C:\Installs\InstallerAVTwo.exe"; & 'C:\\Installs\InstallerAVTwo.exe'}
   4 {$Username = Read-Host -Prompt 'Input Username' 
        $Password = Read-Host -Prompt 'Input Password'

        $group = "Administrators"
        
        $adsi = [ADSI]"WinNT://$env:COMPUTERNAME"
        $existing = $adsi.Children | where {$_.SchemaClassName -eq 'user' -and $_.Name -eq $Username }

        if ($existing -eq $null) {

            Write-Host "Creating new local user $Username."
            & NET USER $Username $Password /add /y /expires:never
    
            Write-Host "Adding local user $Username to $group."
            & NET LOCALGROUP $group $Username /add

        }
        else {
            Write-Host "Setting password for existing local user $Username."
            $existing.SetPassword($Password)
        }

        Write-Host "Ensuring password for $Username never expires."
        & WMIC USERACCOUNT WHERE "Name='$Username'" SET PasswordExpires=FALSE
        }
    5 {$IP = Read-Host -Prompt 'Input IP Address'
$MaskBits = Read-Host -Prompt 'Input Subnet Mask (ex: 24 will result in a subnet mask of 255.255.255.0)' # /24 = 255.255.255.0 
$Gateway = Read-Host -Prompt 'Input Gateway Address'
$Dns = Read-Host -Prompt 'Input DNS Server'
$Dns1 = Read-Host -Prompt 'Input Alternate DNS Server'
$IPType = "IPv4"
# Retrieve the network adapter that you want to configure
$adapter = Get-NetAdapter | ? {$_.Status -eq "up"}
# Remove any existing IP, gateway from our ipv4 adapter
If (($adapter | Get-NetIPConfiguration).IPv4Address.IPAddress) {
 $adapter | Remove-NetIPAddress -AddressFamily $IPType -Confirm:$false
}
If (($adapter | Get-NetIPConfiguration).Ipv4DefaultGateway) {
 $adapter | Remove-NetRoute -AddressFamily $IPType -Confirm:$false
}
 # Configure the IP address and default gateway
$adapter | New-NetIPAddress `
 -AddressFamily $IPType `
 -IPAddress $IP `
 -PrefixLength $MaskBits `
 -DefaultGateway $Gateway
# Configure the DNS client server IP addresses
$adapter | Set-DnsClientServerAddress -ServerAddresses $DNS, $DNS1}
    6 {Write-host "`r`n"; wmic bios get serialnumber}
    7 {Write-host "`r`nPlease select a number between 1-6"}
    8 {Write-host "`r`nPlease select a number between 1-6"}
    
    }
 } 
 while(!($prompt -notmatch "[012345678]"))
