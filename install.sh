#!/bin/bash
log_file=~/install_progress_log.txt

# fix time
timedatectl set-local-rtc 1
echo "Time fixed" >> $log_file

# zsh
sudo apt install zsh
if type -p zsh > /dev/null; then
    echo "zsh Installed" >> $log_file
else
    echo "zsh FAILED TO INSTALL!!!" >> $log_file
fi

# Oh-my-zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
echo "Oh-my-zsh Installed" >> $log_file

# p10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
if type -p p10k > /dev/null; then
  echo "p10k Installed" >> $log_file
else
  echo "p10k FAILED TO INSTALL" >> $log_file
fi

#nvim 
wget https://github.com/neovim/neovim/releases/download/v0.7.2/nvim-linux64.deb
sudo apt install ./nvim-linux64.deb
if type -p nvim > /dev/null; then
    echo "nvim Installed" >> $log_file
else
    echo "nvim FAILED TO INSTALL!!!" >> $log_file
fi

# NVchad
git clone https://github.com/NvChad/NvChad ~/.config/nvim --depth 1
echo "NvChad installed" >> $log_file

# Brave
sudo apt install apt-transport-https curl

sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg

echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list

sudo apt update

sudo apt install brave-browser
echo "brave installed" >> $log_file

# Ibus Bamboo
sudo add-apt-repository ppa:bamboo-engine/ibus-bamboo
sudo apt-get update
sudo apt-get install ibus ibus-bamboo --install-recommends
echo "ibus installed" >> $log_file

# kitty terminal
curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin
mkdir ~/.local/bin
ln -s ~/.local/kitty.app/bin/kitty ~/.local/bin/
cp ~/.local/kitty.app/share/applications/kitty.desktop ~/.local/share/applications/
cp ~/.local/kitty.app/share/applications/kitty-open.desktop ~/.local/share/applications/
sed -i "s|Icon=kitty|Icon=/home/$USER/.local/kitty.app/share/icons/hicolor/256x256/apps/kitty.png|g" ~/.local/share/applications/kitty*.desktop
sed -i "s|Exec=kitty|Exec=/home/$USER/.local/kitty.app/bin/kitty|g" ~/.local/share/applications/kitty*.desktop

if type -p kitty > /dev/null; then
  echo "Kitty_ter Installed" >> $log_file
else
  echo "Kitty_ter FAILED TO INSTALL" >> $log_file
fi

# update GIT
sudo add-apt-repository ppa:git-core/ppa
sudo apt update
sudo apt upgrade
echo "Git Updated" >> $log_file

# nodejs
curl -fsSL https://deb.nodesource.com/setup_current.x | sudo -E bash -
sudo apt-get install -y nodejs
echo "Nodejs Install" >> $log_file

# pip3
sudo apt-get -y install python3-pip
if type -p pip3 > /dev/null; then
  echo "pip3 Installed" >> $log_file
else
  echo "pip3 FAILED TO INSTALL" >> $log_file
fi

# nvim extend
pip3 install pynvim
sudo npm i -g neovim
sudo apt install xsel

# exa (ls extend)
sudo apt install exa
if type -p exa > /dev/null; then
  echo "exa Installed" >> $log_file
else
  echo "exa FAILED TO INSTALL" >> $log_file
fi

# ranger
pip3 install ranger-fm
if type -p ranger > /dev/null; then
  echo "ranger Installed" >> $log_file
else
  echo "ranger FAILED TO INSTALL" >> $log_file
fi

# python pillow lib (for image viewer)
python3 -m pip install --upgrade pip
python3 -m pip install --upgrade Pillow
echo "pillow lib installed" >> $log_file

# python3.10-venv 
sudo apt install python3.10-venv

#==============
# Give the user a summary of what has been installed
#==============
echo -e "\n====== Summary ======\n"
cat $log_file
echo
echo "Enjoy -Jarrod"
rm $log_file
rm *.deb
