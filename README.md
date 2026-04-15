# My Personal NixOS Configuration and a Simple NixOS Beginner Guide
Welcome to my definitely totally fantastic and not at all randomly pieced together NixOS Configuration! :D
I am planning to use this repository for two purposes: to host my nixos configuration and to act as a simple beginner friendly tutorial for transitioning to NixOS.


## Table of Contents






## Tech Stack

### Core Operating System
| Software / Tool | Description / Role |
| :--- | :--- |
| **NixOS** | The foundational declarative operating system. |
| **Flakes & Home Manager** | Tools used to manage system reproducibility and user-specific configurations declaratively. |
| **GRUB** | The bootloader, specifically configured with a Minecraft-style theme (`minegrub`). |

### Desktop Environments
| Software / Tool | Description / Role |
| :--- | :--- |
| **Hyprland** | The primary, dynamic tiling Wayland compositor. |
| **KDE Plasma** | A traditional desktop environment configured as a reliable fallback. (note I don't often use this, so there could be issues with it) |

### Hyprland Ecosystem
| Software / Tool | Description / Role |
| :--- | :--- |
| **Waybar** | Highly customizable status bar for Wayland. |
| **Rofi** | Application launcher and search utility. |
| **Dunst** | Lightweight desktop notification daemon. |
| **Wlogout** | Wayland-based logout and power management menu. |
| **Hyprpaper / Hyprlock / Hypridle** | Wallpaper management, screen locking, and idle management natively built for Hyprland. |

### Terminal & Shell
| Software / Tool | Description / Role |
| :--- | :--- |
| **Kitty** | The default, GPU-accelerated terminal emulator. |
| **Fish** | The default user shell, featuring robust auto-completion and syntax highlighting. |
| **Starship** | Fast, highly customizable cross-shell prompt. |
| **Atuin** | Magical shell history sync and search tool via an SQLite database. |

### Text Editors & IDEs
| Software / Tool | Description / Role |
| :--- | :--- |
| **Neovim** | Highly customized modal terminal editor. |
| **Doom Emacs** | Configuration framework for GNU Emacs tailored for speed and Vim keybindings. |
| **VS Code / IntelliJ** | Supported GUI-based code editors with custom window rules for seamless Hyprland integration. |

### Networking & VPN
| Software / Tool | Description / Role |
| :--- | :--- |
| **NordVPN / Wgnord** | VPN integration explicitly using WireGuard via the wgnord utility. |

### Storage & Syncing
| Software / Tool | Description / Role |
| :--- | :--- |
| **Syncthing** | Continuous file synchronization across devices (e.g., syncing Obsidian vaults). |
| **Rclone / Google Drive** | Tools for mounting and syncing remote cloud storage directly to the file system. |

### Remote Access
| Software / Tool | Description / Role |
| :--- | :--- |
| **Sunshine & Moonlight** | Host and client applications for high-performance, low-latency remote desktop and game streaming. |
| **RustDesk** | Fantastic remote desktop software, but does not allow you to remote into a NixOS computer. Because I dual boot, I can reboot my PC into Windows and use RustDesk to remote into it if I need to. |

### Hardware & Peripherals
| Software / Tool | Description / Role |
| :--- | :--- |
| **OpenRGB** | Open-source software for controlling RGB lighting across different hardware components. |
| **Plover** | Open-source stenography engine for writing at the speed of thought. |
| **Droidcam** | Utility to use a smartphone as a wireless webcam for the PC. |

### Development & Virtualization
| Software / Tool | Description / Role |
| :--- | :--- |
| **Virtual Machines** | Configured QEMU/KVM modules for virtualization and safe sandboxing. |
| **PlatformIO** | Ecosystem for embedded development and IoT. |
| **Nix-Alien** | Utility to run unpatched binaries and AppImages on NixOS seamlessly. |

### Theming & Appearance
| Software / Tool | Description / Role |
| :--- | :--- |
| **Catppuccin & Gruvbox** | Cohesive, warm color palettes applied across the system and terminals. |
| **JetBrains Mono Nerd Font** | Primary typography used for clear code legibility and UI icon rendering. |



## NixOS Installation
This is where I guide you through installing NixOS onto your system. 
If you already have NixOS installed onto your system and you just want to try out my configuration, then feel free to jump over to [Configuration Installation](#configuration-installation).

//TODO actually tell people how to install nixos

## Configuration Installation
This is where I guide you through actually installing and using the files that I have in this repository to make your NixOS configuration look like mine.
This repository has two configurations, one for a laptop and one for a desktop. While they share many modules and configs, they are distinct in a few ways (for example, I have a remote gaming hosting software run on my desktop but not my laptop so that I can remotely game). 
These installation instructions are specifically for `gluon`, my desktop configuration. If you want to install `higgs-boson`, my laptop configuration, then you can simply change `gluon` to `higgs-boson` in all of the commands that we will run. \(Yes, I am a nerd and my devices are named after subatomic particles\)
Alternatively, if you want to set up both a laptop and a desktop configuration, you can just rerun each command \(other than cloning the repository\)

### Cloning this Repository
The first thing that you need to do is clone this repository so that you actually have the files to build from. 
Before you do any cloning though, figure out where you want your configuration to live. I keep mine in the default `/etc/nixos` folder, and that is where the `nrs` shortcut to rebuild assume your files are, so that's where this guide will install them for you. 
This also assumes that you have a fresh NixOS install with your `hardware-configuration.nix` in at `/etc/nixos`, if you don't have one generated yet, you will need to generate it by running `sudo nixos-generate-config --dir /etc/nixos`. 

There are a few steps involved in this:
#### 1. Backup your hardware configuration

    NixOS stores the information for how the system should interact with the hardware in a file called `hardware-configuration.nix`. If you have different hardware to the hardware I am running, which is highly likely, my `hardware-configuration.nix` will not work for you. So, we need to backup your `hardware-configuration.nix`, which we can do with 
```
cp /etc/nixos/hardware-configuration.nix ~/hardware-configuration.nix.bak
``` 
#### 2. Clear your configuration directory

Next up, we need to clear out the directory so that Git doesn't get unhappy when we clone this repo. To do this, we have to run a remove command from the commandline. As a side note, this is a fantastic time to remind you to only run commands that you trust. This next command, `sudo rm -rf`, has the ability to recursively force the removal of files from your computer. We are only using it to remove what is in your `/etc/nixos` folder \(which is what the `/etc/nixos/*` is in the command\), so you can safely run it. 
```
sudo rm -rf /etc/nixos/*
``` 

#### 3. Clone this Repository

Now, you can pull down all of the files from GitHub to your computer.
```
sudo git clone https://github.com/intentionalDisaster99/NixOS.git /etc/nixos
```

#### 4. Restore your hardware configuration

Now that you have everything downloaded, you can put your `hardware-configuration.nix` back in place. You can do this the same way that we backed it up before, with a `cp`\(copy\) command:
```
sudo cp ~/hardware-configuration.nix.bak /etc/nixos/hosts/gluon/hardware-configuration.nix
```

#### 5. Ensure the correct permissions

We used `sudo` to clone and copy files to make sure that they were successfully cloned and copied, so we need to make sure that your user owns the files. This allows you to edit them freely for when you want to update your configuration later on. We can do a simple `chown` for this:
```
sudo chown -R $USER:users /etc/nixos
```

### Preparing your new configuration for use
Now that you have the configuration cloned and set up for your hardware, we need to update the users and get set up to load it for the first time.

Because this configuration is tailored to my personal setup, it expects my username (sa9m) and my desktop's hostname (gluon). Before applying the system switch, you need to swap these out for your own so that your home directory sets up correctly and you aren't locked out of your own machine.

#### 1. Update the Username

To change the username, you need to change the configuration files, so you'll have to open the files in your favorite text editor\(If this is a fresh instlal, you can use `nano path-to-file-to-edit`\). You need to change the default username in two places:
 - In `hosts/gluon/configuration.nix`, you need to change `users.users = { sa9m = { ... } }` block. Change sa9m to your username.
 - In `flake.nix`, look for the gluon configuration block and find `home-manager.users.sa9m`. Change sa9m to your username here as well.

#### 2. Update your Hostname:

NixOS flakes, which is how this config is set up, uses the hostname to determine which profile to build. As I said, my hostnames are based on subatomic particles, so my laptop is `higgs-boson` and my desktop is `gluon`.
If you are a nerd like me and want to keep these hostnames, you can just skip this step.

If you do want to change the hostname, there are a few things that you need to change:
 - In `flake.nix`, find the line that says `nixosConfigurations.gluon` and update "gluon" to whatever you would like your hostname to be. 
 - In `hosts/gluon/configuration.nix` update `networking.hostName = "gluon";` to say whatever hostname you decided on.

#### 3. Perform the Initial Build:
Now that your hardware, user, and hostname are aligned, you can do the first actual rebuild to apply the system!
```
sudo nixos-rebuild switch --flake /etc/nixos#gluon
```
\(If you changed the hostname in step 2, replace `#gluon` with your new hostname\).


### Updating the `nrs` command
Included in this repository is a custom bash script located at `scripts/nrs.sh`. This script acts as a powerful shortcut that automatically formats your Nix files, commits any changes to Git, pushes them to the cloud for backup, and rebuilds the system with a clean output monitor.

However, if you try to run it immediately, it will fail. This is because the script runs git push, which will attempt to push your local changes back to my GitHub repository, where you do not have write permissions. To fix this, you have two options: use your own repository or remove the GitHub sync.


#### Point Git to your own repository
This is what I would recommend, because it means that you will have a backup of your system configuration so if you accidentally break something or get a new device, you can easily get everything set up again.

1. Create a new, empty git repository on your personal GitHub account.

2. Tell Git to use your new repository instead of my repository. You can do this with this group of commands:

```
cd /etc/nixos
sudo git remote set-url origin https://github.com/YourUsername/YourNewRepoName.git
sudo git push -u origin main
```

Now, every time you run the nrs script, it will safely back up your configuration to your own GitHub repository.

#### Remove the GitHub sync
If you only want to track changes locally on your machine and don't care about GitHub backups, you can simply remove the push command from the script.

1. Open `/etc/nixos/scripts/nrs.sh` in your text editor.

2. Scroll down and delete or comment out the git push line.

---

## Using Your New Configuration

## Keyboard Shortcuts
The fastest way to do stuff is by keeping your fingers on the keyboard, so I have a bunch of keyboard shortcuts set up. Don't worry if you don't want to worry about keyboard shortcuts, though, you can use your mouse too.

Note that the `SUPER` key I talk about is the windows key on most keyboards. 

### Core Window Management
* **`SUPER + Shift + Q`**: Close the active window
* **`SUPER + Shift + F`**: Toggle floating for the active window
* **`SUPER + Ctrl + F`**: Toggle fullscreen
* **`SUPER + Arrow Keys`** (or **`H, J, K, L`**): Move focus between open windows
* **`SUPER + 1-0`**: Switch to workspace 1-10
* **`SUPER + Shift + 1-0`**: Move the active window to workspace 1-10
* **`SUPER + Mouse Scroll`** (or **`< / >`**): Cycle through open workspaces
* **`SUPER + Left Click & Drag`**: Move a floating window
* **`SUPER + Right Click & Drag`**: Resize a floating window

### Launching Applications
* **`ALT + Space`**: Open the application launcher (Rofi)
* **`SUPER + T`**: Open Terminal (Kitty)
* **`SUPER + B`**: Open Web Browser (Brave)
* **`SUPER + E`**: Open File Manager (Dolphin)
* **`SUPER + I`**: Open Code Editor (VS Code)
* **`SUPER + N`**: Open Notes (Obsidian)
* **`SUPER + G`**: Open Steam

### Special Workspaces 
These shortcuts open applications in a hidden "special" workspace that drops down over your current screen, letting you quickly check them and hide them again.
* **`SUPER + S`**: Toggle Spotify 
* **`SUPER + D`**: Toggle Discord 
* **`SUPER + M`**: Toggle Google Messages 
* **`SUPER + K`**: Toggle Calculator
* **`SUPER + O`**: Toggle a hidden dropdown terminal

### Utilities & System Toggles
* **`SUPER + L`**: Lock the screen
* **`SUPER + Esc`**: Open the Power/Logout menu
* **`SUPER + Shift + S`**: Select an area to screenshot and copy to clipboard
* **`SUPER + Shift + E`**: Select an area to screenshot and open in the image editor (Swappy)
* **`SUPER + V`**: Open clipboard history to paste previous items
* **`SUPER + C`**: Open color picker
* **`SUPER + W`**: Cycle the wallpaper to being video or not
* **`SUPER + U`**: Toggle NordVPN (Wireguard)
* **`SUPER + P`**: Toggle power saving mode (though it doesn't currently do much)
* **`SUPER + Shift + N`**: Pause/Unpause desktop notifications
* **`SUPER + Shift + A`**: Toggle Airplane Mode
* **`SUPER + Shift + Y`**: Toggle Bluetooth
* **`SUPER + Shift + W`**: Toggle Wi-Fi

### Media Controls
* **`SUPER + Ctrl + P`**: Play/Pause media
* **`SUPER + ]`**: Next track
* **`SUPER + [`**: Previous track


### Updates and Changes to Your Configuration

#### Adding Systemwide Programs

other things you think should go here

#### Understanding The Config Structure
A large part of being able to update and modify the configuration to your liking is understanding everything that is in the config. 
At the most basic level, here is the structure of my configuration:


`flake.nix`: The master entry point of the entire system. This file defines where NixOS gets its packages (the inputs) and defines the specific machines you can build (the outputs, like gluon and higgs-boson). It links all the other folders together.

`home.nix`: The master entry point for Home Manager. While `flake.nix` builds the underlying computer and system services, `home.nix` builds your user environment. It dictates which personal packages you have installed and acts as the bridge connecting your user profile to all of your custom dotfiles.

`/hosts/`: This directory contains folders for specific, physical computers. Inside, you will find files like hardware-configuration.nix (which tells NixOS about your specific motherboards, drives, and kernel modules) and configuration.nix (which defines the user accounts and hostnames for that specific machine).

`/modules/`: This is the core of the setup. Instead of having one massive, unreadable configuration file, everything is broken down into modular chunks based on purpose. If you want to change VPN settings, you look in `modules/nordvpn/`. If you want to change what fonts are installed, look in `modules/theme/fonts.nix`. This keeps the system organized.

`/dotfiles/`: While the rest of the configuration handles system-level stuff (like firewalls and display managers), this folder handles user-level application settings managed through a tool called Home Manager. This is where you will find the specific configuration files for applications like Hyprland, Waybar, the Fish shell, and the Kitty terminal.

`/scripts/`: A small folder containing useful bash scripts to make managing the system easier, such as the `nrs.sh` auto-rebuild script.



 







