function __macos_font_smoothing_disable
    if test (count $argv) -eq 0
        defaults write -g CGFontRenderingFontSmoothingDisabled -bool false
    else
        for app in (__macos_app_bundleid -x -s -a $argv)
            defaults write $app CGFontRenderingFontSmoothingDisabled -bool false

            if test $app = com.microsoft.VSCode
                defaults write $app.helper CGFontRenderingFontSmoothingDisabled -bool false
                defaults write $app.helper.EH CGFontRenderingFontSmoothingDisabled -bool false
                defaults write $app.helper.NP CGFontRenderingFontSmoothingDisabled -bool false
            end
        end
    end
end
