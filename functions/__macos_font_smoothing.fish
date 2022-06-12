function __macos_font_smoothing
    set -l state (string lower $argv[1])
    set -e argv[1]

    switch $state
        case on
            __macos_font_smoothing_enable $argv
        case off
            __macos_font_smoothing_disable $argv
        case '*'
            echo >&2 Unknown state "'$state'". Must be on or off.
            return 1
    end
end
