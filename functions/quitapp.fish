function quitapp -d 'Quit a MacOS application'
    argparse -n (status function) 'R/restart' -- $argv

    for app in $argv
        printf 'quit app "%s"' $app | osascript >/dev/null

        if set -q _flag_restart
            sleep 2
            open -a $app
        end
    end
end
