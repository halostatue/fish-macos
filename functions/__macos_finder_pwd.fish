function __macos_finder_pwd
    argparse --name 'finder pwd' h/help -- $argv
    or return 1

    if set --query _flag_help
        echo 'Usage: finder pwd [options] [window#]

Prints the path of the Finder window.

Options:
  -h, --help              Show this help'
        return 0
    end

    __macos_finder_pwd_get $argv[1]
end
