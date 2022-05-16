function app -a cmd --description 'Operate on macOS applications'
    argparse -s h/help -- $argv

    if set -q _flag_help
        echo 'Usage: '(status function)' --help
       app find --help | [options] pattern...
       app bundleid --help | [options] pattern...
       app icon --help | [options] pattern...
       app quit --help | [options] pattern...

Operates on macOS apps by name.

Subcommands
  app find                Shows installed matching apps
  app bundleid            Shows the bundleID for installed matching apps
  app icon                Saves the icon for matching apps to disk
  app quit                Quits and optionally restarts matching apps'
        return 0
    end

    set -e argv[1]

    switch (string lower -- $cmd)
        case bundleid
            __macos_app_bundleid $argv
        case find
            __macos_app_find $argv
        case icon
            __macos_app_icon $argv
        case quit
            __macos_app_quit $argv
        case '*'
            echo >&2 'Unknown command '$cmd'.'
            return 1
    end
end
