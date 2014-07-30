require "pathname"

module Taskmeister
  module Cli
    class Main
      def initialize(argv, stdin=STDIN, stdout=STDOUT, stderr=STDERR, kernel=Kernel)
        @argv, @stdin, @stdout, @stderr, @kernel = argv, stdin, stdout, stderr, kernel
      end

      def execute!
        options = Options.new(@stdout, @kernel).parse(@argv)

        task_list = Taskmeister::TaskListReader.from_markdown_file(task_list_path(options))

        run_command(options, task_list)
      end

      private

      def run_command(options, task_list)
        case options.command
        when Commands::LIST
          @stdout.puts task_list.to_short_list

        when Commands::SHOW

          @stdout.puts task_list.markdown_for(options.task_id)

        when Commands::EDIT

          task = task_list[options.task_id]

          search_path = task ? "+/#{task.id} " : ""
          system "vim #{search_path}#{task_list.file_path}"

        when Commands::ADD

          task_list.add(Taskmeister::Task.create(options.task_text))
          update task_list

        when Commands::DONE

          task_list.complete(options.task_id)
          update task_list

        when Commands::REPLACE

          task_list.replace(options.task_id, options.task_text)
          update task_list

        end

        @kernel.exit 0
      end

      def task_list_path(options)
        Pathname.new(options.task_dir) + task_list_name(options)
      end

      def task_list_name(options)
        task_list_name = options.list || TaskListName.from_project_dir(Pathname.getwd)

        unless task_list_name
          @stderr.puts "Could not find a project directory. Please specify a task list."
          @kernel.exit 1
        end

        task_list_name
      end

      def update(task_list)
        Taskmeister::TaskListWriter.to_markdown_file(task_list)
      end
    end
  end
end
