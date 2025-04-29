# @halostatue/fish-macos/functions/manp.fish:v7.0.1

# Based on man2pdf.sh created by Pico Mitchell (of Random Applications)
# on 11/16/22, licensed under the MIT license.
function manp --description 'View a man page as a PDF'
    set --function cache_path "/private/tmp/man PDFs"

    if set --query --universal manp_cache_path
        set cache_path $manp_cache_path
    end

    argparse --stop-nonopt h/help C/clear-cache -- $argv

    if set --query _flag_help
        echo 'Usage: '(status function)' --help
       '(status function)' --clear-cache
       '(status function)' [section] [man page]

Opens a macOS man page as a PDF. The generated PDFs are cached
in $manp_cache_path (/private/tmp/man PDFs).

Use --clear-cache to clear the cached PDFs manually. By default
they will be cleared on any OS upgrade.'
        return 0
    end

    if set --query _flag_clear_cache
        /bin/rm -rf $cache_path
        return $status
    end

    set --function man_path (/usr/bin/man -w $argv 2> /dev/null)

    if test -f $man_path
        # Save every man page PDF into a sub-folder for the current OS version
        # (and build) since man pages can be updated between OS versions, and
        # don't want to retrieve an old cached version from a previous OS
        # (when not saving to a temporary location).
        set --local os_path $cache_path"/"(/usr/bin/sw_vers -productVersion)" ("(/usr/bin/sw_vers -buildVersion)")"

        if not test -d $os_path
            # If the man PDFs base path exists, but not the current OS sub-
            # folder, that likely means that there has been an OS update
            # since the last run, so clear the cache of the old man PDFs
            # from the previous OS version by deleting the base path which
            # will be re-created when the new latest OS sub-folder is
            # created below.
            if test -d $cache_path
                /bin/rm -rf $cache_path
            end

            /bin/mkdir -p $os_path
        end

        set --local man_filename (path basename $man_path)
        set --local man_section (path extension $man_filename | string replace . '')
        set man_filename (string replace .$man_section '' $man_filename)

        if test $man_section != 1
            set man_filename $man_filename" ("$man_section")"
        end

        set --local pdf_path $os_path/man" "$man_filename.pdf

        if not test -f $pdf_path
            /usr/bin/mandoc -T pdf $man_path >$pdf_path
        end

        if set --query $manp_pdf_app_name
            /usr/bin/open -af $manp_pdf_app_name $pdf_path
        else
            /usr/bin/open $pdf_path
        end
    else
        /usr/bin/man $argv
    end
end
