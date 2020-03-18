# pypho-docker
Docker-Image for PYPHO (Python based optical fiber transmission simulation tool) for easier execution under Windows.
https://gitlab.lrz.de/hm-striegle/pypho

## Contains:
- Jupyter Notebook with Python 2.7 & Python 3.7 Kernels
- Installed Libraries:
  - pyho 3.0
  - numpy
  - scipy
  - matplotlib
  - pyfftw
  - Cython

# Installation
## Install Docker
On Windows:
https://docs.docker.com/docker-for-windows/install/
On Ubuntu/Debian:
> sudo apt-get install docker.io

## Allow mounting your Drive in Docker (Windows)
- Rightclick on Docker-Tray-Icon
- Settings
- Resources
- File Sharing
- Select local drive(s) and restart 

## Download pypho & Decompress
https://gitlab.lrz.de/hm-striegle/pypho

# Running the docker container
## Open a Terminal (Linux) / Powershell (Windows) and change the path to your folder: 
> cd path/to/phypho-folder

## Run the docker container
docker run -it -p 9000:8888 --mount src="$(pwd)",target=/pypho/local,type=bind holtmanm/pypho-docker

## Access the jupyter server via browser-address
http://localhost:9000/tree?
