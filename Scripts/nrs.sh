# #!/usr/bin/env bash

# # Exit immediately if any command fails.
# set -e

# # Check to see if they want to use remote
# REMOTE=0
# if [[ "$1" == "-r" || "$1" == "--remote" ]]; then
# 	REMOTE=1
# 	shift # Remove the remote flag so the rest of the script reads the commit message correctly
# fi

# # Asking for sudo privileges
# sudo -v

# NIXOS_CONFIG_DIR="/etc/nixos"
# # Automatically detect the system's hostname for the flake.
# HOSTNAME=$(hostname)

# echo "Starting NixOS configuration update for host: $HOSTNAME"

# cd "$NIXOS_CONFIG_DIR"

# # Pulling any files that had been pushed before
# echo "Pulling files.."
# git pull

# sleep 1

# # Formatting
# echo "Formatting Nix files..."
# nixpkgs-fmt .
# echo "Formatting complete."

# sleep 1

# # Stage all changes in the configuration directory.
# echo "Staging changes..."
# git add .

# # Check if there are any actual changes to commit.
# if git diff --staged --quiet; then
# 	echo "No changes to commit. Building the current configuration."
# else
# 	# There are changes, so create a commit.
# 	echo "Changes detected. Creating a new commit."

# 	# Use the first argument to the script as a commit message.
# 	# If no argument is provided, default to a timestamped message
# 	COMMIT_MSG="${1:-Update NixOS configuration on $(date) for $(hostname)}"
# 	git commit -m "$COMMIT_MSG"

# 	# Push the changes to your remote Git repository
# 	echo "Pushing changes to remote..."
# 	git push
# 	echo "Push successful."
# fi

# if [ "$REMOTE" -eq 1 ]; then
# 	echo "Initiating remote build on gluon-linux..."
# 	# sudo nixos-rebuild switch --flake "$NIXOS_CONFIG_DIR#$HOSTNAME" \
# 	#   --build-host sa9m@gluon-linux \
# 	#   --target-host localhost |& nix run nixpkgs#nix-output-monitor
# 	sudo nixos-rebuild switch --flake "$NIXOS_CONFIG_DIR#$HOSTNAME" \
# 		--build-host sa9m@gluon-linux |& nix run nixpkgs#nix-output-monitor
# elif command -v nh >/dev/null 2>&1 && command -v nom >/dev/null 2>&1; then
# 	echo "Building with nh and nom..."
# 	nh os switch "$NIXOS_CONFIG_DIR" --hostname "$HOSTNAME"
# elif command -v nh >/dev/null 2>&1; then
# 	echo "Building with nh..."
# 	nh os switch "$NIXOS_CONFIG_DIR" --hostname "$HOSTNAME"
# elif ping -c 1 -W 2 1.1.1.1 >/dev/null 2>&1; then
# 	echo "Building with nh through nix shell..."
# 	nix shell nixpkgs#nh nixpkgs#nix-output-monitor -c nh os switch "$NIXOS_CONFIG_DIR" --hostname "$HOSTNAME"
# else
# 	echo "Commands missing, building without nh..."
# 	sudo nixos-rebuild switch --flake "$NIXOS_CONFIG_DIR#$HOSTNAME"
# fi

# echo "System update complete!"
#!/usr/bin/env bash
set -e

MODE="local"
TARGET_HOST=""

# Parse flags
while [[ $# -gt 0 ]]; do
	case "$1" in
	-r | --remote)
		MODE="remote-build"
		shift
		;;
	-d | --deploy)
		MODE="deploy"
		if [[ -n "$2" && "$2" != -* ]]; then
			TARGET_HOST=".#$2"
			shift
		fi
		shift
		;;
	*)
		break
		;;
	esac
done

NIXOS_CONFIG_DIR="/etc/nixos"
HOSTNAME=$(hostname)

echo "Starting NixOS configuration update from host: $HOSTNAME (mode: $MODE)"
cd "$NIXOS_CONFIG_DIR"

echo "Pulling files..."
git pull

echo "Formatting Nix files..."
nixpkgs-fmt .

echo "Staging changes..."
git add .

if git diff --staged --quiet; then
	echo "No changes to commit. Building the current configuration."
else
	COMMIT_MSG="${1:-Update NixOS configuration on $(date) for $(hostname)}"
	git commit -m "$COMMIT_MSG"
	echo "Pushing changes to remote..."
	git push
fi

if [[ "$MODE" == "deploy" ]]; then
	echo "Deploying via deploy-rs from $HOSTNAME..."
	# Note: make sure hostname in flake.nix for gluon matches how gluon reaches itself (e.g., "gluon-linux" or "localhost")
	nix run github:serokell/deploy-rs -- $TARGET_HOST

elif [[ "$MODE" == "remote-build" ]]; then
	echo "Triggering deploy-rs remotely on gluon-linux to build and push to $HOSTNAME..."
	# Because changes were just pushed to git above, gluon pulls them and builds for your laptop!
	ssh -t sa9m@gluon-linux "cd $NIXOS_CONFIG_DIR && git pull && nix run github:serokell/deploy-rs -- .#$HOSTNAME"

else
	# Fast local build using nh
	sudo -v
	if command -v nh >/dev/null 2>&1; then
		nh os switch "$NIXOS_CONFIG_DIR" --hostname "$HOSTNAME"
	elif ping -c 1 -W 2 1.1.1.1 >/dev/null 2>&1; then
		nix shell nixpkgs#nh nixpkgs#nix-output-monitor -c nh os switch "$NIXOS_CONFIG_DIR" --hostname "$HOSTNAME"
	else
		sudo nixos-rebuild switch --flake "$NIXOS_CONFIG_DIR#$HOSTNAME"
	fi
fi

echo "System update complete!"
