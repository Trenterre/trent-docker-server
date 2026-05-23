# deploy.ps1 - Safely deploy Docker configurations to the remote server
param(
    [string]$ServicePath = "app", # Subfolder or application path on remote server
    [switch]$ForceRebuild
)

$ErrorActionPreference = "Stop"

# 1. Define remote destination
$RemoteHost = "dockersrv"
$RemoteDir = "~/docker-deploy/$ServicePath"

Write-Host "🚀 Starting deployment to $RemoteHost..." -ForegroundColor Cyan

# 2. Check SSH connection
Write-Host "Checking SSH connection..."
ssh -o ConnectTimeout=5 -o BatchMode=yes -q $RemoteHost "exit"
if ($LASTEXITCODE -ne 0) {
    Write-Error "Failed to connect to remote server '$RemoteHost' via SSH. Please ensure the server is online and passwordless SSH is configured."
}

# 3. Ensure remote directory exists
Write-Host "Creating remote directory: $RemoteDir"
ssh $RemoteHost "mkdir -p $RemoteDir"

# 4. Copy files (docker-compose, configs, local .env if present)
Write-Host "Copying configuration files..."
if (Test-Path docker-compose.yml) {
    scp docker-compose.yml "${RemoteHost}:${RemoteDir}/"
} else {
    Write-Warning "No docker-compose.yml found in the local workspace. Copying other configuration files."
}

if (Test-Path .env) {
    scp .env "${RemoteHost}:${RemoteDir}/"
}

# 5. Run Docker Compose remotely
Write-Host "Deploying containers remotely..."
$ComposeCommand = "cd $RemoteDir && docker compose down && docker compose up -d"
if ($ForceRebuild) {
    $ComposeCommand = "cd $RemoteDir && docker compose down && docker compose pull && docker compose up -d --build"
}

ssh $RemoteHost $ComposeCommand

Write-Host "✅ Deployment completed successfully!" -ForegroundColor Green
