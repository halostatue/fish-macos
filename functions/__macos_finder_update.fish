function __macos_finder_update
    argparse --name 'finder update' h/help -- $argv
    or return 1

    if set --query _flag_help
        echo 'Usage: finder update [options] [window#]

Updates the Finder window to PWD.

Options:
  -h, --help              Show this help'
        return 0
    end

    __macos_finder_pwd_update $argv
end
