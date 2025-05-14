# System Setup

## Install

Installation is designed for the Fedora custom installation with Fedora Everything. 

If the device is a laptop make sure to connect it via ethernet or USB tethering. The WiFi firmware might have to be installed separately, including the ``NetworkManager-wifi`` package.

For default installation:

```shell
bash -c "$(curl -fsSL https://raw.githubusercontent.com/SkMag9/.dotfiles/refs/heads/v2.0/install.sh)"
# Edit Files
cd .dotfiles
ansible-galaxy collection install -r requirements.yml
ansible-playbook --ask-become-pass main.yml
```

For customized installation:

- Clone the repository and adjust values in the ``group_vars/all.yml`` file.

## App Specific Configs

### Hyprland

- Set the correct monitor in ``roles/hyprland/files/monitors.conf``
- Default Keyboard Layout is de_CH


## ToDo

- [ ] Screen shot utility
- [ ] Notifications
- [ ] Pipewire + wireplumber
- [ ] XDG Desktop Portal
- [ ] Authentication Agent
- [ ] Qt Wayland Support
- [ ] Lock Screen
- [ ] Idle
- [ ] Finalize Waybar Config
- [ ] Fingerprint Unlock
- [ ] Greetd Permissions
- [ ] Rofi Power Menu
