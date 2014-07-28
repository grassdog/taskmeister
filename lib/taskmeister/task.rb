module Taskmeister
  class Task
    attr_reader :name, :notes, :id

    def initialize(id, name, notes)
      @id, @name, @notes = id, name, notes
    end

    def self.create(name, notes)
      self.class.new(name, notes, SecureRandom.uuid)
    end

    def self.from_lines(lines)

    end
  end
end
