# @halostatue/fish-macos/functions/__macos_mac_defaults_query.fish:v7.0.1

function __macos_mac_defaults_query
    if set --function value (defaults read $argv[1] $argv[2] 2>/dev/null)
        echo $value
    else
        echo $argv[3]
    end
end
