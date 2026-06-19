param(
    [switch] $ReviewPack
)

$ErrorActionPreference = 'Stop'

$workspaceRoot = Split-Path -Parent $PSScriptRoot
$required = @(
    'AGENTS.md',
    'v2',
    'адоны'
)

if (-not $ReviewPack) {
    $required += 'ModdingDocuments'
}

$missing = @(
    foreach ($item in $required) {
        $path = Join-Path $workspaceRoot $item
        if (-not (Test-Path -LiteralPath $path)) {
            $item
        }
    }
)

if ($missing.Count -gt 0) {
    throw "Resolved workspace root looks incomplete: $workspaceRoot; missing: $($missing -join ', ')"
}

[pscustomobject] [ordered]@{
    WorkspaceRoot = $workspaceRoot
    IsReviewPack = [bool] $ReviewPack
    V2 = $PSScriptRoot
    Addons = Join-Path $workspaceRoot 'адоны'
    ModdingDocuments = if ($ReviewPack) { $null } else { Join-Path $workspaceRoot 'ModdingDocuments' }
}
