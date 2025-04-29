# @halostatue/fish-macos/functions/__macos_mac_brightness.fish:v7.0.1

function __macos_mac_brightness
    argparse --name 'mac brightness' h/help -- $argv
    or return 1

    if set --query _flag_help
        echo 'Usage: mac brightness [options] DIRECTION

Adjust the screen brightness level.

Direction:
  up                    Increases the screen brightness level.
  down                  Decreases the screen brightness level.

Options:
  -h, --help               Show this help'
        return 0
    end

    set --function direction (string lower -- $argv[1])
    set --erase argv[1]

    switch $direction
        case down
            echo 'tell application "System Events"
              key code 145
            end tell' | osascript >/dev/null
        case up ''
            echo 'tell application "System Events"
              key code 144
            end tell' | osascript >/dev/null
        case '*'
            echo >&2 'mac brightness: Unknown direction'
            __macos_mac_brightness --help >&2
            return 1
    end
end
