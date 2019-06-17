function flushdns -d 'Flush MacOS DNS Cache'
    dscacheutil -flushcache
    and killall -HUP mDNSResponder
end
