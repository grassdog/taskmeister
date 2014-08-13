# encoding: utf-8

module Taskmeister
  class TaskListReader
    def self.from_markdown(file_lines, file_path)
      lines_grouped_by_task = \
        file_lines.map(&:chomp)
                  .reduce([]) do |acc, l|
                    acc.tap do |a|
                      if l.match(/#\s.+\s\[∞\]\(#[\w-]+\)/)
                        acc << [l]    # A new task
                      else
                        acc.last << l # A line of note for the latest task
                      end
                    end
                  end

      tasks = lines_grouped_by_task.map do |ls|
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
