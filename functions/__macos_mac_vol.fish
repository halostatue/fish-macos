# @halostatue/fish-macos/functions/__macos_mac_vol.fish:v7.0.1

function __macos_mac_vol
    argparse --name 'mac vol' h/help -- $argv
    or return 1

    if set --query _flag_help
        echo 'Usage: mac vol [options] LEVEL

Control the volume level.

Levels:
  mute                  Mutes the volume level.
  unmute                Unmutes the volume level.
  0 .. 100              Sets the volume level at LEVEL %.
  [show]                Shows the current volume level.

Options:
  -h, --help               Show this help'
        return 0
    end

    set --function action (string lower -- $argv[1])
    set --erase argv[1]

    switch $action
        case mute
            osascript -e 'set volume output muted true'
        case unmute
            osascript -e 'set volume output muted false'
        case (seq 0 100)
            osascript -e "set volume output volume "$action
        case show ''
            if test (osascript -e 'output muted of (get volume settings)') = true
                echo muted
            else
                osascript -e "output volume of (get volume settings)"
            end

        case '*'
            echo >&2 'mac vol: Unknown level'
            __macos_mac_vol --help >&2
            return 1
    end
end
