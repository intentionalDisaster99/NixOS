# My Personal NixOS Configuration and a Simple NixOS Beginner Guide
Welcome to my definitely totally fantastic and not at all randomly pieced together NixOS Configuration! :D
I am planning to use this repository for two purposes: to host my nixos configuration and to act as a simple beginner friendly tutorial for transitioning to NixOS.


## Table of Contents





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
1. Backup your hardware configuration

    NixOS stores the information for how the system should interact with the hardware in a file called `hardware-configuration.nix`. If you have different hardware to the hardware I am running, which is highly likely, my `hardware-configuration.nix` will not work for you. So, we need to backup your `hardware-configuration.nix`, which we can do with 
```
cp /etc/nixos/hardware-configuration.nix ~/hardware-configuration.nix.bak
``` 
2. Clear your configuration directory

Next up, we need to clear out the directory so that Git doesn't get unhappy when we clone this repo. To do this, we have to run a remove command from the commandline. As a side note, this is a fantastic time to remind you to only run commands that you trust. This next command, `sudo rm -rf`, has the ability to recursively force the removal of files from your computer. We are only using it to remove what is in your `/etc/nixos` folder \(which is what the `/etc/nixos/*` is in the command\), so you can safely run it. 
```
sudo rm -rf /etc/nixos/*
``` 

3. Clone this Repository

Now, you can pull down all of the files from GitHub to your computer.
```
sudo git clone https://github.com/intentionalDisaster99/NixOS.git /etc/nixos
```

4. Restore your hardware configuration

Now that you have everything downloaded, you can put your `hardware-configuration.nix` back in place. You can do this the same way that we backed it up before, with a `cp`\(copy\) command:
```
sudo cp ~/hardware-configuration.nix.bak /etc/nixos/hosts/gluon/hardware-configuration.nix
```

5. Ensure the correct permissions

We used `sudo` to clone and copy files to make sure that they were successfully cloned and copied, so we need to make sure that your user owns the files. This allows you to edit them freely for when you want to update your configuration later on. We can do a simple `chown` for this:
```
sudo chown -R $USER:users /etc/nixos
```

### Preparing your new configuration for use
Now that you have the configuration cloned and set up for your hardware, we need to update the users and get set up to load it for the first time.

Because this configuration is tailored to my personal setup, it expects my username (sa9m) and my desktop's hostname (gluon). Before applying the system switch, you need to swap these out for your own so that your home directory sets up correctly and you aren't locked out of your own machine.

1. Update the Username

To change the username, you need to change the configuration files, so you'll have to open the files in your favorite text editor\(If this is a fresh instlal, you can use `nano path-to-file-to-edit`\). You need to change the default username in two places:
 - In `hosts/gluon/configuration.nix`, you need to change `users.users = { sa9m = { ... } }` block. Change sa9m to your username.
 - In `flake.nix`, look for the gluon configuration block and find `home-manager.users.sa9m`. Change sa9m to your username here as well.

2. Update your Hostname:

NixOS flakes, which is how this config is set up, uses the hostname to determine which profile to build. As I said, my hostnames are based on subatomic particles, so my laptop is `higgs-boson` and my desktop is `gluon`.
If you are a nerd like me and want to keep these hostnames, you can just skip this step.

If you do want to change the hostname, there are a few things that you need to change:
 - In `flake.nix`, find the line that says `nixosConfigurations.gluon` and update "gluon" to whatever you would like your hostname to be. 
 - In `hosts/gluon/configuration.nix` update `networking.hostName = "gluon";` to say whatever hostname you decided on.

3. Perform the Initial Build:
Now that your hardware, user, and hostname are aligned, you can do the first actual rebuild to apply the system!
```
sudo nixos-rebuild switch --flake /etc/nixos#gluon
```
\(If you changed the hostname in step 2, replace `#gluon` with your new hostname\).


### Updating the `nrs` command