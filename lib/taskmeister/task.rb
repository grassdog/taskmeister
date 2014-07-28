module Taskmeister
  class Task
    attr_reader :text, :notes, :id

    def initialize(id, text, notes)
      @id, @text, @notes = id, text, notes
    end

    def self.create(name, notes)
      self.class.new(name, notes, SecureRandom.uuid)
    end

    def self.from_lines(lines)
      task, *notes = *lines

      text, id = task_details(task)

      notes = notes.map { |l| l.gsub(/\A> /, "") }.join("\n")

      self.new(id, text, notes)
    end

    def self.task_details(line)
      matches = line.match(/\A(.+) - \[id\]\(([\w-]+)\)\z/)

      fail "Invalid task: #{line}" unless matches

      [matches[1], matches[2]]
    end
  end
end
