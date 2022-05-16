function __macos_finder_track
    switch $argv[1]
        case enable
            functions -q finder:::track
            or function finder:::track --on-variable PWD
                __macos_finder_pwd_update
            end
            __macos_finder_pwd_update
        case disable
            functions -e finder:::track
    end
end
