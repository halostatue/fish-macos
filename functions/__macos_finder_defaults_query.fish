# @halostatue/fish-macos/functions/__macos_finder_defaults_query.fish:v6.1.0

function __macos_finder_defaults_query
    set --query argv[1]
    or return 1

    set --function value (defaults read com.apple.Finder $argv[1] 2>/dev/null)
    or return 1

    switch $value
        case 1
            true
        case '*'
            false
    end
end
