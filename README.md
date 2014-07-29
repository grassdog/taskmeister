# Taskmeister

Simple task management modelled after [t](http://stevelosh.com/projects/t/).

I tried to keep it as simple but there are a couple of changes and different
features.

First: I like to have separate task lists per project. So I infer the task list
name for the current project directory (it walks up from the current directory
until it finds a `.git` or `.hg` directory as a child and uses that directory
name for the task list name.

Second: I like to have a short list of notes accompanying my tasks.

Third: I format my task files in Markdown so that when I open them on my phone
via a Markdown enabled editor they look nice.

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

    -t, --task-dir DIRECTORY         The DIRECTORY where your task lists are stored. Defaults to pwd.
    -l, --list NAME                  The task list to use.
                                       Will use a list named after your current project directory if not supplied.
                                       A project directory is found by walking up from the current directory and stopping if a .git or .hg directory is found.
    -d, --done TASK_ID               Finish a task
    -s, --show TASK_ID               Show a task list item including its notes
    -e, --edit TASK_ID               Edit a task in Vim
    -r, --replace TASK_ID            Replace a task description

Common options:
    -h, --help                       Show this message
        --version                    Show version
```

## Contributing

1. Fork it ( https://github.com/grassdog/taskmeister/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
