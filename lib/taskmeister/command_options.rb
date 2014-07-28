require "optparse"
require "ostruct"

module Taskmeister
  class CommandOptions
    def self.default_options
      OpenStruct.new.tap do |o|
        o.command = "list"
        o.task_dir = Pathname.getwd
      end
    end

    def self.parse(args)
      options = default_options

      opt_parser = OptionParser.new do |opts|
        opts.program_name = "taskmeister"
        opts.banner = "Usage: taskmeister [options] TASK TEXT"

        opts.separator ""
        opts.separator "Specific options:"
        opts.separator "  If no options are specified TASK TEXT is added as a new task."
        opts.separator ""

        opts.on("-t", "--task-dir DIRECTORY",
                "The DIRECTORY where your task lists are stored. Defaults to pwd.") do |dir|
          options.task_dir = Pathname.new(dir)
        end

        opts.on("-l", "--list NAME",
                "The task list to use.",
                "  Will use a list named after your current project directory if not supplied.",
                "  A project directory is found by walking up from the current directory and stopping if a .git or .hg directory is found.") do |list|
          options.list = Pathname.new(list)
        end

        opts.on("-d", "--done TASK_ID",
                "Finish a task") do |done_id|
          options.command = "done"
          options.task_id = done_id
        end

        opts.on("-s", "--show TASK_ID",
                "Show a task list item including its notes") do |show_id|
          options.command = "show"
          options.task_id = show_id
        end

        opts.on("-e", "--edit TASK_ID",
                "Open a task in Vim") do |edit_id|
          options.command = "edit"
          options.task_id = edit_id
        end

        opts.on("-r", "--replace TASK_ID",
                "Replace a task description") do |replace_id|
          options.command = "replace"
          options.task_id = replace_id
        end

        opts.separator ""
        opts.separator "Common options:"

        opts.on_tail("-h", "--help", "Show this message") do
          puts opts
          exit
        end

        # Another typical switch to print the version.
        opts.on_tail("--version", "Show version") do
          puts Taskmeister::VERSION
          exit
        end
      end

      task_text = opt_parser.parse!(args)
      options.task_text = task_text.join(" ") unless task_text.empty?
      options
    end
  end
end