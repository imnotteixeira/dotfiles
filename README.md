# dotfiles

## VSCode Settings + Extensions (Using Settings Sync Extension)

https://gist.github.com/imnotteixeira/5e36083e638208af6a7050272d11f47c

### Configure VSCode Terminal Font (Powerline)

```bash
git clone https://github.com/abertsch/Menlo-for-Powerline.git

cd Menlo-for-Powerline/

# Move font to fonts folder
sudo mv "Menlo for Powerline.ttf" /usr/share/fonts/

# Refresh fonts cache
sudo fc-cache -vf /usr/share/fonts/
```

In VSCode settings, change terminal font to "Menlo for Powerline"
