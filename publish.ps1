param(
    [string]$Repository = "https://github.com/akaish80/nasa.git"
)

$ErrorActionPreference = "Stop"
$sourceDirectory = $PSScriptRoot
$siteFiles = @("rover.html", "narration.mpeg", "badge.jpg")

foreach ($file in $siteFiles) {
    if (-not (Test-Path -LiteralPath (Join-Path $sourceDirectory $file) -PathType Leaf)) {
        throw "Required site file not found: $file"
    }
}

$checkout = Join-Path ([System.IO.Path]::GetTempPath()) ("nasa-publish-" + [guid]::NewGuid().ToString("N"))
try {
    git clone -- $Repository $checkout
    if ($LASTEXITCODE -ne 0) { throw "Could not clone the publishing repository." }

    Copy-Item -LiteralPath (Join-Path $sourceDirectory "rover.html") -Destination (Join-Path $checkout "index.html")
    Copy-Item -LiteralPath (Join-Path $sourceDirectory "narration.mpeg") -Destination (Join-Path $checkout "narration.mpeg")
    Copy-Item -LiteralPath (Join-Path $sourceDirectory "badge.jpg") -Destination (Join-Path $checkout "badge.jpg")

    git -C $checkout add -- index.html narration.mpeg badge.jpg
    if ($LASTEXITCODE -ne 0) { throw "Could not stage site files." }

    $changes = git -C $checkout status --porcelain -- index.html narration.mpeg badge.jpg
    if ($LASTEXITCODE -ne 0) { throw "Could not check site changes." }

    if ($changes) {
        git -C $checkout commit -m "Publish NASA rover site" -m "Co-authored-by: Copilot <223556219+Copilot@users.noreply.github.com>" -- index.html narration.mpeg badge.jpg
        if ($LASTEXITCODE -ne 0) { throw "Could not commit site files." }
    } else {
        Write-Host "Site files are already up to date."
    }

    git -C $checkout push -u origin HEAD
    if ($LASTEXITCODE -ne 0) { throw "Could not push the site to the publishing repository." }
    Write-Host "Pushed site files. GitHub Pages must be enabled for the pushed branch."
} finally {
    if (Test-Path -LiteralPath $checkout) {
        Remove-Item -LiteralPath $checkout -Recurse -Force
    }
}
