#!/bin/bash

ln -sf "$(dirname "$(readlink -f "$0")")/.xinitrc" ~/.xinitrc

