require 'securerandom'

module Taskmeister
  class Task
    attr_reader :text, :notes, :id

    def initialize(text, id, notes)
      @text, @id, @notes = text, id, notes
    end

    def notes?
      notes && !notes.empty?
    end

    def self.create(text, notes)
      self.class.new(text, SecureRandom.uuid, notes)
    end

    def self.from_lines(lines)
      task, *notes = *lines

      text, id = task_details(task)

      notes = notes.map { |l| l.gsub(/\A> /, "") }.join("\n")

      self.new(text, id, notes)
    end

    def self.task_details(line)
      matches = line.match(/\A(.+) - \[id\]\(([\w-]+)\)\z/)

      fail "Invalid task: #{line}" unless matches

      [matches[1], matches[2]]
    end
  end
end
