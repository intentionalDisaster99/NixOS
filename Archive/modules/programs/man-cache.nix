{ config, pkgs, ... }:

{
  # Disable the slow, blocking generation during rebuild
  documentation.man.cache.enable = false;

  # Create the background service
  systemd.services.man-db-cache-update = {
    description = "Update man-db cache (Content-Addressed)";
    wantedBy = [ "multi-user.target" ];

    # This ensures it triggers after a system switch
    after = [ "sysinit-reactivation.target" ];

    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
    };

    script = ''
      MAN_DIR="/run/current-system/sw/share/man"
      CACHE_DIR="/var/cache/man"
      HASH_FILE="$CACHE_DIR/last_man_hash"

      mkdir -p "$CACHE_DIR"

      # 1. Generate a fingerprint of the current manpage directory
      # We use names and sizes to detect changes quickly
      CURRENT_HASH=$(find "$MAN_DIR" -type f -name "*.gz" -printf "%p %s\n" 2>/dev/null | sort | md5sum | cut -d' ' -f1)

      # 2. Compare with the stored hash
      if [ -f "$HASH_FILE" ] && [ "$CURRENT_HASH" = "$(cat "$HASH_FILE")" ]; then
        echo "Manpages haven't changed. Skipping cache rebuild."
        exit 0
      fi

      # 3. If they changed, rebuild the cache
      echo "Manpages changed. Rebuilding cache..."
      ${pkgs.man-db}/bin/mandb -q --create
      
      # 4. Save the new hash
      echo "$CURRENT_HASH" > "$HASH_FILE"
    '';
  };
}
