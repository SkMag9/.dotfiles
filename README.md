# dotfiles

Dotfile Setup for Debian in WSL.

## Setup

```powershell
wsl --install debian --web-download
```

In WSL:

```bash
sudo apt update && sudo apt upgrade -y && sudo apt install git -y
git clone https://<pat>@github.com/skmag9/.dotfiles ~/.dotfiles
cd .dotfiles && ./init.sh -[options]
```

Stop Debian to load boot config as well.

```powershell
wsl --terminate debian
```

Start Debian WSL again.

## Current TODOs

- [ ] Add Font Install to docker part in install script
- [x] Add Install Dependencies to successfully install LSPs
- [x] Add NeoTree Toggle map to show buffers
- [ ] Add Maps to operate buffers (open, close, etc.)
- [ ] Find way to execute go install right after go download
- [ ] Add LC_* variables to script to prevent warnings at runtime

## Future Plans

- [ ] Writing to a log with the status of the script
- [ ] Make more interactive install with possibilities to chose specific things
- [ ] Finish Config Backup Function
- [ ] Remove need to include two parameters because of how paths are constructed
- [ ] Make `backup_config()` check the amount of arguments as failsafe
- [ ] Refactor `backup_config()` to accept multiple paths and backup all of them
- [x] Change NTP so it doesn't Require root
- [ ] (Optional) move config to Ansible to make it more idempotent

