# This toggles Nordvpn on and off
function nord-toggle

    set -l STARTING_STATUS ( nordvpn status | grep "Status: Disconnected" )
    if test -n "$STARTING_STATUS"

        # This will run if it is disconnected
        nordvpn c # Trying to connect

    else

        # This will run if it is connected
        nordvpn d # Trying to disconnect

    end

    # Checking again to see if we are connected or not
    set -l STATUS ( nordvpn status | grep "Status: Disconnected" )

    # If the status is the same, then we had an issue and need to send what happened
    if test "$STARTING_STATUS" = "$STATUS"
        if test -n "$STATUS"

            # This will run if it is disconnected
            notify-send There was an error, you are still disconnected

        else

            # This will run if it is connected
            notify-send There was an error, you are still connected

        end
    end
end
