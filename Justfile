base := "@halostatue/fish-macos"

set shell := ['fish', '-c']

_list:
    @just --list

# Ensure that all `.fish` files have comment-version tags
prepare version:
    #!/usr/bin/env fish

    if ! string match -rq '^[0-9.]+$' '{{ version }}'
        echo >&2 "Invalid version {{ version }}"
        exit 1
    end

    if ! string match -rq '## {{ version }}' <CHANGELOG.md
        echo >&2 "Version {{ version }} is not mentioned in the changelog."
        exit 1
    end

    for file in **.fish
        if ! string match -rq "^# {{ base }}/$file" <$file
            sed -i '' -e "1i\\
    # {{ base }}/$file:v{{ version }}

    " $file
        end

        sed -i '' \
          -e 's!'$file'$!'$file':v{{ version }}!' \
          -e 's!'$file':v[0-9.]*$!'$file':v{{ version }}!' $file
    end

# Apply a git tag for the version
tag version:
    #!/usr/bin/env fish

    if ! string match -rq '^[0-9.]+$' '{{ version }}'
        echo >&2 "Invalid version {{ version }}"
        exit 1
    end

    if ! string match -rq '## {{ version }}' <CHANGELOG.md
        echo >&2 "Version {{ version }} is not mentioned in the changelog."
        exit 1
    end

    for file in **.fish
        if ! string match -rq ':v{{ version }}$' <$file
            echo >&2 "File $file is not tagged with version {{ version }}."
            exit 1
        end
    end

    if string match -rq -- '-dirty' (git describe --dirty)
        echo >&2 "Uncommitted changes are present."
        exit 1
    end


    git tag v{{ version }}

    echo "Remember to update the major and minor version tags."

# Format fish files
fmt:
    @fish_indent --write **.fish

# Lint fish files
lint:
    #! /usr/bin/env fish

    for file in **.fish
      fish --no-execute $file
    end

# Run tests
test: _install-clownfish _install-fishtape
    @fishtape tests/**.test.fish

_install-fisher:
    @type -q fisher || begin; curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher; end

_install-clownfish: _install-fisher
    @type -q mock || fisher install IlanCosman/clownfish

_install-fishtape: _install-fisher
    @type -q fishtape || fisher install jorgebucaran/fishtape
