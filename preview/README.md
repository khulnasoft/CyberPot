# CyberPot - Technical Preview

CyberPot will be turning 10 years next year and this milestone will be celebrated when the time comes, which brings us today to the best time to reflect on how technology advanced, what this means for the project and how we can ensure CyberPot will meet the current and future requirements of the community.
<br><br>

# TL;DR
1. [Download](#choose-your-distro) or use a running, supported distribution
2. Install the ISO with as minimal packages / services as possible (SSH required!)
3. Clone CyberPot: `$ git clone https://github.com/khulnasoft/cyberpot`
4. Locate installer for your distribution: `$ cd cyberpot/preview/installer/<distro>`
5. Run installer as non-root: `$ ./install.sh`
   * Follow instructions, read messages, check for possible port conflicts and reboot
7. [Set](#cyberpot-config-file) username and password in config `.env`: `vi preview/.env`
8. [Start](#start-cyberpot) CyberPot for the first time:
```
$ cd cyberpot/preview/
$ docker compose up
```


# Table of Contents
- [Disclaimer](#disclaimer)
- [Last Time Departed](#last-time-departed)
- [Present Time](#present-time)
- [Destination Time](#destination-time)
- [Technical Preview](#technical-preview)
  - [Architecture](#architecture)
- [Installation](#installation)
  - [Choose your distro](#choose-your-distro)
  - [Get and Install CyberPot](#get-and-install-cyberpot)
  - [CyberPot Config File](#cyberpot-config-file)
  - [macOS & Windows](#macos--windows)
- [Start CyberPot](#start-cyberpot)
- [Stop CyberPot](#stop-cyberpot)
- [Uninstall CyberPot](#uninstall-cyberpot)
- [Feedback](#uninstall-cyberpot)

<br><br>

# Disclaimer
- This is a Technical Preview, a very very early stage in the development CyberPot. You have been warned - there will be dragons steering flying time machines possibly causing paradoxes.
- The CyberPot [disclaimer](https://github.com/khulnasoft/cyberpot/blob/master/README.md#disclaimer) and [documentation](https://github.com/khulnasoft/cyberpot/blob/master/README.md) apply.
<br><br>

# Last Time Departed
Jumping back to 2014 CyberPot was born as the direct ancestor of our Raspberry Pi images we used to offer for download (which probably by now only insiders will remember 😅). Docker was just the new kid on the block with the shiny new container engine everyone desperately unknowingly waited for and thus taking the dev-world by storm. At that point we wanted to ensure that CyberPot was something tangible, tethered to a physical device (Hello NUC my old friend 👋) while using latest technologies ensuring an easy transition should we ever leave hardware based installations (or VMs for that matter). And Oh-My-Zsh as you all know that day came faster than anticipated! (Special thanks @vorband, @shaderecker and @tmariuss for all of their contributions!)  
<br><br>

# Present Time
Flash Forward to today, CyberPot offers support for Debian, both as an ISO based installation or a post installation method (install your own Debian Server), support for OTC, AWS and other clouds through Ansible and Terraform Support. All of this in many different flavors and even a distributed installation. At the same time we are still relying on the same base concept we originally started with which does not seem fit for the foreseeable future.<br>
In the last couple of years being independent of a certain platform was the one feature that stood out by far. The reason for this, until today, is the simple fact that CyberPot, although relying heavily on Docker, still relies on a fully controlled environment. This has its advantages but can not meet a demand where cloud based installations need different settings than we can provide (we can only run limited platform tests), companies follow different guidelines for allowed distributions or hosters simply offer Debian images slightly adjusted to their environments causing issues with the setting CyberPot relies on. Roll the dice or ask the Magic-8-Ball.     
<br><br>

# Destination Time
Back to the future of CyberPot. For a brief time we had the idea of CyberPot Light which should compensate for the missing platform support. A concept was whipped up to support all of CyberPot's dockered services on minimal installations of Debian, Fedora, OpenSuse and Ubuntu Server. And it worked! It worked so good that we have almost achieved feature parity for this Technical Preview and decided that this is the best candidate for the future of the development of CyberPot<br>
We are thrilled to share this now, so you can test, provide us with feedback, open issues and discussions and give us the chance to make the next CyberPot the best CyberPot we have ever released!
<br><br>

## Technical Preview
For the purpose of the Technical Preview CyberPot will still use the 22.04 images and for a great part rely on the 22.04 release. This will lay the groundwork though for the next CyberPot release by just relying on the latest Docker package repositories (yes, the distros mostly do not offer Docker's bleeding edge features), some tiny modifications on the host (installer and uninstaller provided!) and move all of CyberPot's core in its own Docker image with a simple, user adjustable, configuration.<br>
<br><br>

## Architecture
While the basic architecture still remains, the Technical Preview of CyberPot is mostly independent of the underlying OS with only some basic requirements:
1. Underlying OS is available as supported distribution:
    * Only the bare minimum of services and packages are installed to avoid possible port conflicts with CyberPot's services
    * Debian, Fedora, OpenSuse and Ubuntu Server are currently supported, others might follow if the requirements will be met
2. Latest Docker Engine from Docker's repositories is supported
    * Only the latest Docker Engine packages offer all the features needed for CyberPot
    * Docker Desktop does not offer host network capabilities and thus only a limited CyberPot experience (not available for the Technical Preview, but planned to even get started faster!)
3. Changes to the host
    * Some changes to the host are necessary but will be kept as minimalistic as possible, just enough CyberPot will be able to run
    * There are uninstallers available this time 😁
<br><br>

# System Requirements
The known CyberPot hardware (CPU, RAM, SSD) requirements and recommendations still apply.
<br><br>

# Installation
[Download](#choose-your-distro) one of the supported Linux distro images, `git clone` the CyberPot repository and run the installer specific to your system. Running CyberPot on top of a running and supported Linux system is possible, but a clean installation is recommended to avoid port conflicts with running services.
<br><br>

## Choose your distro
Choose a supported distro of your choice. It is recommended to use the minimum / netiso installers linked below and only install a minimalistic set of packages. SSH is mandatory or you will not be able to connect to the machine remotely.

| Distribution Name                              | x64                                                                                                        | arm64 
|:-----------------------------------------------|:-----------------------------------------------------------------------------------------------------------|:--------------
| [Debian](https://www.debian.org/index.en.html) | [download](http://ftp.debian.org/debian/dists/stable/main/installer-amd64/current/images/netboot/mini.iso) | [download](http://ftp.debian.org/debian/dists/stable/main/installer-arm64/current/images/netboot/mini.iso)      
| [Fedora](https://fedoraproject.org)            | [download](https://download.fedoraproject.org/pub/fedora/linux/releases/38/Server/x86_64/iso/Fedora-Server-netinst-x86_64-38-1.6.iso)                                                                                                       | [download](https://download.fedoraproject.org/pub/fedora/linux/releases/38/Server/aarch64/iso/Fedora-Server-netinst-aarch64-38-1.6.iso)      
| [OpenSuse](https://www.opensuse.org)           | [download](https://download.opensuse.org/tumbleweed/iso/openSUSE-Tumbleweed-NET-x86_64-Current.iso)                                                                                                       | [download](https://download.opensuse.org/ports/aarch64/tumbleweed/iso/openSUSE-Tumbleweed-NET-aarch64-Current.iso)
| [Ubuntu](https://ubuntu.com)                   | [download](https://releases.ubuntu.com/22.04.2/ubuntu-22.04.2-live-server-amd64.iso)                                                                                                       | [download](https://cdimage.ubuntu.com/releases/22.04/release/ubuntu-22.04.2-live-server-arm64.iso)


<br><br> 

## Get and install CyberPot
1. Clone the GitHub repository: `$ git clone https://github.com/khulnasoft/cyberpot`
2. Change into the **cyberpot/preview/installer** folder: `$ cd cyberpot/preview/installer`
3. Locate your distribution, i.e. `fedora`: `$ cd fedora`
4. Run the installer as non-root: `$ ./install.sh`:
   * ⚠️ ***Depending on your Linux distribution of choice the installer will:***
     * Change the SSH port to `tcp/64295`
     * Disable the DNS Stub Listener to avoid port conflicts with honeypots
     * Set SELinux to Monitor Mode
     * Set the firewall target for the public zone to ACCEPT
     * Add Docker's repository and install Docker
     * Install recommended packages
     * Remove package known to cause issues
     * Add the current user to the docker group (allow docker interaction without `sudo`)
     * Add `dps` and `dpsw` aliases (`grc docker ps -a`, `watch -c "grc --colour=on docker ps -a`)
     * Display open ports on the host (compare with CyberPot [required](https://github.com/khulnasoft/cyberpot#required-ports) ports)
5. Follow the installer instructions, you will have to enter your password at least once
6. Check the installer messages for errors and open ports that might cause port conflicts
7. Reboot: `$ sudo reboot`
<br><br>

## CyberPot Config File
CyberPot offers a configuration file providing environment variables not only for the docker services (i.e. honeypots and tools) but also for the docker compose environment. The configuration file is hidden in the `preview` folder and is called `.env`. There is however an example file (`env.example`) which holds the default configuration.<br> Before the first start set the `WEB_USER` and `WEB_PW`. Once CyberPot was initialized it is recommended to remove the password and set `WEB_PW=<changeme>`. Other settings are available also, these however should only be changed if you are comfortable with possible errors 🫠 as some of the features are not fully integrated and tested yet.
```
# CyberPot config file. Do not remove.

# Set Web username and password here, only required for first run
#  Removing the password after first run is recommended
#  You can always add or remove users as you see fit using htpasswd:
#  htpasswd -b -c /<data_folder>/nginx/conf/nginxpasswd <username> <password>
WEB_USER=<changeme>
WEB_PW=<changeme>

# CyberPot Blackhole
#  ENABLED: CyberPot will download a db of known mass scanners and nullroute them
#           Be aware, this will put CyberPot off the map for stealth reasons and
#           you will get less traffic. Routes will active until reboot and will
#           be re-added with every CyberPot start until disabled.
#  DISABLED: This is the default and no stealth efforts are in place.
CYBERPOT_BLACKHOLE=DISABLED
```

## macOS & Windows
Sometimes it is just nice if you can spin up a CyberPot instance on macOS or Windows, i.e. for development, testing or just the fun of it. While Docker Desktop is rather limited not all honeypot types or CyberPot features are supported. Also remember, by default the macOS and Windows firewall are blocking access from remote, so testing is limited to the host. For production it is recommended to run CyberPot on Linux.<br>
To get things up and running just follow these steps:
1. Install Docker Desktop for [macOS](https://docs.docker.com/desktop/install/mac-install/) or [Windows](https://docs.docker.com/desktop/install/windows-install/)
2. Clone the GitHub repository: `$ git clone https://github.com/khulnasoft/cyberpot`
2. Change into the **cyberpot/preview/compose** folder: `$ cd cyberpot/preview/compose`
3. Copy **mac_win.yml** to the **cyberpot/preview** folder by overwriting **docker-compose.yml**: `$ cp mac_win.yml ../docker-compose.yml`
4. Adjust the **.env** file by changing **CYBERPOT_OSTYPE** to either **mac** or **win**:
```
# OSType (linux, mac, win)
#  Most docker features are available on linux
CYBERPOT_OSTYPE=mac
```
5. You have to ensure on your own there are no port conflicts keeping CyberPot from starting up.
You can follow the README on how to [Start CyberPot](#start-cyberpot), however you may skip the **crontab**.


# Start CyberPot
1. Change into the **cyberpot/preview/** folder: `$ cd cyberpot/preview/`
2. Run: `$ docker compose up` (notice the missing dash, `docker-compose` no longer exists with the latest Docker installation)
   * You can also run `$ docker compose -f /<path_to_cyberpot>/cyberpot/preview/docker-compose.yml up` directly if you want to avoid to change into the `preview` folder or add an alias of your choice.
3. `docker compose` will now download all the necessary images to run the CyberPot Docker containers
4. On the first run CyberPot (`cyberpotinit`) will initialize and create the `data` folder in the path specified (by default it is located in `cyberpot/preview/data/`):
   * It takes about 2-3 minutes to bring all the containers up (should port conflicts arise `docker compose` will simply abort)
   * Once all containers have started successfully for the first time you can access CyberPot as described [here](https://github.com/khulnasoft/cyberpot#remote-access-and-tools) or cancel with `CTRL-C` ...
5. ... and run CyberPot in the background: `$ docker compose up -d`
   * Unless you run `docker compose down -v` CyberPot's Docker service will remain persistent and restart with a reboot
   * You can however add a crontab entry with `crontab -e` which will also add some container and image management.
```
@reboot docker compose -f /<path_to_cyberpot_>/cyberpot/preview/docker-compose.yml down -v; \
docker container prune -f; \
docker image prune -f; \
docker compose -f /<path_to_cyberpot_>/cyberpot/preview/docker-compose.yml up -d
```
6. By default Docker will always check if the local and remote docker images match, if not, Docker will either revert to a fitting locally cached image or download the image from remote. This ensures CyberPot images will always be up-to-date

# Stop CyberPot
1. Change into the **cyberpot/preview/** folder: `$ cd cyberpot/preview/`
2. Run: `$ docker compose down -v` (notice the missing dash, `docker-compose` no longer exists with the latest docker installation)
3. Docker will now stop all running CyberPot containers and disable reboot persistence (unless you made a [crontab entry](#start-cyberpot)
   * You can also run `$ docker compose -f /<path_to_cyberpot>/cyberpot/preview/docker-compose.yml down -v` directly if you want to avoid to change into the `preview` folder or add an alias of your choice.
 
# Uninstall CyberPot
1. Change into the **cyberpot/preview/uninstaller/** folder: `$ cd cyberpot/preview/uninstaller/`
2. Locate your distribution, i.e. `fedora`: `$ cd fedora`
3. Run the installer as non-root: `$ ./uninstall.sh`:
   * The uninstaller will reverse the installation steps
4. Follow the uninstaller instructions, you will have to enter your password at least once
5. Check the uninstaller messages for errors
6. Reboot: `$ sudo reboot`
<br><br>

# Feedback
To ensure the next CyberPot release will be everything we and you - The CyberPot Community - have in mind please feel free to leave comments in the `Technical Preview` [discussion](https://github.com/khulnasoft/cyberpot/discussions/1325) pinned on our GitHub [Discussions](https://github.com/khulnasoft/cyberpot/discussions) section. Please bear in mind that this Technical Preview is made public in the earliest stage of the CyberPot development process at your convenience for ***your*** valuable input.
<br><br>
Thank you for testing 💖

Special thanks to all the [contributors](https://github.com/khulnasoft/cyberpot/graphs/contributors) and [developers](https://github.com/khulnasoft/cyberpot#credits) making this project possible!
