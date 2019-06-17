function lsclean -d 'Clean LaunchServices to remove duplicate Open with...'
    /System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister \
        -kill -r -domain local -domain system -domain user
    and killall Finder
end
