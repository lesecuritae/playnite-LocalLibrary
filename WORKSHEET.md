# LocalLibrary: network installer and update workflow

## Scope

Extend LocalLibrary only. Use stock Playnite with an optional Helium theme.
Target Windows. Sources may be local folders, USB drives, SMB paths, or an
already mounted SFTP filesystem. SSHFS is optional; rclone is not required.
No games, credentials, personal configuration, or original task transcripts
belong in the repository. No package download service or DRM bypass is added.

## Roles and review

Hermes proposes small changes through currently approved free models. Codex
owns admission, code review, independent tests, corrections and integration.
Model output is an untrusted proposal, not an executed command or evidence.
Use isolated source checkouts and disposable test directories. Preserve other
writers' work. No paid API fallback, automatic merge, live deployment or public
publication is admitted by this worksheet alone.

## Stages

1. Pin upstream revision, record current behavior, establish independent tests.
2. Implement numeric target-version ordering, with publication date as a
   secondary key. Version metadata must be explicit; filenames alone do not
   prove compatibility. Unversioned packages remain visible.
3. Associate base installers/ISOs and updates with one game and release.
   Preserve the main installer, manual choices and alternative release bases.
4. Run each reviewed setup with its own source directory; check each outcome,
   stop dependent steps on failure, retain progress and uncertain outcomes.
   Never blindly rerun an installer after a controller crash.
5. Correct ISO ownership/lifecycle: identify the mounted image's actual volume,
   preserve existing mounts, wait for installation completion, unmount only
   media owned by the run. Test actual SMB and SFTP-filesystem behavior.
6. Add cached, bounded xREL metadata lookup, including P2P results. Associate
   exact releases, compare installed and available versions, suppress obsolete
   updates, show missing prerequisites and new-package notices. Distinguish
   announced, present on disk and installed. Do not acquire package payloads.
7. Add clear source-folder onboarding and optional SSHFS instructions, reusable
   packaging, tests and compatibility documentation. Review remote destination
   and sanitized history before a public fork/PR or release.

## Acceptance

Independent fixtures cover numeric ordering (1.9 before 1.10), large build
numbers, missing/malformed versions, deterministic ties, main-installer
preservation, duplicate updates, Unicode paths, missing companion files,
installer failure, interrupted processes and mounts owned by someone else.
Use real Windows smoke tests separately from offline unit tests. A synthetic
installer proves orchestration behavior, not compatibility with every game.
Full plugin build and GUI/network/ISO acceptance are separate gates.

## Learning path

After review and tests, create concise lessons linked to exact source revision,
diff, failure evidence, correction and independent test results. Submit them
to the existing Dreaming intake; do not fabricate a completed Dreaming run.
Only after successful native Dreaming and review through the existing skill
handoff may a lesson enter the coding skill. Keep rejected proposals and
limitations, deduplicate rules and preserve the prior skill digest. No raw
model answer, private prompt or provider credential is skill content.

## Initial status

Upstream base: 3aef5db6af4cd5d28c829d7aaebdae16473fdda1.
Worksheet written. The standalone explicit-metadata version comparer now
compiles with C#5 and passes388 independent Windows checks. It is not yet
wired to discovery or installation. A reviewed lesson is pending native
Dreaming; no coding-skill promotion is claimed.
