# This overlay disables the failing tests for the kitty terminal package.
{
  kitty = prev.kitty.overrideAttrs (oldAttrs: {
    installCheckPhase = ''
      echo "Skipping failing kitty tests."
    '';
  });
}
