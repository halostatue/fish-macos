function __macos_finder_cd
    argparse --name 'finder cd' h/help -- $argv
    or return 1

    if set --query _flag_help
        echo 'Usage: finder cd [options] [window#]

Changes the current path to the path of the Finder window.

Options:
  -h, --help              Show this help'
        return 0
    end

    cd (__macos_finder_pwd_get $argv[1])
end
