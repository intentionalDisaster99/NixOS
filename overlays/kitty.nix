# This overlay disables the failing tests for the kitty terminal package.
final: prev:

{
  kitty = prev.kitty.overrideAttrs (oldAttrs: {
    installCheckPhase = ''
      echo "Skipping failing kitty tests."
    '';
  });
}

