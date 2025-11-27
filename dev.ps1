# dev.ps1
$packagePath = "package.json"

Write-Host "Starting local development server..." -ForegroundColor Cyan

Write-Host "Setting homepage to empty string in package.json..."
(Get-Content $packagePath) -replace '("homepage"\s*:\s*")[^"]*', '${1}' | Set-Content $packagePath
Write-Host "Homepage cleared for local development" -ForegroundColor Green
Write-Host "Checking Node.js installation..."


# Try to find node on the system
$node = Get-Command node -ErrorAction SilentlyContinue
if (-not $node) {
    Write-Warning "Node.js is NOT installed. Please download from https://nodejs.org/"
} else {
    Write-Host "Node.js found at: $($node.Source)"
    $nodeDir = Split-Path $node.Source

    if (-not ($env:Path -like "*$nodeDir*")) {
        Write-Host "Adding Node.js to PATH..."
        [Environment]::SetEnvironmentVariable(
            "Path",
            $env:Path + ";$nodeDir",
            [EnvironmentVariableTarget]::User
        )
    } else {
        Write-Host "Node.js already in PATH"
    }

    node -v
}

Write-Host "`nChecking Git installation..." -ForegroundColor Cyan

# Try to find git on the system
$git = Get-Command git -ErrorAction SilentlyContinue
if (-not $git) {
    Write-Warning "Git is NOT installed. Please download from https://git-scm.com/"
} else {
    Write-Host "Git found at: $($git.Source)"
    $gitDir = Split-Path $git.Source

    if (-not ($env:Path -like "*$gitDir*")) {
        Write-Host "Adding Git to PATH..."
        [Environment]::SetEnvironmentVariable(
            "Path",
            $env:Path + ";$gitDir",
            [EnvironmentVariableTarget]::User
        )
    } else {
        Write-Host "Git already in PATH"
    }

    git -v
}

$node = Get-Command node -ErrorAction SilentlyContinue
if (-not $node) {
    Write-Warning "Node.js is NOT installed. Please download from https://nodejs.org/"
    exit 1
} else {
    Write-Host "Node.js found at: $($node.Source)"
    node -v
}

Write-Host ""
Write-Host "Checking Git installation..."
$git = Get-Command git -ErrorAction SilentlyContinue

if (-not $git) {
    Write-Warning "Git is NOT installed. Please download from https://git-scm.com/"
} else {
    Write-Host "Git found at: $($git.Source)"
    git --version
}

Write-Host ""
Write-Host "Installing npm dependencies..."
npm install

if ($LASTEXITCODE -ne 0) {
    Write-Host "npm install failed." -ForegroundColor Red
    exit 1
}

Write-Host ""
Write-Host "Starting development server (npm start)..."
npm start