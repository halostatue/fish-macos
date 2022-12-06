function __macos_finder_defaults_query
    set --query argv[1]
    or return 1

    set --local value (defaults read com.apple.Finder $argv[1] 2>/dev/null)
    or return 1

    switch $value
        case 1
            true
        case '*'
            false
    end
end
