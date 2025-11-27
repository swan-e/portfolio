# Initialize git

# Check if .git exists
if (-not (Test-Path ".git")) {
    Write-Host "Git not properly initialzed. Exiting..." -ForegroundColor Red
    exit 1 
}

Write-Host "Staging all changes..."
git add -A

Write-Host "Committing..."
git commit -m "Autocommit"

Write-Host "Pushing to gh-pages..."
git push origin master:gh-pages --force

Write-Host "Done! Now run: .\deploy.ps1" -ForegroundColor Green