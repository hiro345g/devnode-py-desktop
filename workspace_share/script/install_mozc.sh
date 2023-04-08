#!/bin/sh
sudo apt-get update && sudo apt-get install -y ibus-mozc mozc-utils-gui
sudo sed -i /usr/share/ibus/component/mozc.xml \
     -e 's;<layout>default</layout>;<layout>jp</layout>;g'
sudo dconf write /org/gnome/desktop/input-sources/sources "[('ibus', 'mozc-jp')]"
