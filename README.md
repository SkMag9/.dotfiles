# dotfiles

Dotfile Setup for Debian.

## Setup

```bash
sudo apt update && sudo apt upgrade -y
sudo apt install git
git clone https://github.com/skmag9/.dotfiles ~/.dotfiles
cd .dotfiles
./init.sh
# Restart Shell
```

## Future Plans
- [ ] Writing to a log with the status of the script
- [ ] Make more interactive install with possibilities to chose specific things
- [ ] Finish Config Backup Function
- [ ] Remove need to include two parameters because of how paths are constructed
- [ ] Make ``backup_config()`` check the amount of arguments as failsafe
- [ ] Refactor ``backup_config()`` to accept multiple paths and backup all of them 
- [ ] Change NTP so it doesn't Require root
