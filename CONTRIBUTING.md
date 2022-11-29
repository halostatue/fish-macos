# Contributing

I value any contribution you can provide—a bug report, a feature request, or
code contributions. When contributing code, please note:

- If tests exist for the project, the test suite should pass. New or changed
  functionality should have tests added. The test suite is written with
  [fishtape][].

- Code style is mostly provided by `fish_indent`. There are a few things not
  covered by `fish_indent`:

  - Where possible, prefer using fish built-ins over external programs like sed
    or awk.

  - For simple conditional execution, prefer `and` or `or`. Avoid chaining
    these conditions and prefer `if` with `&&` or `||` expressions as
    appropriate.

- Use a thoughtfully-named topic branch that contains your change. Rebase your
  commits into logical chunks as necessary.
- Use [quality commit messages][].
- Do not change the version number; when your patch is accepted and a release
  is made, the version will be updated at that point.
- Submit a GitHub pull request with your changes.
- New or changed behaviours require new or updated documentation.

[minitest]: https://github.com/seattlerb/minitest
[quality commit messages]: http://tbaggery.com/2008/04/19/a-note-about-git-commit-messages.html
[fishtape]: https://github.com/jorgebucaran/fishtape
