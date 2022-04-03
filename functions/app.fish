function app::find
    argparse -n 'app find' x/exact a/all q/quiet h/help -- $argv
    or return 1

    if set -q _flag_help
        echo 'Usage: app find [options] pattern...

Shows installed apps by the provided pattern or patterns. Searches for
apps in /Applications, /Applications/Setapp, /Applications/Utilities,
~/Applications, /Appliciations/Xcode.app/Contents/Applications, and
/Developer/Applications.

Options
  -x, --exact             Perform exact matches only
  -a, --all               Show all matches
  -q, --quiet             Do not print matches
  -h, --help              Show this help

Examples

  > app find -a 1password
  /Applications/1Password for Safari.app
  /Applications/1Password.app

  > app find -x 1password
  /Applications/1Password.app'
        return 0
    end

    if test (count $argv) -eq 0
        echo >&2 'app find: Not enough arguments.'
        app::find --help >&2
        return 1
    end

    set -l a Applications
    set -l paths \
        /$a \
        ~/$a \
        /$a/Setapp \
        /$a/Utilities \
        /$a/Xcode.app/Contents/$a \
        /Developer/Applications

    set -l found 0

    for pattern in $argv
        set pattern (string replace '\.app/?$' '' $pattern)
        set -l apps {$paths}/*.app {$paths}/*.localized/*.app
        for candidate in $apps
            set -l found_item 0

            if set -q _flag_exact
                if string match -i -e -q /$pattern.app $candidate
                    set found_item 1
                end
            else if string match -i -e -q $pattern $candidate
                set found_item 1
            end

            if test $found_item -eq 1
                set -q _flag_quiet
                or echo $candidate

                set found (math $found + $found_item)

                set -q _flag_quiet
                and return 0

                set -q _flag_all
                or return 0
            end

        end
    end

    test $found -gt 0
    and return 0

    set -q _flag_quiet
    or echo >&2 'No applications found.'
    return 1
end

function app::icon
    argparse -n 'app quit' x/exact h/help 'o/output=' 'w/width=' -- $argv
    or return 1

    if set -q _flag_help
        echo 'Usage: app icon [options] pattern...

Extracts macOS app icons as PNG (see `app find` for how applications
are found).

Options
  -x, --exact             Perform exact matches only
  -oOUTPUT                Output to the file or directory specified
  --output OUTPUT         Output to the file or directory specified
  -wWIDTH                 Outputs to a maximum of WIDTH pixels
  --width WIDTH           Outputs to a maximum of WIDTH pixels
  -h, --help              Show this help'
        return 0
    end

    if test (count $argv) -eq 0
        echo >&2 'app icon: Not enough arguments.'
        app::icon --help >&2
        return 1
    end


    set -l apps

    if set -q _flag_exact
        set apps (app::find --exact $argv)
        or return 1
    else
        set apps (app::find --all $argv)
        or return 1
    end

    set -l app_count (count $apps)

    set -l output_path $PWD
    if not test -z $_flag_output
        if test -e $_flag_output
            if test -f $_flag_output
                if test $app_count -gt 1
                    echo >&2 'app icon: More than one application found, but only one output file specified.'
                    return 1
                end

                set output_path (dirname $_flag_output)
                set output_file (basename $_flag_output)
            else if test -d $_flag_output
                set output_path $_flag_output
            else
                echo >&2 'app icon: Output to a non-file or directory specified.'
                return 1
            end
        else
            set output_path $_flag_output
            mkdir -p $output_path
        end
    end

    for app in $apps
        set -l icon $app/Contents/Resources/(
            defaults read $app/Contents/Info CFBundleIconFile |
            string replace -r '\.icns$' ''
        ).icns

        set -l name (basename $app .app)_icon.png
        set -l tmp $TMPDIR/$name
        set -l max_width (sips -g pixelWidth $icon | tail -1 | awk '{ print $2; }')

        set -l outfile
        set -l width

        if test -z $output_file
            set outfile $output_path/$name
        else
            set outfile $output_path/$output_file
        end

        if test -z $_flag_width
            set width $max_width
        else if test $_flag_width -gt $max_width
            set width $max_width
        else
            set width $_flag_width
        end

        sips -s format png --resampleHeightWidthMax $width $icon --out $outfile >/dev/null 2>&1

        echo Wrote $app icon to $outfile.
    end
end

function app::bundleid
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
        app::bundleid --help >&2
        return 1
    end

    set -l apps

    if set -q _flag_exact
        set apps (app::find --exact $argv)
        or return 1
    else
        set apps (app::find --all $argv)
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

function app::quit
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
        app::quit --help >&2
        return 1
    end

    set -l apps

    if set -q _flag_exact
        set apps (app::find --exact $argv)
        or return 1
    else
        set apps (app::find --all $argv)
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
            app::bundleid $argv
        case find
            app::find $argv
        case icon
            app::icon $argv
        case quit
            app::quit $argv
        case '*'
            echo >&2 'Unknown command '$cmd'.'
            return 1
    end
end
