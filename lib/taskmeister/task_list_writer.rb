module Taskmeister
  class TaskListWriter
    def self.to_markdown(task_list)
      task_list.tasks.map(&:to_markdown).flatten
    end

    def self.to_markdown_file(task_list)
      return unless task_list.dirty?

      return task_list.file_path.delete if task_list.empty? && File.exist?(task_list.file_path)

      lines = self.to_markdown(task_list)
      File.open(task_list.file_path, "w") do |f|
        f.puts lines
      end
    end
  end
end
