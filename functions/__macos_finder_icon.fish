# @halostatue/fish-macos/functions/__macos_finder_icon.fish:v7.0.1

function __macos_finder_icon
    argparse --name 'finder icon' h/help -- $argv
    or return 1

    if set --query _flag_help
        echo 'Usage: finder icon [options] [window#]

Updates the Finder window to PWD using icon view.

Options:
  -h, --help              Show this help'
        return 0
    end

    __macos_finder_pwd::update --icon $argv
end
