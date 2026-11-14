# Publishing

The site is intended for <https://akaish80.github.io/nasa/>. Create a public
GitHub repository named `nasa` under `akaish80` if it does not already exist,
and ensure Git can authenticate with permission to push to it.

Run the following from this folder in PowerShell:

```powershell
.\publish.ps1
```

The script clones the publishing repository, copies `rover.html` to
`index.html` and uploads `narration.mpeg` and `badge.jpg`, then commits and pushes those files
to the repository's default branch. Existing unrelated files are preserved;
the destination's `index.html`, `narration.mpeg`, and `badge.jpg` are replaced.

In the `nasa` repository's **Settings > Pages**, choose **Deploy from a
branch**, select the pushed default branch and the root folder, and save.
GitHub Pages may take a few minutes to publish. Run the script again after
changing the site, narration, or badge image.
