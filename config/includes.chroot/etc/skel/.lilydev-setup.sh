#!/bin/bash
printf "This wizard will help you to setup your Git configuration.\n\n"

if [ -f ~/.gitconfig ]; then
  printf "A file configuration already exists. If you proceed, it will be overwritten.\nPress Ctrl+C to cancel/Press enter to proceed: "
  read _
fi

echo -n "Please enter your name and surname: "
read NAME
git config --global user.name "$NAME"
echo -n "Please enter your email address: "
read EMAIL
git config --global user.email "$EMAIL"
echo "Your commit messages will be signed as '$NAME <$EMAIL>'."
echo "Default editor to write commit messages is currently nano. You can now confirm it or choose another text editor [emacs|geany|nano]: "
read GITEDITOR
git config --global core.editor $GITEDITOR
git config --global color.ui auto
echo

# In case this script is run again after first configuration, skip
# this part if these directories exist.
if [ -d ~/git-cl -a ~/lilypond-git -a ~/lilypond-extra ]; then
  printf "You've already downloaded the repositories. Press Ctrl+C close the wizard: "
read _
fi

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

# LilyPond docs need Greek and Cyrillic fonts from Ghostscript URW35.
# Eventually, they may be inlcuded in a Linux distro package.
# As of October 2016, there are 12 font files needed from a larger git
# repository. We want just the 12 files, so download each with wget.

# Font file names:
URW35FONTS=\
"C059-BdIta.otf
C059-Bold.otf
C059-Italic.otf
C059-Roman.otf
NimbusMonoPS-Bold.otf
NimbusMonoPS-BoldItalic.otf
NimbusMonoPS-Italic.otf
NimbusMonoPS-Regular.otf
NimbusSans-Bold.otf
NimbusSans-BoldOblique.otf
NimbusSans-Oblique.otf
NimbusSans-Regular.otf"

# Download each font file
for font in $URW35FONTS
do
  # The URL GET parameter f=$font will be replaced with the font file name
  WGETURL="http://git.ghostscript.com/?p=urw-core35-fonts.git;a=blob;hb=79bcdfb34fbce12b592cce389fa7a19da6b5b018;f=$font;"
  # wget options: less verbose, create directory, don't make host directory,
  # use file name from HTTP header, set download location
  wget -nv -x -nH --content-disposition -P ~/.local/share/fonts "$WGETURL"
done

# This script should be run automatically on the first login only
if [ -f ~/.config/autostart/lilydev.desktop ]; then
  rm ~/.config/autostart/lilydev.desktop
fi

echo "Configuration completed successfully!"
read -p "Press enter to close the wizard."
