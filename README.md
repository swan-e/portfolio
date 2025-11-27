<!-- markdownlint-disable MD012 MD033 MD032 MD034-->
# Quick Start for this React App

1. Open VSCode and open this folder.
2. Open a terminal in VS Code.
3. Install git and node.js
4. To deploy to GitHub Pages:
   Edit <github-username> and <repo-name> in:
   - deploy.ps1 (FOR WINDOWS )
   - deploy.sh (FOR MAC/LINUX)
5. Run dev:
     IF ON WINDOWS:
     1. Unblock-File .\dev.ps1
     2. Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Scope CurrentUser
     3. .\dev.ps1

     IF ON LINUX/MACOS:
     1. chmod +x dev.sh
     2. ./dev.sh
6. Run deploy:
     IF ON WINDOWS:
     1. Unblock-File .\deploy.ps1
     2. Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Scope CurrentUser
     3. .\deploy.ps1

     IF ON LINUX/MACOS:
     1. chmod +x deploy.sh
     2. ./deploy.sh
7. After 6 is done, Run gitadd:
    IF ON WINDOWS:
    1. Unblock-File .\gitadd.ps1
    2. .\gitadd.ps1 (ON WINDOWS)

    IF ON LINUX/MACOS:
    1. chmod +x gitadd.sh
    2. ./gitadd.sh (ON LINUX/MACOS)
   Then Run Step 5. commands again (deploys)
8. Run deploy:
     IF ON WINDOWS:
     1. .\deploy.ps1

     IF ON LINUX/MACOS:
     1. ./deploy.sh
9. Open up https://<your-github-username>.github.io/<your-repo-name>/ in your browser
10. Run step 7 and then 8 again if you make changes to website


TROUBLESHOOTING
1. If you are getting

remote: Repository not found.
fatal: repository 'https://github.com/<wrong-username>/<wrong-repo>.git/' not found

That means you gave the wrong username or repo name

Run these commands to fix:
- git remote remove
- git remote set-url origin https://github.com/<right-username>/<right-repo>.git
- DELETE <NODE_MODULES> AND <BUILD> FOLDERS
- REPEAT FROM STEP 4
- git remote -v (check that you added the right one)

2. If you are getting

remote: Internal Server Error
fatal: unable to access 'https://github.com/swan-e/portfolio.git/': The requested URL returned error: 500

Run these commands to fix:
- (FOR WINDOWS) Remove-Item -Recurse -Force "node_modules\.cache\gh-pages" -ErrorAction SilentlyContinue 
