# GitHub Action to Create Releases Based on a Keyword
The Keyword Releaser will create a release based on the keyword specified in the arguments.

# Secrets
- `GITHUB_TOKEN` - _Required_ Allows the Action to authenticte with the GitHub API to create the release.

# Environment Variables
- N/A

# Arguments
- _Required_ - A single keyword.  If the keyword is found in a commit message, a release will be created.  Although case is ignored, it's suggested to use a unique, uppercase string like `FIXED`, `READY_TO_RELEASE`, or maybe even `PINEAPPLE`.

# Examples
Here's an example workflow that uses the Keyword Releaser action.  The workflow is triggered by a `PUSH` event and looks for the keyword `"FIXED"`.

```yaml
name: keyword-monitor

on:
  push:

jobs:
  keyword-releaser:
    runs-on: ubuntu-latest
    steps:
      - name: Keyword Releaser
        uses: managedkaos/keyword-releaser@master
        with:
          args: FIXED
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}

```
