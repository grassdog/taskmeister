module Taskmeister
  class TaskListReader
    def self.from_markdown(file_lines, file_path)
      grouped_lines = \
        file_lines.map(&:chomp)
                  .reject(&:empty?)
                  .reduce([]) do |acc, l|
                    acc << [l]    if l.match(/\A[^\s>]/) # A new task
                    acc.last << l if l.match(/\A>/)      # A line of note for the latest task
                    acc
                  end

      tasks = grouped_lines.map do |ls|
        Task.from_markdown ls
      end

      TaskList.new tasks, file_path
    end

    def self.from_markdown_file(file_path)
      lines = File.exist?(file_path) ? File.readlines(file_path) : []
      self.from_markdown lines, file_path
    end
  end
end
