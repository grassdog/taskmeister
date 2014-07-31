require "ostruct"

module Taskmeister
  module Cli
    module Commands

      class Command
        def initialize(task_list, options=OpenStruct.new, stdout=STDOUT, kernel=Kernel)
          @task_list = task_list
          @options = options
          @stdout = stdout
          @kernel = kernel
        end

        def execute!
          # Override this in derived class
        end

        protected

        def write
          Taskmeister::TaskListWriter.to_markdown_file(@task_list)
        end
      end

      class List < Command
        def execute!
          @stdout.puts @task_list.to_short_list
        end
      end

      class Show < Command
        def execute!
          @stdout.puts @task_list.markdown_for(@options.task_id)
        end
      end

      class Add < Command
        def execute!
          @task_list.add(Taskmeister::Task.create(@options.task_text))
          write
        end
      end

      class Replace < Command
        def execute!
          @task_list.replace(@options.task_id, @options.task_text)
          write
        end
      end

      class Done < Command
        def execute!
          @task_list.complete(@options.task_id)
          write
        end
      end

      class Edit < Command
        def execute!
          task = @task_list[@options.task_id]

          search_path = task ? "+/#{task.id} " : ""

          system "vim #{search_path}#{@task_list.file_path}"
        end
      end
    end
  end
end
