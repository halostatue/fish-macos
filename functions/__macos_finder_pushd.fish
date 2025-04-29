# @halostatue/fish-macos/functions/__macos_finder_pushd.fish:v7.0.1

function __macos_finder_pushd
    argparse --name 'finder pushd' h/help -- $argv
    or return 1

    if set --query _flag_help
        echo 'Usage: finder pushd [options] [window#]

Changes the current path to the path of the Finder window with pushd.

Options:
  -h, --help              Show this help'
        return 0
    end

    pushd (__macos_finder_pwd::get $argv[1])
end
