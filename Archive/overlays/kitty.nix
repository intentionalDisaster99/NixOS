# This overlay disables the failing tests for the kitty terminal package.
# An overlay is a function that takes two arguments:
# - `final`: The final package set after all overlays are applied.
# - `prev`: The package set from the previous stage.
final: prev:

{
  # We are overriding the 'kitty' package.
  kitty = prev.kitty.overrideAttrs (oldAttrs: {
    # The tests run in the `checkPhase` or `installCheckPhase`.
    # Setting `doCheck = false;` disables both.
    doCheck = false;
  });
}
