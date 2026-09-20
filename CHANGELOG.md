# ChangeLog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/) and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.21.0] - 2026-09-19

### Removed

- Removed the five Figma links from the report. The design file is private: an anonymous visitor gets a sign-in wall instead of the prototype, so the links were not usable as evidence. The wireflows keep their 25 captures, and the prototype keeps its video-frame capture and its Microsoft Stream recording, both publicly reachable. The reference column of the Figma row in the tools table now carries an em dash, as the UXPressia row already did.

## [0.20.0] - 2026-09-19

### Fixed

- Repointed the project repository link in the cover section to `Hostera-Project-Report-v2`. It still pointed to `Team-Coworkers/Hostera-Project-Report`, which no longer exists and returned a 404 from the most visible link in the report.

## [0.19.0] - 2026-09-19

### Changed

- Replaced the first interview of the first segment with Dominguez, administrator of an independent hotel in Lima, including his portrait, recording link, timestamps and summary.
- Rewrote the section 2.2.3 analysis for the first segment from that interview.

### Fixed

- Repointed the project repository link in the cover section to `Hostera-Project-Report-v2`. It still pointed to `Team-Coworkers/Hostera-Project-Report`, which no longer exists and returned a 404 from the most visible link in the report.



## [0.18.0] - 2026-09-19

### Fixed

- Corrected section 5.2.1.8, which still summarised "the 20 commits" and split them 3/5/3/5/4 per member. The evidence table records 28 commits, and their real distribution, read from the GitHub API, is 6/6/6/5/5. All 28 were verified to be non-merge commits.
- Replaced the per-member attribution of whole User Stories with the branches each member actually committed to. Every one of the eleven Epic 1 branches carries commits from more than one member, so the previous one-story-per-person split did not match the repository.
- Corrected section 5.2.1.2, which described the 18-to-24 range out of 106 as Story Points. Those figures are the estimated hours of the 20 Sprint 1 work-items; the eight User Stories of Epic 1 sum 42 Story Points, the committed velocity. The numbers were right, the unit was not.

### Changed

- Recaptured the AV1 collaboration evidence from `Team-Coworkers/Hostera-Project-Report-v2`, so the commit history shows contributions from more than one member and the contributor analytics show the current counts for the five of them.

## [0.17.0] - 2026-09-19

### Changed

- Migrated the project tracking from the retired `jqcuba.youtrack.cloud` instance to the team instance at `santanapromaster.youtrack.cloud`, project `HOS`.
- Rebuilt the tracker from the report itself: 8 epics, 33 user stories, 17 technical stories and the 20 Sprint 1 work-items, with their story points, states, assignees and the epic and story hierarchy. The retired instance held only 9 of these 78 items and assigned four of them to members who left the team.
- Pointed the Product Backlog reference to the full issue list and the remaining three references to the Sprint 1 agile board.
- Replaced the two YouTrack screenshots, which until now were the same file used for both figures: figure 3.3 is the issue list of the 78 backlog items and figure 5.2 is the Sprint 1 agile board.
- Corrected the figure 5.2 note, which described the capture as taken during the sprint although it shows the board at sprint close.

## [0.16.0] - 2026-09-19

### Changed

- Linked the Roy Rios interview recording, replacing the plain file name with its SharePoint URL.

## [0.15.0] - 2026-09-19

### Changed

- Moved the Roy Rios interview from the first segment to the second, where it belongs: he manages a chain hotel, not an independent one. Registered as the third interview of that segment and added to its analysis.
- Restored the previous first-segment interview and its analysis, which the earlier replacement had removed.
- Renumbered the chapter 2 figures from 2.6 onwards so the sequence stays correlative after the new entry.

## [0.14.0] - 2026-09-19

### Changed

- Replaced the first interview of the first segment with Roy Rios, deputy manager of an Accor chain hotel in Trujillo, including his portrait, timestamps and summary.
- Rewrote the section 2.2.3 analysis for the first segment from the new interview, writing the blocks the recording does not state directly as analysis derived from the difficulties, tools and adoption criteria it does cover.

## [0.13.0] - 2026-09-19

### Changed

- Recaptured the AV1 collaboration evidence from `Team-Coworkers/Hostera-Project-Report-v2`, replacing the analytics and commit history that still showed the retired repository.
- Described the report releases generically in the AV1 collaboration section, since the recaptured history no longer shows release `v0.3.0`.

### Fixed

- Corrected the `JhosBy2005` username casing in the AV1 collaboration section.

## [0.12.0] - 2026-09-19

### Changed

- Recaptured the Sprint 1 contributors analytic and commit history from `Team-Coworkers/landing-page-main`, replacing the figures 5.6 and 5.7 that still showed the retired repository.

## [0.11.0] - 2026-09-19

### Changed

- Recaptured the GitHub Pages deployment evidence from `Team-Coworkers/landing-page-main`, replacing the screenshot that still showed the retired repository in sections 5.1.4 and 5.2.1.7.

## [0.10.0] - 2026-09-19

### Added

- Added the third interview of the first target segment to the interview registry: Odar Fernando Quispe Salazar, Operations Manager of a three-property boutique hotel chain, with its screenshot, recording link, timestamps and summary.

### Changed

- Renumbered the chapter 2 figures from 2.3 onwards so the sequence stays correlative after the new interview entry.
- Updated the team roster in the landing page wireframes and mock-ups so the artefacts show the five engineers published on the landing page, replacing Mateo Condori with Mateo Leon and Joaquin Cuba with Jose Rudas.

