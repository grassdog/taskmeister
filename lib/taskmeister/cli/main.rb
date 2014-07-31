require "pathname"

module Taskmeister
  module Cli
    class Main
      def initialize(argv, stdin=STDIN, stdout=STDOUT, stderr=STDERR, kernel=Kernel)
        @argv, @stdin, @stdout, @stderr, @kernel = argv, stdin, stdout, stderr, kernel
      end

      def execute!
        options = Options.new(@stdout, @kernel).parse(@argv)

        file_path = task_list_path(options)
        task_list = Taskmeister::TaskListReader.from_markdown_file(file_path)

        command = options.command.new(task_list, options, @stdout, @kernel)

        command.execute!

        @kernel.exit 0
      end

      private

      def task_list_path(options)
        Pathname.new(options.task_dir) + task_list_name(options)
      end

      def task_list_name(options)
        task_list_name = options.list || TaskListName.from_project_dir(Pathname.getwd)

        unless task_list_name
          @stderr.puts "Could not find a project directory. Please specify a task list instead."
          @kernel.exit 1
        end

        task_list_name
      end
    end
  end
end
