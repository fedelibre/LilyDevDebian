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

LilyDev is built with the latest stable version of
[Debian live-build](http://debian-live.alioth.debian.org/live-build/),
i.e. the version in the latest stable release of Debian. You should
install the following packages:

    sudo apt-get install live-build librsvg2-bin

In case you have a more recent and unstable version of live-build in
your repository, you can either download the stable .deb package from
the live-build website or compile the correct git tag from source:

    git clone git://anonscm.debian.org/git/debian-live/live-build.git
    cd live-build
    git branch -a
    git checkout debian-old-4.0
    dpkg-buildpackage -b -uc -us
    cd ..
    sudo dpkg -i live-build_4.0.5-1_all.deb

If you installed it manually, don't forget to hold the package to prevent
the automatic update:

    sudo apt-mark hold live-build

In case the [stable live-manual](http://debian-live.alioth.debian.org/live-manual/stable/manual/html/live-manual.en.html)
is not up-to-date to the real stable version (specified in the About section), you
must compile the documentation from source.  Let's install the dependencies:

    sudo apt-get install make po4a ruby ruby-nokogiri sisu-complete texlive-generic-recommended

Download the git repository, checkout the latest stable branch (currently 4)
and make the build:

    git clone git://anonscm.debian.org/git/debian-live/live-manual.git
    git branch -a
    git checkout debian-old-4.0
    make build PROOF=1
    x-www-browser build/manual/html/live-manual.en.html


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

    git ls-tree -r master --name-only

More information in the [Debian live-build
documentation](http://debian-live.alioth.debian.org/live-manual/stable/manual/html/live-manual.en.html).
