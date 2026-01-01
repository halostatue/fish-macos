# Contributing

Contribution is encouraged: bug reports, feature requests, or code
contributions. New features should be proposed and discussed in an
[issue][issues].

Before contributing patches, please read the [Licence](./LICENCE.md).

This plugin is governed under the [Contributor Covenant Code of Conduct][cccoc].

## Code Guidelines

I have several guidelines to contributing code through pull requests:

- If tests exist for the project, the test suite should pass. New or changed
  functionality should have tests added. The test suite is written with
  [fishtape][fishtape].

- Code style is mostly provided by `fish_indent`. There are a few things not
  covered by `fish_indent`:

  - Where possible, prefer using fish built-ins over external programs like sed
    or awk.

  - For simple conditional execution, prefer `and` or `or`. Avoid chaining these
    conditions and prefer `if` with `&&` or `||` expressions as appropriate.

- Proposed changes should be on a thoughtfully-named topic branch and organized
  into logical commit chunks as appropriate.

- Use [Conventional Commits][conventional] with my
  [conventions](#commit-conventions).

- Do not change the version number; when your patch is accepted and a release is
  made, the version will be updated at that point.

- Documentation should be added or updated as appropriate for new or updated
  functionality.

- All GitHub Actions checks marked as required must pass before a pull request
  may be accepted and merged.

- Add your name or GitHub handle to `CONTRIBUTORS.md` and a record in the
  `CHANGELOG.md` as a separate commit from your main change. (Follow the style
  in the `CHANGELOG.md` and provide a link to your PR.)

- Include your DCO sign-off in each commit message (see [LICENCE](LICENCE.md)).

## AI Contribution Policy

It is extremely important that contributions of any sort be well understood by
the submitter and that the developer can attest to the
[Developer Certificate of Origin][dco] for each pull request (see
[LICENCE](LICENCE.md)).

Any contribution (bug, feature request, or pull request) that uses undeclared AI
output will be rejected.

## Commit Conventions

This plugin has adopted a variation of the Conventional Commits format for
commit messages. The following types are permitted:

| Type    | Purpose                                               |
| ------- | ----------------------------------------------------- |
| `feat`  | A new feature                                         |
| `fix`   | A bug fix                                             |
| `chore` | A code change that is neither a bug fix nor a feature |
| `docs`  | Documentation updates                                 |
| `deps`  | Dependency updates, including GitHub Actions.         |

I encourage the use of [Tim Pope's][tpope-qcm] or [Chris Beam's][cbeams]
guidelines on the writing of commit messages

I require the use of [git][trailers1] [trailers][trailers2] for specific
additional metadata and strongly encourage it for others. The conditionally
required metadata trailers are:

- `Breaking-Change`: if the change is a breaking change. **Do not** use the
  shorthand form (`feat!(scope)`) or `BREAKING CHANGE`.

- `Signed-off-by`: this is required for all developers except me, as outlined in
  the [Licence](./LICENCE.md#developer-certificate-of-origin).

- `Fixes` or `Resolves`: If a change fixes one or more open [issues][issues],
  that issue must be included in the `Fixes` or `Resolves` trailer. Multiple
  issues should be listed comma separated in the same trailer:
  `Fixes: #1, #5, #7`, but _may_ appear in separate trailers. While both `Fixes`
  and `Resolves` are synonyms, only _one_ should be used in a given commit or
  pull request.

- `Related to`: If a change does not fix an issue, those issue references should
  be included in this trailer.

[cbeams]: https://cbea.ms/git-commit/
[cccoc]: ./CODE_OF_CONDUCT.md
[conventional]: https://www.conventionalcommits.org/en/v1.0.0/
[dco]: licences/dco.txt
[fishtape]: https://github.com/jorgebucaran/fishtape
[hoe]: https://github.com/seattlerb/hoe
[issues]: https://github.com/halostatue/fish-macos/issues
[tpope-qcm]: https://tbaggery.com/2008/04/19/a-note-about-git-commit-messages.html
[trailers1]: https://git-scm.com/docs/git-interpret-trailers
[trailers2]: https://git-scm.com/docs/git-commit#Documentation/git-commit.txt---trailerlttokengtltvaluegt
