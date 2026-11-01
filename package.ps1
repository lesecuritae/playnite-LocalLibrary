param(
    [Parameter(Mandatory=$true)][string]$ToolboxPath,
    [string]$BuildDirectory = (Join-Path $PSScriptRoot 'bin/Release'),
    [string]$OutputDirectory = (Join-Path $PSScriptRoot 'dist')
)
$ErrorActionPreference = 'Stop'
if (-not (Test-Path -LiteralPath $ToolboxPath -PathType Leaf)) { throw 'Playnite Toolbox.exe is required.' }
$files = @('LocalLibrary.dll', 'Newtonsoft.Json.dll', 'Ookii.Dialogs.Wpf.dll', 'extension.yaml', 'icon.png')
foreach ($name in $files) {
    if (-not (Test-Path -LiteralPath (Join-Path $BuildDirectory $name) -PathType Leaf)) { throw "Missing built runtime file: $name" }
}
$staging = Join-Path ([IO.Path]::GetTempPath()) ('locallibrary-package-' + [guid]::NewGuid().ToString('N'))
New-Item -ItemType Directory -Path $staging | Out-Null
try {
    foreach ($name in $files) { Copy-Item -LiteralPath (Join-Path $BuildDirectory $name) -Destination $staging }
    New-Item -ItemType Directory -Force -Path $OutputDirectory | Out-Null
    $start = New-Object Diagnostics.ProcessStartInfo
    $start.FileName = [IO.Path]::GetFullPath($ToolboxPath)
    $start.Arguments = 'pack "' + $staging + '" "' + [IO.Path]::GetFullPath($OutputDirectory) + '"'
    $start.WorkingDirectory = Split-Path -Parent $start.FileName
    $start.UseShellExecute = $false
    $start.CreateNoWindow = $true
    $start.RedirectStandardOutput = $true
    $start.RedirectStandardError = $true
    $process = New-Object Diagnostics.Process
    $process.StartInfo = $start
    try {
        $null = $process.Start()
        if (-not $process.WaitForExit(60000)) { $process.Kill(); $process.WaitForExit(); throw 'Playnite Toolbox packaging timed out.' }
        $toolOutput = $process.StandardOutput.ReadToEnd() + $process.StandardError.ReadToEnd()
        Write-Output $toolOutput.Trim()
        if ($process.ExitCode -ne 0) { throw ("Playnite Toolbox packaging failed: " + $toolOutput) }
    } finally { $process.Dispose() }
    $manifest = [IO.File]::ReadAllText((Join-Path $staging 'extension.yaml'))
    $id = [regex]::Match($manifest, '(?m)^Id:\s*(\S+)\s*$').Groups[1].Value
    $version = [regex]::Match($manifest, '(?m)^Version:\s*(\S+)\s*$').Groups[1].Value.Replace('.', '_')
    if (-not $id -or -not $version) { throw 'The built extension manifest must have an Id and Version.' }
    $package = Join-Path $OutputDirectory ($id + '_' + $version + '.pext')
    if (-not (Test-Path -LiteralPath $package -PathType Leaf)) { throw ("Expected .pext package was not produced: " + $package + "; output files: " + ((Get-ChildItem -LiteralPath $OutputDirectory -File | ForEach-Object { $_.Name }) -join ', ')) }
    Get-FileHash -LiteralPath $package -Algorithm SHA256
} finally {
    foreach ($name in $files) {
        $path = Join-Path $staging $name
        if (Test-Path -LiteralPath $path) { Remove-Item -LiteralPath $path }
    }
    if (@(Get-ChildItem -Force -LiteralPath $staging).Count -eq 0) { Remove-Item -LiteralPath $staging }
}
