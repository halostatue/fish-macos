# @halostatue/fish-macos/functions/__macos_app_bundleid.fish:v7.0.1

function __macos_app_bundleid
    argparse --name 'app bundleid' x/exact a/all h/help q/quiet s/short -- $argv
    or return 1

    if set --query _flag_help
        echo 'Usage: app bundleid [options] pattern...

Shows the bundle identifier for each of the applications found for the
pattern (see `app find` for how applications are found).

Options:
  -x, --exact             Perform exact matches only
  -a, --all               Show all matches
  -q, --quiet             Suppress error output
  -s, --short             Prints out the bundle IDs only
  -h, --help              Show this help

Examples:
  > app bundleid 1password
  /Applications/1Password for Safari.app: com.1password.safari
  /Applications/1Password.app: com.1password.1password

  > app bundleid -x 1password
  /Applications/1Password.app: com.1password.1password'
        return 0
    end

    if test (count $argv) -eq 0
        echo >&2 'app bundleid: Not enough arguments.'
        __macos_app_bundleid --help >&2
        return 1
    end

    set --function apps (__macos_app_find $_flag_exact $_flag_all $argv)
    or return 1

    for app in $apps
        set --local bundle_id (mdls -name kMDItemCFBundleIdentifier -r $app)

        if test -z $bundle_id
            set --query _flag_quiet
            or echo >&2 'Error getting bundle ID for "'$app'"'
        else
            if set --query _flag_short
                echo $bundle_id
            else
                echo $app: $bundle_id
            end
        end
    end
end
