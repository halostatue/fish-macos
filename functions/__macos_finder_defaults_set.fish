# @halostatue/fish-macos/functions/__macos_finder_defaults_set.fish:v6.1.0

function __macos_finder_defaults_set
    set --query argv[1]
    or return 1

    set --query argv[2]
    or return 1

    defaults write com.apple.Finder $argv[1] -bool $argv[2]
    and killall Finder
end
