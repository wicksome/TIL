# How to add spaces to your Mac's Dock using Terminal

```sh
defaults write com.apple.dock persistent-apps -array-add '{"tile-type"="spacer-tile";}'; killall Dock
```
