# @halostatue/fish-macos/functions/__macos_mac_version.fish:v7.0.1

function __macos_mac_version
    argparse \
        --exclusive s,v \
        --exclusive l,v \
        --exclusive s,c \
        --exclusive l,c \
        --exclusive v,c \
        h/help s/simple l/lowercase v/version c/comparable -- $argv

    if set --query _flag_help
        echo 'Usage: mac version [options]

Shows the current mac version.

Options:
    -s, --simple          Removes spaces from the version displayed
    -l, --lowercase       Converts the version to all lowercase
    -c, --comparable      Outputs the comparable version value
    -v, --version         Outputs the macOS version (same as sw_vers -productVersion)'
        return 0
    end

    set --function os_version (sw_vers -productVersion)

    if set --query _flag_version
        echo $os_version
        return $status
    end

    set os_version (__macos_version_to_comparable $os_version)
    or return 1

    if set --query _flag_comparable
        echo $os_version
        return 0
    end

    switch $os_version
        case 1005000
            set os_version Leopard
        case 1006000
            set os_version Snow Leopard
        case 1007000
            set os_version Lion
        case 1008000
            set os_version Mountain Lion
        case 1009000
            set os_version Mavericks
        case 1010000
            set os_version Yosemite
        case 1011000
            set os_version El Capitan
        case 1012000
            set os_version Sierra
        case 1013000
            set os_version High Sierra
        case 1014000
            set os_version Mojave
        case 1015000
            set os_version Catalina
        case 1100000
            set os_version Big Sur
        case 1200000
            set os_version Monterey
        case 1300000
            set os_version Ventura
        case 1400000
            set os_version Sonoma
        case 1500000
            set os_version Sequoia
        case '*'
            return 1
    end

    if set --query _flag_simple
        set os_version (string replace --all ' ' '' "$os_version")
    end

    if set --query _flag_lowercase
        set os_version (string lower -- "$os_version")
    end

    echo $os_version
end
