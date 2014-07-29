module Taskmeister
  class TaskListReader
    def self.from_markdown(file_lines)
      grouped_lines = \
        file_lines.map(&:chomp)
                  .reject(&:empty?)
                  .reduce([]) do |acc, l|
                    acc << [l]    if l.match(/\A[^\s>]/) # A new task
                    acc.last << l if l.match(/\A>/)      # A line of note for the latest task
                    acc
                  end

      tasks = grouped_lines.map do |l|
        Task.from_markdown(l)
      end

      TaskList.new tasks
    end

    def self.from_markdown_file(path)
      lines = File.exist?(path) ? File.readlines(path) : []
      from_markdown lines
    end
  end
end
