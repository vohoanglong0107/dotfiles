# Dotfiles

## Setup

Install [chezmoi](https://www.chezmoi.io/)

```bash
# for local machine
chezmoi init https://github.com/vohoanglong0107/containers
# for server or container
chezmoi init https://github.com/vohoanglong0107/containers --promptBool "Is this a server?"=true

# Follow instructions in https://wezterm.org/config/lua/config/term.html for setting up wezterm terminfo
```

### Windows

#### Restore default path (without oneDrive)

- Open Registry Editor and navigate to the following keys:
  - HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders
  - HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders
- Edit `Personal` values to point to local copy of Document instead of the OneDrive one

#### Disable `Windows-L` (lock screen)

This keymap can't be overriden by glazeWM

- Open Registry Editor and navigate to this key:
  - HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\System
  - Create `System` key if it doesn't already exist
- Creat a 32-bit DWORD named `DisableLockWorkstation`
- Set the value `DisableLockWorkstation` to `1`. This will take effect immediately

Ref: https://superuser.com/a/1096597

## Screenshots

### Fuzzel

![fuzzel](./screenshots/fuzzel.png)

### Neovim

![fuzzel](./screenshots/neovim.png)
