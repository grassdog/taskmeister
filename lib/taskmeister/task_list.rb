module Taskmeister
  class TaskList
    attr_reader :file_path

    def initialize(tasks, file_path)
      @file_path = file_path

      @hash = {}

      tasks.each do |t|
        add(t)
      end

      @dirty = false
    end

    def to_short_list
      longest_id = @hash.keys.max_by(&:length)
      @hash.map { |id, task|
        marker = task.notes? ? " »" : ""
        "%-#{longest_id.length}s - %s%s" % [id, task.text, marker]
      }
    end

    def tasks
      @hash.values
    end

    def [](key)
      @hash[key]
    end

    def empty?
      @hash.empty?
    end

    def dirty?
      @dirty
    end

    def add(task)
      prefix = assign_short_code_to_task(task)
      @hash[prefix] = task
      @dirty = true
    end

    def complete(short_id)
      removed_val = @hash.delete(short_id)
      @dirty = true if removed_val
    end

    def replace(short_id, new_text)
      task = self[short_id]
      return unless task

      @hash[short_id] = Task.new(new_text, task.id, task.notes)
      @dirty = true
    end

    def markdown_for(short_id)
      return [] unless @hash.has_key?(short_id)

      self[short_id].to_markdown
    end

    private

    def assign_short_code_to_task(task)
      task.id.length.times do |i|
        prefix = task.id.slice(0, i + 1)
        return prefix unless @hash.has_key?(prefix)
      end
    end
  end
end
