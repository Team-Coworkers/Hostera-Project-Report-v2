# Hostera — Team Coworkers Report

Academic report repository for **Team Coworkers Startup** and its hotel-management product, **Hostera**.

The complete GitHub-Flavored Markdown report is available in [`README.md`](../README.md), the main report file required by the project statement. Images used by the report are stored in [`assets/`](../assets/). The project is distributed under the [MIT License](../LICENSE.md).

## Repository structure

```text
.
├── assets/       # Images referenced by the report
├── docs/         # Repository guide and supporting artifacts
├── README.md     # Main report in GitHub-Flavored Markdown
├── scripts/      # Utility scripts
├── CHANGELOG.md
└── LICENSE.md
```

## Install Pandoc

Pandoc is the command-line document converter used to generate the PDF.

### Ubuntu / Debian

```bash
sudo apt update
sudo apt install pandoc
```

### Windows

Install the official Pandoc installer from [pandoc.org/installing](https://pandoc.org/installing.html), or use Windows Package Manager:

```powershell
winget install --source winget --exact --id JohnMacFarlane.Pandoc
```

### macOS

Using Homebrew:

```bash
brew install pandoc
```

Verify the installation on any operating system:

```bash
pandoc --version
```

## Install the PDF engine

The PDF script uses **WeasyPrint** as Pandoc's PDF engine. This is intentional because the report contains HTML image elements and WeasyPrint preserves those local assets when rendering the document.

Install WeasyPrint using one of these methods:

```bash
# Ubuntu / Debian
sudo apt install weasyprint

# Windows
py -m pip install weasyprint

# macOS
python3 -m pip install weasyprint
```

Verify it with:

```bash
weasyprint --version
```

## Generate the PDF

From the repository root, run:

```bash
bash scripts/build-pdf.sh
```

The script creates `report.pdf` in the repository root. It resolves the report and `assets/` paths relative to the repository, so it can also be run from another directory:

```bash
bash /path/to/hostera-report/scripts/build-pdf.sh
```

To choose a different output path:

```bash
bash scripts/build-pdf.sh output/hostera-report.pdf
```

The input format is GitHub-Flavored Markdown (`gfm`), and the script passes the repository root as Pandoc's resource path so local images remain available during PDF generation.

## Git workflow

This repository follows Git Flow conventions:

- `main`: production and release history
- `develop`: integration branch
- `feature/*`: feature work
- `release/*`: release preparation

