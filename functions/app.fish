function app::find
    argparse -x a,A 'a/any' 'A/all' 'q/quiet' -- $argv
    or return 1

    set -l a Applications
    set -l paths \
        /$a \
        ~/$a \
        /$a/Setapp \
        /$a/Xcode.app/Contents/$a \
        /Developer/Applications

    set -l found

    for app in $argv
        set app (string replace '\.app/?$' '' $app)
        set -l apps $app.app $app.localized/$app.app

        for candidate in {$paths}/{$apps}
            if test -d $candidate -o -L $candidate
                set -q _flag_quiet
                or echo $candidate

                if set -q _flag_all
                    set found -a $candidate
                    break
                else
                    return 0
                end
            end
        end
    end

    test (count $found) -ne 0
    and return 0

    set -q _flag_quiet
    or echo >&2 'No applications found.'
    return 1
end

function app::icon
    argparse -N1 'o/output=' 'w/width=' -- $argv

    set -l apps (app::find --all $argv)
    or return 1

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

function app::bundle_id
    set -l apps (app::find --all $argv)
    or return 1

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
    argparse -n (status function) 'R/restart' -- $argv

    for app in $argv
        printf 'quit app "%s"' $app | osascript >/dev/null

        if set -q _flag_restart
            sleep 2
            open -a $app
        end
    end
end

function app -a cmd --description 'Operate on macOS applications'
    set -e argv[1]

    switch (string lower $cmd)
        case bid bundle bundle_id bundleid
            app::bundle_id $argv
        case 'find'
            app::find $argv
        case 'icon'
            app::icon $argv
        case 'quit'
            app::quit $argv
        case '*'
            echo >&2 'Unknown command '$cmd'.'
            return 1
    end
end
