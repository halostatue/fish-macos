function vol -d 'Set or show the Mac audio volume'
    set -l action '*'
    set -q argv[1]
    and set -l action (string lower $argv[1])

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
