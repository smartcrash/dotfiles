#!/bin/bash

ln -s -F "$(realpath .tmux.conf)" ~/.tmux.conf
ln -s -F "$(realpath .zshrc)" ~/.zshrc

cp -r "$(realpath .config)" ~/.config
cp -r "$(realpath .oh-my-zsh)" ~/.oh-my-zsh

