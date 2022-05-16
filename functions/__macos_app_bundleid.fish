function __macos_app_bundleid
    argparse -n 'app bundleid' x/exact h/help -- $argv
    or return 1

    if set -q _flag_help
        echo 'Usage: app bundleid [options] pattern...

Shows the bundle identifier for each of the applictions found for the
pattern (see `app find` for how applications are found).

Options
  -x, --exact             Perform exact matches only
  -h, --help              Show this help

Examples

  > app bundleid 1password
  /Applications/1Password for Safari.app: com.1password.safari
  /Applications/1Password.app: com.1password.1password

  > app bundleid -x 1password
  /Applications/1Password.app: com.1password.1password'
    end

    if test (count $argv) -eq 0
        echo >&2 'app bundleid: Not enough arguments.'
        __macos_app_bundleid --help >&2
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
        set -l bundle_id (mdls -name kMDItemCFBundleIdentifier -r $app)

        if test -z $bundle_id
            echo >&2 'Error getting bundle ID for "'$app'"'
        else
            echo $app: $bundle_id
        end
    end
end
