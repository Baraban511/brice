sudo ln -s ~/brice/config/nixos /etc/ # Find way to keep Hardware but link config
sudo rm -r ~/.config/hypr
sudo ln -s ~/brice/config/hypr ~/.config/
echo 'eval "$(starship init bash)"' >> ~/.bashrc # Add starship to bash
