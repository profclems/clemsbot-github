# clemsbot-github
A repo for my GitHub Bot @clemsbot


## How to use the **@clemsbot** instance ##

### As a GitHub App

Notes:

- Installation as a GitHub App is still in an experimental stage
and you may frequently receive requests to expand permissions.

- All the repositories that use the bot and belong to the same
owner must install the bot using the same method (GitHub App or
regular user).

- If you were previously using the legacy installation method,
make sure you disable any previously set up GitHub webhooks when
switching to the GitHub App, otherwise the bot will receive every
request twice.

The bot can be installed as a GitHub App to either your account or
organization ([link to app](https://github.com/apps/clemsbot-github)).
Once you finish the installation, follow these steps:

- Create a repository on GitLab.com which will be used to run CI jobs.

  The bot will only take care of mirroring the PRs and reporting
  status checks back so you may still want to activate the mirroring
  feature for the main branches.  To do so, the easiest way is to
  choose the "CI/CD for external repo" option when creating the GitLab
  repository.  However, you should opt to give the repo by URL rather
  than with the GitHub button, because we won't need GitLab's own
  status check reporting feature. (If it is already activated, you can
  disable this integration in the "Settings" / "Integration" menu).

- In your GitLab repository:

  - go to "Members" to add
    [**@clemsbot**](https://gitlab.com/clemsbot) as a project member with
    "Developer" role (so that it can push new branches).

  - go to "Settings" / "Webhooks" and create one webhook that will be
    triggered by pipeline events and job events. Set its URL to
    <https://clemsbot.herokuapp.com/gitlab>.

  By default, **@clemsbot** considers that both GitHub and GitLab repositories
  share the same URL except for the "lab" replacing the "hub" part. If
  that is not the case, assuming you created a GitLab repository whose
  URL is <https://gitlab.com/owner/repo/>, add a file `clemsbot.toml` at
  the root of your GitHub repository and in its default branch (most often
  named `master`), containing:
  ```
  [mapping]
  gitlab = "owner/repo"
  ```
  If you use other instance of **@clemsbot**, this repository-specific
  configuration file becomes `BOT_NAME.toml` where `BOT_NAME` is the name
  of the bot.

### As a regular user account (legacy)

The bot used to be given access to each of your GitHub repositories as a
regular GitHub user account (**@clemsbot**). This installation method is
still supported for repositories that haven't migrated to the GitHub App
yet. Here are the steps to follow in addition to those described in the 
`As GitHub App` section:

- In your GitHub repository:

  - go to "Settings" / "Manage access" to add
    [**@clemsbot**](https://github.com/clemsbot) as a collaborator with
    the "Write" role (so that it can push status checks, and set
    labels).

    Currently, every invitation requires a manual validation, so there
    may be some lag before **@clemsbot** can push status checks
    to your repository.

  - go to "Settings" / "Webhooks" and add one webhook with URL
    <https://clemsbot.herokuapp.com/github> that will only be triggered
    at least by pull request events, and if you want to use the issue
    milestone feature, by issue events as well.  Make sure you change
    the "content/type" value to "application/json".
