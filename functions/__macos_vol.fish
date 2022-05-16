function __macos_vol -a action
    if set -q action
        set action (string lower $action)
    else
        set action show
    end

    switch $action
        case mute
            osascript -e 'set volume output muted true'
        case unmute
            osascript -e 'set volume output muted false'
        case (seq 0 100)
            osascript -e "set volume output volume "$action
        case '*'
            osascript -e "output volume of (get volume settings)"
    end
end
