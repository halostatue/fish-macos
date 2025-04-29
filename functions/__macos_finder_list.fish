# @halostatue/fish-macos/functions/__macos_finder_list.fish:v7.0.1

function __macos_finder_list
    argparse --name 'finder list' h/help -- $argv
    or return 1

    if set --query _flag_help
        echo 'Usage: finder list [options] [window#]

Updates the Finder window to PWD using list view.

Options:
  -h, --help              Show this help'
        return 0
    end

    __macos_finder_pwd::update --list $argv
end
