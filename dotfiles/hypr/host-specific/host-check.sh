#!/bin/sh

case "$(hostname)" in
  gluon)
    echo "source = $HOME/dotfiles/hypr/host-specific/gluon.conf" > /tmp/hypr-host.conf
    ;;
  higgs-boson)
    echo "source = $HOME/dotfiles/hypr/host-specific/higgs-boson.conf" > /tmp/hypr-host.conf
    ;;
  *)
    echo "# no host-specific config" > /tmp/hypr-host.conf
    ;;
esac