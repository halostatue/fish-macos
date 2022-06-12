function __macos_font_smoothing_enable
    if test (count $argv) -eq 0
        defaults write -g CGFontRenderingFontSmoothingDisabled -bool true
    else
        for app in (__macos_app_bundleid -x -s -a $argv)
            defaults delete $app CGFontRenderingFontSmoothingDisabled

            if test $app = com.microsoft.VSCode
                defaults delete $app.helper CGFontRenderingFontSmoothingDisabled
                defaults delete $app.helper.EH CGFontRenderingFontSmoothingDisabled
                defaults delete $app.helper.NP CGFontRenderingFontSmoothingDisabled
            end
        end
    end
end
