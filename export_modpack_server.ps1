# Check if an argument is provided
if (-not $args[0]) {
    Write-Host "Usage: .\setup_server.ps1 <directory_name>"
    exit 1
}

# Save the current working directory
$originalDir = Get-Location

# Define the target directory
$targetDir = Join-Path -Path "builds\servers" -ChildPath $args[0]

# Attempt to create the directory if it doesn't exist
if (-not (Test-Path -Path $targetDir)) {
    New-Item -ItemType Directory -Path $targetDir | Out-Null
}

# Change to the target directory
Set-Location -Path $targetDir

# Run the specified command
Write-Host "Running packwiz installer bootstrap..."
Start-Process -FilePath "java" `
    -ArgumentList "-jar ../../packwiz-installer-bootstrap.jar -g -s server http://localhost:8080/pack.toml" `
    -NoNewWindow -Wait

# Return to the original directory
Set-Location -Path $originalDir

Write-Host "Script execution completed. Back to the original directory."
