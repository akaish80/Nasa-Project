# Publishing

The site is intended for <https://akaish80.github.io/nasa/>.

## Publish with GitHub Actions

In the `akaish80/nasa` repository, set **Settings > Pages > Source** to
**GitHub Actions**. Add `.github/workflows/publish.yml` to the repository's
`main` branch, along with the latest `rover.html`, `narration.mpeg`, and
`badge.jpg`. You can upload the site files using GitHub's web interface and
create the workflow there using its full path.

The workflow publishes automatically when `main` changes. To run it manually,
open **Actions > Publish site > Run workflow** and select `main`. Check the
workflow run for errors; GitHub Pages may take a few minutes to update.
GitHub Actions uses the files in the repository, so upload or push local
changes before running it.

## Publish with PowerShell

Alternatively, ensure Git can authenticate with permission to push to the
`akaish80/nasa` repository.

Run the following from this folder in PowerShell:

```powershell
.\publish.ps1
```

The script clones the publishing repository, copies `rover.html` to
`index.html` and uploads `narration.mpeg` and `badge.jpg`, then commits and pushes those files
to the repository's default branch. Existing unrelated files are preserved;
the destination's `index.html`, `narration.mpeg`, and `badge.jpg` are replaced.

For branch-based deployment, choose **Deploy from a branch** under
**Settings > Pages**, select the pushed default branch and the root folder,
and save. Run the script again after changing the site, narration, or badge
image.
