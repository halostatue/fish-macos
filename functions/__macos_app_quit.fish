# @halostatue/fish-macos/functions/__macos_app_quit.fish:v7.0.1

function __macos_app_quit
    argparse --name 'app quit' x/exact r/restart h/help -- $argv
    or return 1

    if set --query _flag_help
        echo 'Usage: app quit [options] pattern...

Quits apps identified by the provided pattern or patterns (see
`app find` for how applications are found).

Options:
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

    if set --query _flag_exact
        set --function apps (__macos_app_find --exact $argv)
        or return 1
    else
        set --function apps (__macos_app_find --all $argv)
        or return 1
    end

    for app in $apps
        printf 'quit app "%s"' $app | osascript >/dev/null

        if set --query _flag_restart
            sleep 2
            open -a $app
        end
    end
end
