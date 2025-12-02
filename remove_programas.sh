#!/bin/bash

apt remove --purge LibreOffice* -y && \
apt remove --purge thunderbird -y && \
apt remove --purge remmina -y && \

 #pacotes de idiomas
 apt remove --purge  language-pack-de language-pack-de-base language-pack-en language-pack-en-base language-pack-es \
  language-pack-es-base language-pack-fr language-pack-fr-base language-pack-gnome-de\
  language-pack-gnome-de-base language-pack-gnome-en language-pack-gnome-en-base \
  language-pack-gnome-es language-pack-gnome-es-base language-pack-gnome-fr \
  language-pack-gnome-fr-base language-pack-gnome-it language-pack-gnome-it-base \
  language-pack-gnome-ru language-pack-it language-pack-it-base  language-pack-ru \
  language-pack-gnome-ru-base language-pack-gnome-zh-hans language-pack-gnome-zh-hans-base \
  language-pack-ru-base language-pack-zh-hans language-pack-zh-hans-base -y && \

