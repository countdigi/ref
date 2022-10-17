# Debian

Communicating Sequential Processes

## Alternatives

List all alternatives:
```
update-alternatives --get-selections
```

## Apt

/etc/apt contains the APT configuration folders and files.

apt-config is the APT Configuration Query program.[12] apt-config dump shows the configuration.[13]
Files

- `/etc/apt/sources.list` - Locations to fetch packages from
- `/etc/apt/sources.list.d/` - Additional source list fragments
- `/etc/apt/apt.conf` - APT configuration file.
- `/etc/apt/apt.conf.d/` - APT configuration file fragments.
- `/etc/apt/preferences.d/` - directory with version preferences files. This is where you would specify "pinning", i.e. a preference to get certain packages from a separate source or from a different version of a distribution.
- `/var/cache/apt/archives/` - storage area for retrieved package files.
- `/var/cache/apt/archives/partial/` - storage area for package files in transit.
- `/var/lib/apt/lists/` - storage area for state information for each package resource specified in sources.list
- `/var/lib/apt/lists/partial/` - storage area for state information in transit.

## Buster

### Packages

```
build-essential
gdb
strace
curl
liblzma-dev
zlib1g-dev
libbz2-dev
ca-certificates
gfortran
```

Other
```
libcairo2-dev # Vector graphics-based, device-independent API for software developers
curl
ed
freeglut3-dev
gfortran
libbz2-dev
libcairo2-dev
libcurl4-openssl-dev
libglu1-mesa-dev
libjpeg-dev
liblzma-dev
libmariadb-client-lgpl-dev
libpcre3-dev
libpng-dev
libreadline-dev
libssl-dev
libtiff5-dev
libxml2-dev
m4
mesa-common-dev
openjdk-8-jdk-headless
tcl-dev
tk-dev
zlib1g-dev
ncurses-dev
git-all
wget
libboost-all-dev
```


