function __macos_finder_defaults_set -a key value
    defaults write com.apple.Finder $key -bool $value
    and killall Finder
end
