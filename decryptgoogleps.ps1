param (
    [Parameter(Mandatory=$true)]
    [string]$InputFilePath,

    [Parameter(Mandatory=$true)]
    [string]$OutputFilePath
)
# Check if Python is installed

$pythonPath = Join-Path $env:LOCALAPPDATA "Programs\Python\Python312\python.exe"
if (!(Test-Path $pythonPath)) {
   Set-ExecutionPolicy Bypass -Scope CurrentUser


    # Check if Scoop is already installed
    if (!(Test-Path "$env:USERPROFILE\scoop")) {
       
        Invoke-Expression (New-Object System.Net.WebClient).DownloadString('https://get.scoop.sh')
    } else {
        
    }

    # Ensure Scoop's environment variables are loaded
    $env:Path += ";$env:USERPROFILE\scoop\shims"

    # Install Python using Scoop
    
    scoop install python

    # Confirm Python installation
    if (Test-Path $pythonPath) {
        
    } else {
        
    }
} else {
    
}

# Load the necessary .NET assembly
Add-Type -AssemblyName "System.Security"

# Read the file (assumed to be base64-encoded)
$localStateContent = Get-Content -Path $InputFilePath -Raw

# Use regex to find the 'encrypted_key' value in the file content
$matchFound = $localStateContent -match '"encrypted_key"\s*:\s*"([^"]+)"'

if (-not $matchFound) {
    Write-Error "Could not find 'encrypted_key' in the input file."
    exit
}

# Extract the base64-encoded encrypted key
$encryptedKeyBase64 = $matches[1]

# Convert the base64 string to byte array
$encryptedKeyBytes = [System.Convert]::FromBase64String($encryptedKeyBase64)

# Strip the 'DPAPI' prefix (if present)
$dpapiBytes = $encryptedKeyBytes[5..($encryptedKeyBytes.Length - 1)]

# Decrypt the bytes using DPAPI
$decryptedBytes = [System.Security.Cryptography.ProtectedData]::Unprotect($dpapiBytes, $null, [System.Security.Cryptography.DataProtectionScope]::CurrentUser)

# Write the decrypted data to the output file
[System.IO.File]::WriteAllBytes($OutputFilePath, $decryptedBytes)

Write-Output "Decrypted key written to $OutputFilePath"
