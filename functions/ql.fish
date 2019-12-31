function ql -d 'QuickLook a file or directory'
    if set -q argv[1]
        qlmanage > /dev/null 2> /dev/null $argv -p &
    else
        qlmanage
    end
end
