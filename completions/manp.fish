# @halostatue/fish-macos/completions/manp.fish:v7.0.1

complete --command manp --erase
complete --command manp --wraps man
complete --command manp --exclusive --condition __fish_no_arguments \
    --short-option h --long-option help --description 'Show help for manp'
complete --command manp --exclusive --condition __fish_no_arguments \
    --long-option clear-cache --description 'Clear the man page PDF cache'
