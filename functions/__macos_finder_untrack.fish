# @halostatue/fish-macos/functions/__macos_finder_untrack.fish:v7.0.1

function __macos_finder_untrack
    argparse --name 'finder untrack' h/help -- $argv
    or return 1

    if set --query _flag_help
        echo 'Usage: finder untrack [options]

Unlinks the shell PWD from the first Finder window.

Options:
  -h, --help              Show this help'
        return 0
    end

    functions --erase __macos_finder_tracking
end
