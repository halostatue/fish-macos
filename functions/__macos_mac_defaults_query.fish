function __macos_mac_defaults_query
    if set --local value (defaults read $argv[1] $argv[2] 2>/dev/null)
        echo $value
    else
        echo $argv[3]
    end
end
