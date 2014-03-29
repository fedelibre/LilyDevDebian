LilyDev
=======

LilyDev is a live CD containing a basic Debian operating system and all the
dependencies, settings and repositories required to start contributing to
`LilyPond <http://lilypond.org/>`_.


Notes for users
---------------

Due to a bug in the current debian installer, you should choose
english locale during the installation of the image in your
virtual machine.  You can reconfigure the locale after the installation::

    # dpkg-reconfigure locales

The image contains a 686-pae kernel, so you have to enable PAE in VirtualBox
preferences: `System>Processor>Extended features: Enable PAE/NX`.


Notes for maintainers
---------------------

This version of LilyDev has been created created with
`Debian live-build <http://live.debian.net/>`_ version 3.x.  All you
need to install is the following package::

    # apt-get install live-build

To generate a new image, run this command from the root
directory of this project::

    # lb clean    # to clean previous builds (deb packages are cached in cache/)
    # lb build    # a log file build.log will be automatically created

If all goes well, the current directory will contain the
file ``binary.hybrid.iso``.  You can test the image with QEMU::

    $ kvm -m 1000M -cdrom binary.hybrid.iso

The build will generate many directories and files.  In order to have a
clear view of the relevant config files, you can check which files
are tracked by git::

    $ git ls-tree -r master --name-only
    .gitignore
    README.rst
    auto/build
    auto/clean
    auto/config                                  # main settings
    config/apt/preferences                       # APT pinning
    config/archives/backports.list.chroot        # debian backports repositories
    config/hooks/lilyrepositories.hook.chroot    # hook to download git repositories
    config/includes.chroot/etc/skel/             # contains configuration files for user
    config/package-lists/my.list.chroot          # list of required packages


More information in the `Debian live-build documentation <http://live.debian.net/manual/current/html/live-manual.en.html>`_.

