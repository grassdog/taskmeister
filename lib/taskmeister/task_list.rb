module Taskmeister
  class TaskList
    def initialize(tasks)
      @hash = {}

      tasks.each do |t|
        add(t)
      end
    end

    def to_short_list
      longest_id = @hash.keys.max {|id| id.length }
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

    def add(task)
      prefix = assign_short_code_to_task(task)
      @hash[prefix] = task
    end

    def complete(short_id)
      @hash.delete(short_id)
    end

    def replace(short_id, new_text)
      task = self[short_id]
      return unless task

      @hash[short_id] = Task.new(new_text, task.id, task.notes)
    end

    def details(short_id)
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
