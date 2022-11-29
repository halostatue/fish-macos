function __macos_app_find
    argparse --name 'app find' x/exact a/all q/quiet h/help -- $argv
    or return 1

    if set --query _flag_help
        echo 'Usage: app find [options] pattern...

Shows installed apps by the provided pattern or patterns. Searches for
apps in /Applications, /Applications/Setapp, /Applications/Utilities,
~/Applications, /Appliciations/Xcode.app/Contents/Applications,
/Developer/Applications, and /System/Applications.

Options:
  -x, --exact             Perform exact matches only
  -a, --all               Show all matches
  -q, --quiet             Do not print matches
  -h, --help              Show this help

Examples:
  > app find -a 1password
  /Applications/1Password for Safari.app
  /Applications/1Password.app

  > app find -x 1password
  /Applications/1Password.app'
        return 0
    end

    if test (count $argv) -eq 0
        echo >&2 'app find: Not enough arguments.'
        __macos_app_find --help >&2
        return 1
    end

    set --local a Applications
    set --local paths \
        /$a \
        ~/$a \
        /$a/Setapp \
        /$a/Utilities \
        /$a/Xcode.app/Contents/$a \
        /Developer/Applications \
        /System/Applications

    set --local found 0

    for pattern in $argv
        set pattern (string replace '\.app/?$' '' $pattern)
        set --local apps {$paths}/*.app {$paths}/*.localized/*.app
        for candidate in $apps
            set --local found_item 0

            if set --query _flag_exact
                if string match -i -e -q /$pattern.app $candidate
                    set found_item 1
                end
            else if string match -i -e -q $pattern $candidate
                set found_item 1
            end

            if test $found_item -eq 1
                set --query _flag_quiet
                or echo $candidate

                set found (math $found + $found_item)

                set --query _flag_quiet
                and return 0

                set --query _flag_all
                or return 0
            end

        end
    end

    test $found -gt 0
    and return 0

    set --query _flag_quiet
    or echo >&2 'No applications found.'
    return 1
end
