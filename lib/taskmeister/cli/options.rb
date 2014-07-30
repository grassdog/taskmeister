require "optparse"
require "ostruct"
require "pathname"

module Taskmeister
  module Cli
    module Commands
      ADD     = "add"
      LIST    = "list"
      REPLACE = "replace"
      EDIT    = "edit"
      SHOW    = "show"
      DONE    = "done"
    end

    class Options
      def initialize(stdout = STDOUT, kernel = Kernel)
        @stdout = stdout
        @kernel = kernel
      end

      def parse(args)
        options = default_options

        opt_parser = OptionParser.new do |opts|
          opts.program_name = "taskmeister"
          opts.banner = "Usage: taskmeister [options] TASK TEXT"

          opts.separator ""
          opts.separator "Specific options:"
          opts.separator "  If no options are specified TASK TEXT is added as a new task."
          opts.separator ""

          opts.on("-t", "--task-dir DIRECTORY",
                  "The DIRECTORY where your task lists are stored. (Defaults to pwd)") do |dir|
            options.task_dir = Pathname.new(dir)
          end

          opts.on("-l", "--list NAME",
                  "The task list to use.",
                  "  Will use a list named after your current project directory if not supplied.",
                  "  A project directory is found by walking up from the current directory and stopping if a .git or .hg directory is found.") do |list|
            options.list = Pathname.new(list)
          end

          opts.on("-d", "--done TASK_ID",
                  "Finish a task") do |task_id|
            options.command = Commands::DONE
            options.task_id = task_id
          end

          opts.on("-s", "--show TASK_ID",
                  "Show a task list item and its notes") do |task_id|
            options.command = Commands::SHOW
            options.task_id = task_id
          end

          opts.on("-e", "--edit [TASK_ID]",
                  "Edit task list in Vim",
                  "  Will search for a specific task if TASK_ID is provided") do |task_id|
            options.command = Commands::EDIT
            options.task_id = task_id
          end

          opts.on("-r", "--replace TASK_ID",
                  "Replace a task description") do |task_id|
            options.command = Commands::REPLACE
            options.task_id = task_id
          end

          opts.separator ""
          opts.separator "Common options:"

          opts.on_tail("-h", "--help", "Show this message") do
            @stdout.puts opts
            @kernel.exit
          end

          opts.on_tail("--version", "Show version") do
            @stdout.puts Taskmeister::VERSION
            @kernel.exit
          end
        end

        task_text = opt_parser.parse!(args)

        options.task_text = task_text.join(" ") unless task_text.empty?

        # If there is TASK TEXT and the default command hasn't been overwritten
        # by the user, set the command to ADD
        if !task_text.empty? and options.command == Commands::LIST
          options.command = Commands::ADD
        end

        options
      end

      private

      def default_options
        OpenStruct.new.tap do |o|
          o.command  = Commands::LIST
          o.task_dir = Pathname.getwd
        end
      end
    end
  end
end
