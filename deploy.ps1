# deploy.ps1

param(
    [Parameter(Mandatory=$true)]
    [string]$GITHUB_USERNAME,
    [string]$REPO_NAME
)

# LOCAL VARS
$packagePath = "package.json"
$repoURL = "https://github.com/$GITHUB_USERNAME/$REPO_NAME.git"
$homepageURL = "https://$GITHUB_USERNAME.github.io/$REPO_NAME"

Write-Host "Github Username: $GITHUB_USERNAME"
Write-Host "Repository Name: $REPO_NAME"

# Update homepage in package.json
Write-Host "Updating homepage field in package.json..."
(Get-Content $packagePath) -replace '("homepage"\s*:\s*")[^"]*', "`$1$homepageURL" | Set-Content $packagePath
Write-Host "package.json homepage updated successfully to $homepageURL"

# Verify the change
Write-Host "Verifying update..."
$verifyText = Get-Content $packagePath -Raw
if ($verifyText -match '"homepage"\s*:\s*"([^"]*)"') {
    Write-Host "Current homepage value: $($Matches[1])" -ForegroundColor Cyan
}

# Install gh-pages if missing
if (-not (Test-Path "node_modules\gh-pages")) {
    Write-Host "Installing gh-pages..."
    npm install --save-dev gh-pages
} else {
    Write-Host "gh-pages already installed."
}

# Initialize git if needed
if (-not (Test-Path ".git")) {
    Write-Host "Initializing git repository..."
    git init
}

# Ensure origin remote is set
$remotes = git remote 2>$null
if ($remotes -notcontains "origin") {
    Write-Host "Adding remote origin..."
    git remote add origin $repoURL
} else {
    Write-Host "Remote origin already set."
}

Write-Host "Building project..."
npm run build

if ($LASTEXITCODE -ne 0) {
    Write-Host "Build failed!" -ForegroundColor Red
    exit 1
}

Write-Host "Deploying to GitHub Pages..."
npm run deploy

if ($LASTEXITCODE -ne 0) {
    Write-Host "Deployment failed!" -ForegroundColor Red
    exit 1
}

Write-Host "Deployment complete!" -ForegroundColor Green