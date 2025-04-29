# @halostatue/fish-macos/functions/__macos_app_icon.fish:v7.0.1

function __macos_app_icon
    argparse --name 'app quit' x/exact h/help 'o/output=' 'w/width=' -- $argv
    or return 1

    if set --query _flag_help
        echo 'Usage: app icon [options] pattern...

Extracts macOS app icons as PNG (see `app find` for how applications
are found).

Options:
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
        __macos_app_icon --help >&2
        return 1
    end


    if set --query _flag_exact
        set --function apps (__macos_app_find --exact $argv)
        or return 1
    else
        set --function apps (__macos_app_find --all $argv)
        or return 1
    end

    set --function app_count (count $apps)

    set --function output_path $PWD
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
        set --local icon $app/Contents/Resources/(
            defaults read $app/Contents/Info CFBundleIconFile |
            string replace --regex '\.icns$' ''
        ).icns

        set --local name (basename $app .app)_icon.png
        set --local tmp $TMPDIR/$name
        set --local max_width (sips -g pixelWidth $icon | tail -1 | awk '{ print $2; }')

        set --local outfile
        set --local width

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
