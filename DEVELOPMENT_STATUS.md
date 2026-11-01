# Network/update extension status

This is an isolated development branch, not a published fork or release.
Upstream base: `3aef5db6af4cd5d28c829d7aaebdae16473fdda1`.

The first component is a standalone comparer for explicit update metadata.
It orders numeric target versions without integer overflow, publication dates
after equal versions, and paths ordinally for deterministic ties. Missing
versions/dates and null records have explicit ordering. It does not infer
release compatibility, discover packages or alter installed games.

Independent Windows acceptance compiled the helper with C#5 and passed 388
checks. Run the same standalone acceptance from PowerShell:

```powershell
powershell -NoProfile -ExecutionPolicy RemoteSigned -File tests/run-comparer-tests.ps1
```

The policy setting above applies to that process only. The test runner uses
an owned temporary directory and does not install games or change networking.
Its assertions include numeric component examples, long build identifiers,
missing/malformed metadata, deterministic ties, culture independence,
antisymmetry and transitivity. These are 388 checks, not 388 game installs.

Actual native Hermes runs through an approved free NIM route returned two
code proposals. Both failed the independent C#5 compilation gate; the
supervisor corrected the implementation before acceptance. Therefore this
trial demonstrates supervised proposal/review/correction, not autonomous
model implementation success. Failed proposals remain in private operator
evidence and are not packaged with the extension.

The comparer is included in the project but not yet wired to update discovery
or installation. Full plugin build, GUI, SMB/SSHFS ISO mounting, installer
lifecycle, xREL integration and packaging remain open worksheet stages.
No source, build or test result here authorizes automatic installation or
public publication. Existing Playnite integrations and theme are unchanged.
