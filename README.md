# dotfiles

## Packages used

 * WM: i3-gaps
 * Compositor: Picom (tyrone144 [fork](https://github.com/tryone144/picom) for the nice blur)
 * Polybar (TODO)
 * Terminal: zsh + oh-my-zsh + p10k theme :: xfce terminal with nord color scheme
 * yadm for managing dotfiles (this repo)
 * Locking (TODO: i3-lock?? on sleep)

### Additional Info
 * Screen backlight is controlled with `light`
 * Volume is controlled with `pactl`
 * Media is controlled with `playerctl` (works with browser media as well!)
 * Bluetooth is handled by `blueman`
 * Screenshots with `maim` 

### TODO
 * Automatic screen configuration when external monitor connected (maybe something like autorandr?)

## Additional Stuff for configuration

### VSCode Settings + Extensions (Using Settings Sync Extension)

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
