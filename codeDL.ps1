
curl.exe -L "https://github.com/Kiliken/ue5-cmdlineTools-setup/archive/refs/heads/main.tar.gz" -o "$(gl)\main.tar.gz" --progress-bar

tar -xzf "$(gl)\main.tar.gz" -C "$(gl)"

Move-Item "$(gl)\ue5-cmdlineTools-setup-main\*" "$(gl)" -Force
Remove-Item "$(gl)\ue5-cmdlineTools-setup-main" -Recurse -Force
Remove-Item "$(gl)\main.tar.gz" -Force
