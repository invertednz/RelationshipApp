param(
  [string]$ProjectId
)

$ErrorActionPreference = "Stop"

$scriptRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
$projectRoot = Join-Path $scriptRoot ".."
Set-Location $projectRoot

if (-not (Get-Command flutter -ErrorAction SilentlyContinue)) {
  Write-Error "Flutter is not installed or not available in PATH."
}

if (-not (Get-Command dart -ErrorAction SilentlyContinue)) {
  Write-Error "Dart is not installed or not available in PATH."
}

dart pub global activate flutterfire_cli

if ($ProjectId) {
  flutterfire configure --project=$ProjectId --platforms=android,ios
} else {
  flutterfire configure --platforms=android,ios
}
