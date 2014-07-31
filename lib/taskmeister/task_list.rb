module Taskmeister
  class TaskList
    attr_reader :file_path

    def initialize(tasks, file_path)
      @file_path = Pathname.new file_path

      @shortIdToTask = {}

      tasks.each do |t|
        add(t)
      end

      @dirty = false
    end

    def to_short_list
      longest_id = @shortIdToTask.keys.max_by(&:length)
      @shortIdToTask.map { |id, task|
        marker = task.notes? ? " »" : ""
        "%-#{longest_id.length}s - %s%s" % [id, task.text, marker]
      }
    end

    def tasks
      @shortIdToTask.values
    end

    def [](key)
      @shortIdToTask[key]
    end

    def empty?
      @shortIdToTask.empty?
    end

    def dirty?
      @dirty
    end

    def add(task)
      prefix = assign_short_code_to_task(task)
      @shortIdToTask[prefix] = task
      @dirty = true
    end

    def complete(short_id)
      removed_val = @shortIdToTask.delete(short_id)
      @dirty = true if removed_val
    end

    def replace(short_id, new_text)
      task = self[short_id]
      return unless task

      @shortIdToTask[short_id] = Task.new(new_text, task.id, task.notes)
      @dirty = true
    end

    def markdown_for(short_id)
      return [] unless @shortIdToTask.has_key?(short_id)

      self[short_id].to_markdown
    end

    private

    def assign_short_code_to_task(task)
      task.id.length.times do |i|
        prefix = task.id.slice(0, i + 1)
        return prefix unless @shortIdToTask.has_key?(prefix)
      end
    end
  end
end
