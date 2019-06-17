function plistbuddy -d 'A wrapper for PlistBuddy'
    argparse -n (status function) 't-tutorial' -- $argv

    if set -q $_flag_tutorial
        open https://fgimian.github.io/blog/2015/06/27/a-simple-plistbuddy-tutorial/
        return
    end

    command -sq rlwrap
    and rlwrap /usr/libexec/PlistBuddy $argv
    or /usr/libexec/PlistBuddy $argv
end
