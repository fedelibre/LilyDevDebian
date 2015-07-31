#!/bin/bash
echo "This wizard will help you to setup your Git configuration."
echo -n "Please enter your name and surname: "
read NAME
git config --global user.name "$NAME"
echo -n "Please enter your email address: "
read EMAIL
git config --global user.email "$EMAIL"
echo "Your commit messages will be signed as '$NAME <$EMAIL>'."
git config --global color.ui auto
echo

echo "Now we'll download the repositories needed to contribute to LilyPond development. Proceed only if you have a working Internet connection."
read -p "Press Enter to continue. "
cd $HOME
echo "Cloning in your home directory: `pwd`. It will take a few minutes."
echo "Downloading git-cl repository..."
git clone git://github.com/gperciva/git-cl.git
echo "Downloading lilypond-extra repository..."
git clone git://github.com/gperciva/lilypond-extra/
echo "Downloading lilypond-git repository..."
git clone git://git.sv.gnu.org/lilypond.git lilypond-git

# This script should be run automatically on the first login only
rm ~/.config/autostart/lilydev.desktop

# Append LilyPond variables to ~/.bashrc
cat /etc/skel/.lilypond-bashrc >> ~/.bashrc

echo "Configuration completed successfully!"
read -p "Press enter to close the wizard."
