# @halostatue/fish-macos/functions/__macos_mac_font_smoothing.fish:v7.0.1

function __macos_mac_font_smoothing
    argparse --name 'mac font-smoothing' h/help -- $argv
    or return 1

    if set --query _flag_help
        echo 'Usage: mac font-smoothing [options] off|on [APP...]

Enables or disables font smoothing. If no apps are provided, sets the
global font smoothing preference. If apps are provided, font smoothing
will be set for each app. See `app bundleid` for how apps are resolved.

States:
  off    Turns off font smoothing
  on     Turns on font smoothing

Options:
  -h, --help               Show this help'
        return 0
    end

    set --function state (string lower -- $argv[1])
    set --erase argv[1]

    switch $state
        case on
            if test (count $argv) -eq 0
                defaults delete -g CGFontRenderingFontSmoothingDisabled
            else
                for app in (__macos_app_bundleid --exact --short --all $argv)
                    defaults delete $app CGFontRenderingFontSmoothingDisabled

                    if test $app = com.microsoft.VSCode
                        defaults delete $app.helper CGFontRenderingFontSmoothingDisabled
                        defaults delete $app.helper.EH CGFontRenderingFontSmoothingDisabled
                        defaults delete $app.helper.NP CGFontRenderingFontSmoothingDisabled
                    end
                end
            end

        case off
            if test (count $argv) -eq 0
                defaults write -g CGFontRenderingFontSmoothingDisabled -bool false
            else
                for app in (__macos_app_bundleid --exact --short --all $argv)
                    defaults write $app CGFontRenderingFontSmoothingDisabled -bool false

                    if test $app = com.microsoft.VSCode
                        defaults write $app.helper CGFontRenderingFontSmoothingDisabled -bool false
                        defaults write $app.helper.EH CGFontRenderingFontSmoothingDisabled -bool false
                        defaults write $app.helper.NP CGFontRenderingFontSmoothingDisabled -bool false
                    end
                end
            end

        case '*'
            echo >&2 'mac font-smoothing: Unknown state.'
            __macos_mac_font_smoothing --help >&2
            return 1
    end
end
