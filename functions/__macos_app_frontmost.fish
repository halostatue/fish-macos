# @halostatue/fish-macos/functions/__macos_app_frontmost.fish:v7.0.1

function __macos_app_frontmost::info
    set --function value (lsappinfo info -only $argv[2] $argv[1] | string split =)[2]
    or return 1

    string replace --all '"' '' $value
    return 0
end

function __macos_app_frontmost
    argparse --name 'app frontmost' \
        h/help b/bundle-id p/path n/name P/pid a/all \
        -- $argv
    or return 1

    if set --query _flag_help
        echo 'Usage: app frontmost [options]

Retrieves details about the front-most application.

Options:
  -b, --bundle-id         Shows the app bundle ID
  -p, --path              Shows the app path
  -n, --name              Shows the app name
  -P, --pid               Shows the PID of the app
  -a, --all               Shows all details
  -h, --help              Show this help

Example:
  > app frontmost
  iTerm2'
        return 0
    end

    set --function front (lsappinfo front)
    or return 1

    set --function items 0

    if set --query _flag_all
        set items 4
    else
        set --query _flag_bundle_id _flag_path _flag_name _flag_pid
        set --local missing $status

        switch $missing
            case 0
                set _flag_all 1
                set items 4
            case 4
                set _flag_name 1
                set items 1
            case '*'
                set items (math 4 - $missing)
        end
    end

    if set --query _flag_name || set --query _flag_all
        set --function name (__macos_app_frontmost::info $front name)
        or return 1
    end

    if set --query _flag_bundle_id || set --query _flag_all
        set --function bundle_id (__macos_app_frontmost::info $front bundleID)
        or return 1
    end

    if set --query _flag_path || set --query _flag_all
        set --function bundle_path (__macos_app_frontmost::info $front bundlepath)
        or return 1
    end

    if set --query _flag_pid || set --query _flag_all
        set --function pid (__macos_app_frontmost::info $front pid)
        or return 1
    end

    if set --query _flag_all
        printf "%s: %s %s (%s)\n" $name $bundle_id $bundle_path $pid
    else
        if set --query _flag_name
            printf "%s" $name
            test $items -gt 1 && printf ": "
            set items (math $items - 1)
        end

        if set --query _flag_bundle_id
            printf "%s" $bundle_id
            test $items -gt 1 && printf " "
            set items (math $items - 1)
        end

        if set --query _flag_path
            printf "%s" $bundle_path
            test $items -gt 1 && printf " "
            set items (math $items - 1)
        end

        if set --query _flag_pid
            if test $items -gt 1
                printf "(%s)" $pid
            else
                printf "%s" $pid
            end
        end

        printf "\n"
    end
end
