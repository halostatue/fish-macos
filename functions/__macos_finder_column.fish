# @halostatue/fish-macos/functions/__macos_finder_column.fish:v7.0.1

function __macos_finder_column
    argparse --name 'finder column' h/help -- $argv
    or return 1

    if set --query _flag_help
        echo 'Usage: finder column [options] [window#]

Updates the Finder window to PWD using column view.

Options:
  -h, --help              Show this help'
        return 0
    end

    __macos_finder_pwd::update --column $argv
end
