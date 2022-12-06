function __macos_app_frontmost_info
    set --local value (lsappinfo info -only $argv[2] $argv[1] | string split =)[2]
    or return 1
    string replace --all '"' '' $value
    return 0
end
