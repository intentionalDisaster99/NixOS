#!/usr/bin/env bash

echo "Pushing to github"

cd /etc/nixos

git add .

git commit -m "New configuration!"

git push 

echo "Push finished"

sudo nixos-rebuild switch --flake /etc/nixos#higgs-boson
