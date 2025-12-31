# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a personal academic portfolio website built with Jekyll and hosted on GitHub Pages. It's based on the Academic Pages template (forked from Minimal Mistakes Jekyll Theme). The site showcases publications, personal projects, and a CV.

## Local Development Commands

### Initial Setup
```bash
# Install Ruby dependencies
bundle install

# If permission errors occur, install gems locally:
bundle config set --local path 'vendor/bundle'
bundle install
```

### Running the Site Locally

**Quick Start (Windows):**
```bash
# Double-click serve.bat or run from command line
serve.bat
```
This will automatically start the Jekyll server and open your browser to http://localhost:4000

**Manual Start:**
```bash
# Standard method - serves at http://localhost:4000
jekyll serve -l -H localhost

# Alternative method (ensures specific dependencies are used)
bundle exec jekyll serve -l -H localhost
```

The `-l` flag enables live reload, and the server will automatically rebuild and refresh on file changes. You must restart the server if you modify `_config.yml`.

### Using Docker
```bash
# Build and run with Docker Compose
docker compose up
```

Access the site at http://localhost:4000

## Site Architecture

### Configuration System
- **_config.yml**: Main site configuration containing:
  - Site-wide settings (title, description, URL)
  - Author profile information (name, email, social links)
  - Jekyll collections: `publications` and `personal_projects`
  - Publication categories: books, manuscripts, conferences, out_blogs
  - Theme settings (currently set to "dark")

- **_data/navigation.yml**: Top navigation menu structure

### Content Collections

Jekyll collections are the core content organization system:

1. **Publications** (`_publications/`)
   - Each `.md` file represents a publication
   - Front matter fields: `title`, `collection`, `category`, `permalink`, `date`, `venue`, `link`
   - Categories defined in `_config.yml`: books, manuscripts, conferences, out_blogs
   - Displayed on `/publications/` page

2. **Personal Projects** (`_personal_projects/`)
   - Each `.md` file represents a project
   - Front matter fields: `title`, `excerpt`, `collection`
   - Can include embedded HTML/CSS/JavaScript for interactive visualizations
   - Displayed on `/personal_projects/` page

3. **Pages** (`_pages/`)
   - Static pages like About, CV, 404
   - `about.md` is the homepage (permalink: `/`)
   - `cv.md` uses Liquid templating to dynamically include publications

### Layout and Templating

- **_layouts/**: Page layout templates
  - `default.html`: Base layout
  - `single.html`: Used for publications and projects (with author profile sidebar)
  - `archive.html`: Used for listing pages
  - `cv-layout.html`: Custom CV layout

- **_includes/**: Reusable template components
  - `author-profile.html`: Sidebar profile display
  - `archive-single.html`: Single item in archive listings
  - `archive-single-cv.html`: CV-specific publication formatting
  - `masthead.html`: Top navigation bar
  - `footer.html`: Site footer

### Styling
- **_sass/**: Sass stylesheets
- **assets/**: Compiled CSS and JavaScript files
- Dark theme is configured via `site_theme: "dark"` in `_config.yml`

### Content Management

**Static Files:**
- `files/`: PDFs and other downloadable files
- `images/`: Site images including `profile.png` for author avatar

**Generated Content:**
- `markdown_generator/`: Jupyter notebooks and Python scripts to generate markdown files from TSV data
  - `publications.ipynb` / `publications.py`: Generate publication pages from `publications.tsv`
  - `talks.ipynb` / `talks.py`: Generate talk pages from `talks.tsv`

## Important Patterns

### Adding New Publications

Create a new `.md` file in `_publications/` with this structure:
```yaml
---
title: "Publication Title"
collection: publications
category: manuscripts  # or books, conferences, out_blogs
permalink: /publication/YYYY-MM-DD-slug
date: YYYY-MM-DD
venue: 'Venue Name'
link: 'https://url-to-publication'
---
Optional description text here.
```

### Adding New Personal Projects

Create a new `.md` file in `_personal_projects/` with:
```yaml
---
title: "Project Title"
excerpt: "Brief description"
collection: personal_projects
---
Project content here. Can include HTML, CSS, and JavaScript.
```

### Updating Navigation

Edit `_data/navigation.yml` to add/remove/reorder top navigation links.

### Modifying Author Profile

Edit the `author:` section in `_config.yml` to update:
- Name, location, employer, email
- Social media links (GitHub, LinkedIn, etc.)
- Avatar image (stored in `images/`)

### CV Updates

The CV page (`_pages/cv.md`) uses Liquid templating:
- Static content is written in Markdown
- Publications are dynamically included via `{% for post in site.publications reversed %}`
- Edit the markdown directly for experience, education, and skills sections

### Adding JavaScript to Projects

**CRITICAL: Inline JavaScript breaks on GitHub Pages**

Jekyll's Liquid template engine processes markdown files and will **escape square brackets** in inline `<script>` tags, converting `array[index]` to `array\[index\]`, which causes syntax errors.

**Solution: Use external JavaScript files**

1. Create a `.js` file in `assets/js/` (e.g., `assets/js/my-script.js`)
2. Write your JavaScript code normally in this file
3. In your markdown file, reference it with:
   ```html
   <script src="{{ '/assets/js/my-script.js' | relative_url }}"></script>
   ```

**Why this works:**
- External `.js` files are not processed by Jekyll's Liquid template engine
- The JavaScript code remains unchanged and executes properly on GitHub Pages
- The `relative_url` filter ensures the path works correctly in all environments

**Example:**
See `_personal_projects/random-walk-visualizer.md` and `assets/js/random-walk.js` for a working implementation of an interactive Canvas-based visualization.

**What NOT to do:**
- Do NOT embed JavaScript directly in markdown files using `<script>` tags
- Do NOT use `{% raw %}` tags - they don't fully prevent processing
- Do NOT try to escape the brackets manually

## Jekyll-Specific Notes

- Collections are defined in `_config.yml` under the `collections:` key
- Default values for collection items are set in the `defaults:` section
- The site uses Jekyll plugins: jekyll-feed, jekyll-sitemap, jekyll-redirect-from, jemoji
- Changes to `_config.yml` require a server restart
- Changes to other files auto-reload with the `-l` flag

## GitHub Pages Deployment

The site is automatically built and deployed by GitHub Pages when changes are pushed to the repository. No manual build step is required for deployment.
