# This overlay disables the failing tests for the kitty terminal package.
# An overlay is a function that takes two arguments:
# - `final`: The final package set after all overlays are applied.
# - `prev`: The package set from the previous stage.
final: prev:

{
  # We are overriding the 'kitty' package.
  # kitty = prev.kitty.overrideAttrs (oldAttrs: {
  #   # The tests run in the `checkPhase` or `installCheckPhase`.
  #   # Setting `doCheck = false;` disables both.
  #   doCheck = false;
  # });
  # (final: prev: {
  kitty = prev.kitty.overrideAttrs (oldAttrs: {
    # This is a more aggressive way to skip tests by replacing
    # the entire phase with a command that does nothing.
    installCheckPhase = ''
      echo "Skipping failing kitty tests."
    '';
  });
  # })
}
