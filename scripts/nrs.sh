#!/usr/bin/env bash

# Exit immediately if any command fails.
set -e

NIXOS_CONFIG_DIR="/etc/nixos"
# Automatically detect the system's hostname for the flake.
HOSTNAME=$(hostname)

echo "Starting NixOS configuration update for host: $HOSTNAME"

cd "$NIXOS_CONFIG_DIR"

# Pulling any files that had been pushed before 
echo "Pulling files.."
git pull

# Formatting
echo "Formatting Nix files..."
nixpkgs-fmt .
echo "Formatting complete."

# Stage all changes in the configuration directory.
echo "Staging changes..."
git add .

# Check if there are any actual changes to commit.
if git diff --staged --quiet; then
  echo "No changes to commit. Building the current configuration."
else
  # There are changes, so create a commit.
  echo "Changes detected. Creating a new commit."

  # Use the first argument to the script as a commit message.
  # If no argument is provided, default to a timestamped message
  COMMIT_MSG="${1:-Update NixOS configuration on $(date) for $(hostname)}"
  git commit -m "$COMMIT_MSG"

  # Push the changes to your remote Git repository
  echo "Pushing changes to remote..."
  git push
  echo "Push successful."
fi

# Rebuild the system using the specified flake and hostname
echo "Rebuilding the system..."
nix run nixpkgs#nh -- os switch "$NIXOS_CONFIG_DIR" --hostname "$HOSTNAME"
# sudo nixos-rebuild switch --flake "$NIXOS_CONFIG_DIR#$HOSTNAME" |& nix run nixpkgs#nix-output-monitor
# sudo nixos-rebuild switch --flake "$NIXOS_CONFIG_DIR#$HOSTNAME" 

echo "System update complete!"
