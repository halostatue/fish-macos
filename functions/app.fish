# @halostatue/fish-macos/functions/app.fish:v7.0.1

function app --description 'Operate on macOS applications'
    argparse --stop-nonopt h/help -- $argv

    if set --query _flag_help
        echo 'Usage: app [options] subcommand [arguments...]

Operates on macOS apps by name.

Subcommands:
  bundleid            Shows the bundleID for installed matching apps
  find                Shows installed matching apps
  frontmost           Shows the frontmost application
  icon                Saves the icon for matching apps to disk
  quit                Quits and optionally restarts matching apps

Options:
  -h, --help               Show this help'
        return 0
    end

    set --function cmd $argv[1]
    set --erase argv[1]

    switch (string lower -- $cmd)
        case bundleid
            __macos_app_bundleid $argv
        case find
            __macos_app_find $argv
        case frontmost
            __macos_app_frontmost $argv
        case icon
            __macos_app_icon $argv
        case quit
            __macos_app_quit $argv
        case ''
            echo >&2 'app: No command provided.'
            app --help >&2
            return 1
        case '*'
            echo >&2 'app: Unknown command.'
            app --help >&2
            return 1
    end
end
