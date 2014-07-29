require "pathname"

module Taskmeister
  module Cli
    class Main
      def initialize(argv, stdin=STDIN, stdout=STDOUT, stderr=STDERR, kernel=Kernel)
        @argv, @stdin, @stdout, @stderr, @kernel = argv, stdin, stdout, stderr, kernel
      end

      def execute!
        options = Options.new(@stdout, @kernel).parse(@argv)

        task_list_path = Pathname.new(options.task_dir) + task_list_name(options)

        task_list = Taskmeister::TaskListReader.from_markdown_file(task_list_path)

        run_command(options, task_list_path, task_list)
      end

      private

      def task_list_name(options)
        task_list_name = options.list || TaskListName.from_project_dir(Pathname.getwd)

        unless task_list_name
          @stdout.puts "Could not find a project directory. Please specify a task list."
          @kernel.exit 1
        end

        task_list_name
      end

      def run_command(options, task_list_path, task_list)
        case options.command
        when Commands::LIST
          @stdout.puts task_list.to_short_list

        when Commands::SHOW

          @stdout.puts task_list.details(options.task_id)

        when Commands::EDIT

          task = task_list[options.task_id]

          search_path = task ? "+/#{task.id} " : ""
          system "vim #{search_path}#{task_list_path}"

        when Commands::ADD

          update_task_list(task_list, task_list_path) {
            task_list.add(Taskmeister::Task.create(options.task_text))
          }

        when Commands::DONE

          update_task_list(task_list, task_list_path) {
            task_list.complete options.task_id
          }

        when Commands::REPLACE

          update_task_list(task_list, task_list_path) {
            task_list.replace options.task_id, options.task_text
          }

        end

        @kernel.exit 0
      end

      def update_task_list(task_list, file_path)
        Taskmeister::TaskListWriter.to_markdown_file(task_list, file_path) if yield
      end
    end
  end
end
