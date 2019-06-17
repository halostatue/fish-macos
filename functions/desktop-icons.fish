function __halostatue_fish_mac_desktop_icons_set
    defaults write com.apple.finder CreateDesktop -bool $argv[1]
    and killall Finder
end

function __halostatue_fish_mac_desktop_icons_visible
    switch (defaults read com.apple.finder CreateDesktop 2>/dev/null)
        case 1
            true
        case '*'
            false
    end
end

function desktop-icons -d 'Manage the visibility of desktop icons'
    set -l verb (string lower $argv[1])
    switch $verb
        case hide off
            __halostatue_fish_mac_desktop_icons_set true
        case show on
            __halostatue_fish_mac_desktop_icons_set false
        case toggle
            if __halostatue_fish_mac_desktop_icons_visible
                __halostatue_fish_mac_desktop_icons_set true
            else
                __halostatue_fish_mac_desktop_icons_set false
            end
        case status
            __halostatue_Fish_mac_desktop_icons_visible
            and echo 'Desktop icons are visible.'
            or echo 'Desktop icons are hidden.'
    end
end
