# @halostatue/fish-macos/functions/__macos_mac_airport_ssid.fish:v6.1.0

function __macos_mac_airport_ssid
    __macos_mac_airport_run -I | string replace --filter --regex '\s+SSID: (\S+)' '$1'
end
