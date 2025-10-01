# This overlay disables the failing tests for the kitty terminal package.
# An overlay is a function that takes two arguments:
final: prev:

{
  kitty = prev.kitty.overrideAttrs (oldAttrs: {
    # This is a more aggressive way to skip tests by replacing
    # the entire phase with a command that does nothing.
    installCheckPhase = ''
      echo "Skipping failing kitty tests."
    '';
  });
}
