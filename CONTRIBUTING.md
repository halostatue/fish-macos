# Contributing

Contribution is encouraged: bug reports, feature requests, or code
contributions. When contributing code, please note:

- If tests exist for the project, the test suite should pass. New or changed
  functionality should have tests added. The test suite is written with
  [fishtape][fishtape].

- Code style is mostly provided by `fish_indent`. There are a few things not
  covered by `fish_indent`:

  - Where possible, prefer using fish built-ins over external programs like sed
    or awk.

  - For simple conditional execution, prefer `and` or `or`. Avoid chaining these
    conditions and prefer `if` with `&&` or `||` expressions as appropriate.

- Use a thoughtfully-named topic branch that contains your change. Rebase your
  commits into logical chunks as necessary.
- Use [quality commit messages][qcm].
- Do not change the version number; when your patch is accepted and a release is
  made, the version will be updated at that point.
- Submit a GitHub pull request with your changes.
- New or changed behaviours require new or updated documentation.

## LLM-Generated Contribution Policy

It is extremely important that any issues or pull requests be well understood by
the submitter and that, especially for pull requests, the developer can attest
to the [Developer Certificate of Origin][dco] for each pull request (see
[LICENCE](LICENCE.md)).

If LLM assistance is used in writing pull requests, this must be documented in
the commit message and pull request. If there is evidence of LLM assistance
without such declaration, the pull request **will be declined**.

Any contribution (bug, feature request, or pull request) that uses unreviewed
LLM output will be rejected.

[dco]: licences/dco.txt
[fishtape]: https://github.com/jorgebucaran/fishtape
[qcm]: http://tbaggery.com/2008/04/19/a-note-about-git-commit-messages.html
[standardrb]: https://github.com/standardrb/standard
