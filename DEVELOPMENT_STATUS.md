# Network/update extension status

This is an isolated development branch, not a published fork or release.
Upstream base: `3aef5db6af4cd5d28c829d7aaebdae16473fdda1`.

## Implemented and checked

Update discovery now uses explicit numeric target-version metadata, followed
by filesystem modification time as a fallback and deterministic path ties.
The timestamp is not an authoritative release publication date. The bounded
folder scanner refuses incomplete or ambiguous installer selections and does
not follow directory reparse points. Existing actions, manual arguments,
working directories, main installers and offline source links are retained.
Filename hints do not prove update compatibility.

The Local Library game menu includes `Link existing installation...` for one
selected game owned by this plugin. Choose the existing installation folder
and its executable. The helper adds or reuses a launch action, marks the game
installed, and retains its source installer, identity, playtime and artwork.
It does not run an installer or move/delete game files. This is an explicit
link operation; automatic cross-plugin duplicate merging is not implemented.
Playnite's normal folder scanning and manual executable import remain useful
for adding games which have no existing source card.

Five Windows fixture suites passed 569 assertions: comparer388, metadata124,
discovery22, existing-installation linking23, and actual-plugin workflow12.
The linking suite uses real Playnite SDK game/action objects. It covers
relinking without duplicate actions, existing launch arguments, nested game
executables, absent actions, empty/missing paths, wrong extensions, drive-root
selection and same-prefix sibling directories. Rejected selections retain the
existing action collection. Path containment is lexical; final filesystem
junction identity is not established by these checks.

The complete Release plugin and the checked-in build recipe both built on
Windows, targeting .NET Framework4.6.2 / MSIL. The five fixtures compile with
C#5. See tests/README.md for inputs, commands and build prerequisites. These
are executed assertions, not569 game installations. Discovery/link fixtures
use text placeholder executables which are never launched.

## Supervised free-model work

Native Hermes used existing configured free NIM routes without a paid
fallback. Two Lightning code proposals failed C#5 compilation. Codex corrected
an initial baseline. An Ultra comparer proposal then passed the same388
checks without C# source corrections; its JSON packaging needed manual
normalization. Two later Ultra parser proposals compiled but failed metadata
checks. The supervisor corrected the parser and integrated discovery/linking.
This is evidence for supervised coding tasks, not autonomous implementation
or general model quality. Original proposals and failure receipts are private
operator evidence and are not included in this source repository.

One source/test-bound lesson was admitted to native Dreaming as pending
review. Successful Dreaming processing and transfer into the coding skill
have not been verified; no completed transfer is claimed.

## Remaining release gates

Interactive Playnite/Helium UI, database persistence/restart and actual game
launch tests remain open. The folder/link fixtures do not establish SMB or
mounted-SSHFS behavior on another client. Real network ISO mounting and owned
mount cleanup remain untested. The existing installer batch workflow still
needs replacement with reviewed per-step execution and retained uncertain
outcomes; do not enable unattended installer chains from this branch.

xREL metadata lookup, installed-version/prerequisite filtering, obsolete-update
suppression, notifications and distributable packaging remain worksheet work.
Source URLs, sanitized history and the destination remote require review
before publication. No public fork/PR, release or deployment has occurred.
