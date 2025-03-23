#!/usr/bin/env zsh
find /tmp -type f -exec shred -u {} \;
