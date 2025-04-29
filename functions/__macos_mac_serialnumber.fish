# @halostatue/fish-macos/functions/__macos_mac_serialnumber.fish:v7.0.1

function __macos_mac_serialnumber
    argparse --name 'mac serialnumber' h/help c/copy -- $argv
    or return 1

    if set --query _flag_help
        echo 'Usage: mac serialnumber [options]

Gets the serial number for the current macOS device.

Options:
  -c, --copy               Copy to the clipboard
  -h, --help               Show this help'
        return 0
    end

    set --function serial (ioreg -l | string replace --filter --regex --all '^.*"IOPlatformSerialNumber"\s+=\s+"([^"]+)"' '$1')

    set --query _flag_copy && echo $serial | pbcopy
    echo $serial
end
