function __macos_flushdns
    dscacheutil -flushcache
    and killall -HUP mDNSResponder
end
