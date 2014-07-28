module Taskmeister
  class TaskList
    attr_reader :tasks

    def initialize(tasks)
      @tasks = tasks
      @hash = TaskHash.new(tasks)
    end

    def short_list
      @hash.short_list
    end

    def serialize
      ""
    end

    def self.from_lines(lines)
      grouped_lines = \
        lines.map(&:chomp)
             .reject(&:empty?)
             .reduce([]) do |acc, l|
               acc << [l]    if l.match(/\A[^\s>]/) # A new task
               acc.last << l if l.match(/\A>/)      # A line of note for the latest task
               acc
             end

      tasks = grouped_lines.map do |l|
        Task.from_lines(l)
      end

      self.new tasks
    end
  end
end
