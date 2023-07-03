# podman-yuzu-build
This project builds the yuzu source https://github.com/yuzu-emu/yuzu-mainline in a **Fedora 38** podman container  
\
**ensure these packages are installed**
```
dnf install podman python3-podman python3-termcolor   
```

**build yuzu**
```
git clone https://github.com/leifliddy/podman-yuzu-build.git
cd podman-yuzu-build  

# this will build the image and run the container   
./script-podman.py

# login to the container 
podman exec -it yuzu_builder /bin/bash

# once inside the container, run this script to build yuzu
/root/scripts/01-build.yuzu.sh

# use the -r option to perform a clean build (will remove exisiting source dir and build Yuzu from scratch)
/root/scripts/01-build.yuzu.sh -r

# the resulting yuzu binary will be copied to the /output directory which is shared with the host system

# exit container
Control+D or exit
```

**script-podman.py options**  
these should be pretty self-explanatory
```
usage: script-podman.py [-h] [--auto] [--debug]
                        [--rebuild | --rerun | --restart | --rm_image | --rm_container | --stop_container]

options:
  -h, --help        show this help message and exit
  --auto            ensure image is built, then run container_script in a non-interactive container
  --debug           display debug messages
  --rebuild         remove podman image and container if they exist, then build (new) podman image and run container
  --rerun           remove container if it exists, then (re-)run it
  --restart         stop the container if it exists, then (re-)run it
  --rm_image        remove podman image and container if they exist
  --rm_container    remove container if it exists
  --stop_container  stop podman container it exists and is running
```
