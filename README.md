# William J. Zeng's Personal Website

Personal academic portfolio website built with Jekyll and hosted on GitHub Pages. Based on the [Academic Pages template](https://github.com/academicpages/academicpages.github.io).

**Live Site:** [https://williamjzeng.github.io](https://williamjzeng.github.io)

## About

Research Analyst at the Federal Reserve Bank of New York, focusing on high-frequency shock identification, international finance, and Indian Country issues.

## Website Sections

- **Publications**: Research publications and blog posts
- **Personal Projects**: Interactive visualizations and technical projects
- **CV**: Curriculum vitae with education, work experience, and skills

## Local Development

### Prerequisites

- Ruby (with ruby-dev)
- Bundler
- Node.js

### Setup

1. Clone the repository:
   ```bash
   git clone https://github.com/WilliamJZeng/WilliamJZeng.github.io.git
   cd WilliamJZeng.github.io
   ```

2. Install dependencies:
   ```bash
   bundle install
   ```

   If you encounter permission errors:
   ```bash
   bundle config set --local path 'vendor/bundle'
   bundle install
   ```

3. Run the local server:
   ```bash
   bundle exec jekyll serve -l -H localhost
   ```

4. Visit `http://localhost:4000` in your browser

The `-l` flag enables live reload. Changes are automatically reflected except for `_config.yml` modifications, which require a server restart.

### Using Docker

Alternatively, run the site using Docker:

```bash
docker compose up
```

Access at `http://localhost:4000`

## Site Structure

- `_config.yml` - Main site configuration
- `_data/navigation.yml` - Top navigation menu
- `_pages/` - Static pages (About, CV, etc.)
- `_publications/` - Publication markdown files
- `_personal_projects/` - Personal project markdown files
- `assets/js/` - JavaScript files for interactive features
- `files/` - PDFs and other downloadable files
- `images/` - Site images and icons

## Adding Content

### Publications

Create a new markdown file in `_publications/`:

```yaml
---
title: "Publication Title"
collection: publications
category: out_blogs  # or manuscripts, conferences, books
permalink: /publication/YYYY-MM-DD-slug
date: YYYY-MM-DD
venue: 'Venue Name'
link: 'https://url-to-publication'
---
Optional description text.
```

### Personal Projects

Create a new markdown file in `_personal_projects/`:

```yaml
---
title: "Project Title"
excerpt: "Brief description"
collection: personal_projects
---
Project content here.
```

**Note:** For interactive JavaScript projects, place JavaScript in external files under `assets/js/` and reference them with:
```html
<script src="{{ '/assets/js/your-script.js' | relative_url }}"></script>
```

## Deployment

The site automatically builds and deploys via GitHub Actions when changes are pushed to the `master` branch.

## Technology Stack

- **Jekyll 3.10.0** - Static site generator
- **GitHub Pages** - Hosting
- **Academic Pages** - Base template
- **Minimal Mistakes** - Theme foundation

## License

Based on the Academic Pages template, which is forked from Minimal Mistakes Jekyll Theme © 2016 Michael Rose, released under the MIT License.
