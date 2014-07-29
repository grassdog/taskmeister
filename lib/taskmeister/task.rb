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

    def to_markdown
      [ "#{text} - [id](#{id})" ].tap do |a|
        return a unless notes.match /\S/
        a << ""
        a.concat notes.split("\n").map { |n|
          n.size > 0 ? "> #{n}" : ">"
        }
        a << ""
      end
    end

    def self.create(text)
      self.new(text, SecureRandom.uuid, "")
    end

    def self.from_lines(lines)
      task, *notes = *lines

      text, id = task_details(task)

      notes = notes.map { |l| l.gsub(/\A> ?/, "") }.join("\n")

      self.new(text, id, notes)
    end

    def self.task_details(line)
      matches = line.match(/\A(.+) - \[id\]\(([\w-]+)\)\z/)

      fail "Invalid task: #{line}" unless matches

      [matches[1], matches[2]]
    end
  end
end
