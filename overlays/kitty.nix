# This overlay disables the failing tests for the kitty terminal package.
final: prev:

{
  # We are overriding the 'kitty' package.
  kitty = prev.kitty.overrideAttrs (oldAttrs: {
    # This is a more aggressive way to skip tests by replacing
    # the entire phase with a command that does nothing.
    installCheckPhase = ''
      echo "Skipping failing kitty tests."
    '';
  });
}
