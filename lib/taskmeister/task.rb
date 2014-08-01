require 'securerandom'

module Taskmeister
  class Task
    attr_reader :text, :notes, :id

    def initialize(text, id, notes)
      @text, @id, @notes = text, id, Array(notes)
    end

    def notes?
      notes.any? { |ns| !ns.empty? }
    end

    def to_markdown
      [ "# #{text} [∞](##{id})" ].tap do |a|
        a.concat notes
      end
    end

    def self.create(text)
      self.new(text, SecureRandom.uuid, [""])
    end

    def self.from_markdown(lines)
      task, *notes = *lines

      text, id = task_attributes(task)

      self.new(text, id, notes)
    end

    def self.task_attributes(line)
      matches = line.match(/#\s(.+)\s\[∞\]\(#([\w-]+)\)/)

      fail "Invalid task: #{line}" unless matches

      [matches[1], matches[2]]
    end
  end
end
