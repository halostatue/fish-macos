function __macos_app_quit
    argparse -n 'app quit' x/exact r/restart h/help -- $argv
    or return 1

    if set -q _flag_help
        echo 'Usage: app quit [options] pattern...

Quits apps identified by the provided pattern or patterns (see
`app find` for how applications are found).

Options
  -x, --exact             Quits only applications with exact matches
  -r, --restart           Restarts the application that was quit
  -h, --help              Show this help'
        return 0
    end

    if test (count $argv) -eq 0
        echo >&2 'app bundleid: Not enough arguments.'
        __macos_app_quit --help >&2
        return 1
    end

    set -l apps

    if set -q _flag_exact
        set apps (__macos_app_find --exact $argv)
        or return 1
    else
        set apps (__macos_app_find --all $argv)
        or return 1
    end

    for app in $apps
        printf 'quit app "%s"' $app | osascript >/dev/null

        if set -q _flag_restart
            sleep 2
            open -a $app
        end
    end
end
