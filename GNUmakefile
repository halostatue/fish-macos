SHELL := /usr/bin/env fish

all: fmt lint install test

fmt:
	@fish_indent --write **.fish

lint:
	@for file in **.fish; fish --no-execute $$file; end

install: fisher
	@fisher install . >/dev/null

fisher:
	@type -q fisher || begin; curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher; end

.PHONY: \
	all \
	fisher \
	fmt \
	install \
	lint