## [0.9.0] - 2026-09-19

### Changed

- Replaced the legacy Grafo Verde copyright line with `© 2026 Team Coworkers` in the landing page wireframes and mock-ups, for both the desktop and the mobile artefacts.

## [0.8.0] - 2026-09-19

### Changed

- Pointed every repository reference to the Team Coworkers repositories in use: `landing-page-main` for the Landing Page and `Hostera-Project-Report-v2` for this report.
- Updated the published Landing Page URL to `https://team-coworkers.github.io/landing-page-main/`.
- Renamed the shared design source file reference to `Team-Coworkers` in the Wireflows and Web Application mock-up sections.
- Rebuilt the Sprint 1 development evidence table with the 28 implementation commits that exist in `landing-page-main`, replacing the 20 rows that referenced the retired repository.
- Recaptured the Sprint 1 execution screenshots from the current deployment.

## [0.7.0] - 2026-09-19

### Changed

- Updated the course identity to Diseño de aplicaciones Open Source (`1ASI0729`), NRC `7737`, taught by Ivan Robles Fernández.
- Aligned the documented technology stack and conventions with Angular and TypeScript for the frontend and Spring Boot and Java for the Web Services.
- Replaced the Vue, Vite, C# and ASP.NET Core bibliography entries with official sources for the required stack.

## [0.6.0] - 2026-09-19

### Changed

- Replaced the former participants with the current five team members across the version registry, the collaboration insights, the Student Outcome, the Sprint 1 planning attendees, the leadership and collaboration matrix, the sprint backlog and the sprint contribution summary.
- Rebalanced the Sprint 1 aspects by story points so the workload per member ranges from 18 to 24 points out of 106, instead of the previous 8 to 48 spread.
- Updated the landing-page team references so the product content names the current team.

## [0.5.0] - 2026-09-19

### Added

- Added `docs/repository-guide.md` with the repository overview, the PDF toolchain instructions, and the Git workflow notes previously kept in the root readme.
- Added the participant photographs for Leon Naupari and Rudas Chavarria, completing the team member profiles required by the project statement.

### Changed

- Renamed the report file to `README.md` so the repository exposes the main report file required by the project statement, and pointed `scripts/build-pdf.sh` to the new input.
- Renamed the startup to Team Coworkers across the report, the repository guide, the changelog, and the Structurizr workspace.
- Pointed the team repository reference to the Team Coworkers organization.
- Updated `.git-allowed-users` to the current team composition.
- Replaced the participant photographs with the current portraits and stored them as optimized JPEG files, reducing the profile images in `assets/chapter-1` from about 70 MB to under 330 KB.

### Removed

- Removed the profile images of the participants who are no longer part of the team.

## [0.3.0] - 2026-09-17

### Added

- Added the Project Report Collaboration Insights section for AV1, including the project repository link, the collaborative-work description, and GitHub evidence.
- Added the GitHub Contributors and commit-history screenshots used as collaboration evidence for the report.

### Changed

- Updated the collaboration section to reference the `v0.3.0` release and the renamed GitHub repository.

## [0.2.0] - 2026-09-17

### Added

- Added the Hostera project documentation for the solution profile, target segments, competitor analysis, interviews, personas, empathy maps, user journeys, Big Picture EventStorming, and impact mapping.
- Added landing-page, web-application, and RESTful Web Service user stories, product-backlog evidence, and general epic scenarios.
- Added the Hostera design system, information architecture, wireframes, wireflows, mock-ups, user flows, and responsive interaction guidelines.
- Added software architecture artifacts, including context, container, component, class, and database diagrams, together with the Structurizr DSL source.
- Added Software Configuration Management documentation covering the toolset, Git Flow source-code management, and source-code style conventions.
- Added Sprint 1 planning, leadership, backlog, development, execution, deployment, services scope, and collaboration evidence.
- Added GitHub Pages deployment evidence, repository collaboration analytics, landing-page implementation evidence, conclusions, roadmap recommendations, AV1 Student Outcome evidence, completed team profiles, and report annexes.
- Added the chapter assets required to support the new report sections and figures.

### Changed

- Expanded the report from the initial scaffold into the cumulative Hostera project report and updated its table of contents, version history, and section structure.
- Updated the report cover, figure numbering, table formatting, labels, interview details, impact-mapping content, and database-design presentation.
- Documented the Sprint 1 Landing Page implementation and its publication from `main` through GitHub Pages.

### Fixed

- Fixed missing EventStorming section numbering, the US003 independent-hotel pathway description, and table-formatting issues.
- Fixed report presentation inconsistencies in figure captions, image references, and section formatting.

## [0.1.1] - 2026-09-03

### Added

- Added repository documentation with installation and PDF-generation instructions.
- Added the PDF build script and its rendering stylesheet.
- Added the MIT license.

### Changed

- Updated the report cover and version-history layout for PDF output.
- Configured the PDF workflow to preserve images from the `assets/` directory.

### Fixed

- Fixed profile-image sizing inside report tables.
- Fixed table borders and PDF page layout.

## [0.1.0] - 2026-09-03

### Added

- Added the initial course report scaffold for the Hostera project.
- Added the UPC logo used on the report cover.
- Added the initial participant profile images for the team member profiles section.
- Added the Team Coworkers startup description and the Hostera solution overview.

### Changed

- None
