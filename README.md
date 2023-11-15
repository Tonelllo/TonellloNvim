# What's this
This is my configuration to code during my staying in the Robotics Engineering master at the University of Genova.
# How to install
To use this config you need neovim >= 0.9. To install it head over to neovim github and 
get the latest appimage.

After the installation is done you can copy this config inside
```~/.config/nvim/```
and install the required language servers with mason from neovim commandline:
```
:MasonInstall python-lsp-server lua-language-server matlab-language-server clangd bash-language-server rust-analyzer cmake-language-server
```
