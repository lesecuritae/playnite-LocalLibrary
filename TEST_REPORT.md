# Preview acceptance report

Version:1.9.1.0 (preview). Application implementation commit:a819332.
The release tag pins the exact full source and packaging revision.

The complete plugin built on Windows, .NET Framework4.6.2, MSIL, using
Microsoft.Net.Compilers.Toolset4.8.0 and the net462 reference pack1.0.3.
`tests/run-all-tests.ps1` compiled and executed all five suites on Windows:

| Suite | Passed assertions |
|---|---:|
| Numeric update comparer | 388 |
| Release metadata parser | 124 |
| Source discovery and ordering | 22 |
| Existing installation linking, real Playnite SDK objects | 23 |
| Actual compiled-plugin update workflow | 12 |
| Total | 569 |

No actual game or setup executable was launched. Source fixtures contain text.
The workflow tests load the real plugin and SDK, not a substitute implementation.

Packaging used the official Playnite10.63 Toolbox. The release archive was
verified for ZIP integrity, manifest version, an exact four-file runtime
allowlist and matching DLL hash. Toolbox excludes host-provided Newtonsoft.Json
using its distributed reference ignore list; Playnite.SDK is not included.
No tests, source fixtures, credentials or operator handoffs are in the package.

Playnite10.63 tool archive SHA256:
`9af9a0db330c97879697beac9f819c16f9f544e712261a83fa4e62a8f9a2c787`.
The downloaded archive was checked against the GitHub release digest.
Packaged plugin DLL SHA256:
`5c6437bb1fc112cd09b24435f3a4f6f01396c7932c99e252094f933fcd52e005`.
Package SHA256:
`128d7f6409d5c2d51e0f717e9a20ec126fbdc70fbbde61dd15720eec41dd0736`.

The initial packaging fixture omitted Toolbox's reference ignore list and
failed. After restoring that official dependency, a malformed regex in the new
packaging script failed the package-existence check. Both failures were
retained and corrected before the successful packaging run. The final script
waits for the specific Toolbox process and validates its exit and artifact.

Open: interactive Playnite UI, library persistence/restart, real game launch,
SMB/SSHFS ISO mounting, failure/crash-safe installer chains, xREL lookup,
prerequisite checking and obsolete-update filtering. This release does not
claim those acceptance gates or unattended installer readiness.
