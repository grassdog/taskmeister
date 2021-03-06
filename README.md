# Taskmeister

Simple command line task management modelled after [t](http://stevelosh.com/projects/t/).

I like the simplicity of t but there are a couple of changes I wanted.

First: I like to have separate task lists per project but I want a single shell
alias for all of them. So I infer the task list name from the current project
directory. It finds a project directory by walking up from the current directory
until it finds a `.git` or `.hg` directory in it.

Second: I like to have a short list of notes accompanying my tasks. You can add
notes beneath your task. They can be edited via Vim with `taskmeister -e` or
`taskmeister -e id` to seek to a specific task.

Third: I format my task files in Markdown so that when I open them on my phone
via a Markdown-enabled editor they look nice. The format is still simple:

```markdown
# Update gems [∞](#aaf83a9b-02f7-4cc0-8ee1-4d98b98903b8)

# Refactor the widget model [∞](#ae0cce15-456d-48c0-a2e2-69d5f567e092)

# Update the README [∞](#a5d4d3a9-2b9a-427a-9047-b47c6aec8f93)

Some notes to go with the task above.

- item 1
- item 2

> Or a quote

```

## Installation

Install via Rubygems:

```sh
$ gem install taskmeister
```

## Usage

```sh
$ taskmeister --help
Usage: taskmeister [options] TASK TEXT

Specific options:
  If no options are specified TASK TEXT is added as a new task.

    -t, --task-dir DIRECTORY         The DIRECTORY where your task lists are stored. (Defaults to pwd)
    -l, --list NAME                  The task list to use.
                                       Will use a list named after your current project directory if not supplied.
                                       A project directory is found by walking up from the current directory and stopping if a .git or .hg directory is found.
    -d, --done TASK_ID               Finish a task
    -s, --show TASK_ID               Show a task list item and its notes
    -e, --edit [TASK_ID]             Edit task list in Vim
                                       Will search for a specific task if TASK_ID is provided
    -r, --replace TASK_ID            Replace a task description

Common options:
    -h, --help                       Show this message
        --version                    Show version
```

I store my task files in Dropbox so I have the following shell alias set:

```sh
alias t='taskmeister -t ~/Dropbox/Tasks'
```

I let Taskmeister determine the task list name from my current directory. If
you want a set a specific task list you could add that to your alias.

```sh
alias t='taskmeister -t ~/Dropbox/Tasks -l mytasks.md'
```

## Contributing

Fork the project on Github, add tests for your changes, and submit a well described pull request.

## Copyright

Copyright (c) 2014 Ray Grasso. See LICENSE.txt for further details.
