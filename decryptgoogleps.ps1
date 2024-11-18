param (
    [Parameter(Mandatory=$true)]
    [string]$InputFilePath,

    [Parameter(Mandatory=$true)]
    [string]$OutputFilePath
)

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
