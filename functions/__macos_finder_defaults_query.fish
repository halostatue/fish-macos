function __macos_finder_defaults_query -a key
    set -l value (defaults read com.apple.Finder $key 2>/dev/null)
    or return 1

    switch $value
        case 1
            true
        case '*'
            false
    end
end
