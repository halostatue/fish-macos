function trash -d 'Move a specified file to the Trash'
    if ! set -q argv[1]
        echo >&2 '
Usage: trash FILE...

move file to trash, possibly appending timestamp'
        return 1
    end

    set -l trash $HOME/.Trash

    for item in $argv
        test -e $item
        or continue

        set -l name (basename $item)

        test -e $trash/$name
        and set name "$name "(date +%Y%m%d_%H%M%S)

        mv -f $item $trash/$name
    end
end
