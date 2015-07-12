# LilyDev

LilyDev is an ISO image containing a basic Debian operating system and
all the dependencies, settings and repositories required to start
contributing to [LilyPond](http://lilypond.org/).

## Notes for users

The image contains a 686-pae kernel, so you have to enable PAE in
VirtualBox preferences: *System\>Processor\>Extended features: Enable PAE/NX*.

When you launch the ISO, choose the graphical install, then your
language and follow the install instructions.

## Notes for maintainers

### Installation

LilyDev is built with the latest stable version of [Debian
live-build](http://live.debian.net/), i.e. the version in the latest
stable release of Debian. You should install the following packages:

    sudo apt-get install live-build librsvg2-bin

In case you have a more recent and unstable version of live-build in
your repository, you can either download the stable .deb package from
the live-build website or compile the correct git tag from source:

    git clone git://live-systems.org/git/live-build.git
    cd live-build
    git tag -l | grep ^debian/4
    git checkout debian/4.0.5-1
    dpkg-buildpackage -b -uc -us
    cd ..
    sudo dpkg -i live-build_4.0.5-1_all.deb

If you installed it manually, don't forget to hold the package to prevent
the automatic update:

    sudo apt-mark hold live-build

### Usage

To generate a new image, run this command from the root directory of
this project:

    sudo lb clean    # to clean previous builds (deb packages are cached in cache/)
    sudo lb build    # a log file build.log will be automatically created

If all goes well, the current directory will contain the .iso file, which
you can quickly test by running the following command:

    kvm -m 1000M -cdrom <name>.iso

The build will generate many directories and files. In order to have a
clear view of the relevant config files, you can check which files are
tracked by git:

    $ git ls-tree -r master --name-only
    .gitignore
    README.rst
    auto/build
    auto/clean
    auto/config                                  # main settings
    config/apt/preferences                       # APT pinning
    config/archives/backports.list.chroot        # debian backports repositories
    config/includes.chroot/etc/skel/             # contains configuration files for user
    config/package-lists/my.list.chroot          # list of required packages

More information in the [Debian live-build
documentation](http://live.debian.net/manual/current/html/live-manual.en.html).
