module Taskmeister
  class TaskListWriter
    def self.to_lines(task_list)
      task_list.tasks.map(&:to_markdown).flatten
    end

    def self.to_file(task_list, file_path)
      lines = self.to_lines(task_list)
      File.open(file_path, "w") do |f|
        f.puts lines
      end
    end
  end
end
