#!/usr/bin/env bash

rsync -av --progress ~/.config/nvim . --exclude UltiSnips/private-*

cp ~/.tmux.conf .
