function pdfmerge -d 'Merge one or more PDFs'
    # Usage: pdfmerge -o output.pdf input{1,2,3}.pdf
    # Yanked from Mathias Bynens’ dotfiles.

    /System/Library/Automator/Combine\ PDF\ Pages.action/Contents/Resources/join.py $argv
end
