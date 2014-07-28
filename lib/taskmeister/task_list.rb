module Taskmeister
  class TaskList
    def initialize(tasks)
      @hash = {}

      tasks.each do |t|
        t.id.length.times do |i|
          prefix = t.id.slice(0, i + 1)
          unless @hash.has_key?(prefix)
            @hash[prefix] = t
            break
          end
        end
      end
    end

    def short_list
      longest_id = @hash.keys.max {|id| id.length }
      @hash.map { |id, task|
        marker = task.notes? ? " »" : ""
        "%-#{longest_id.length}s - %s%s" % [id, task.text, marker]
      }
    end

    def [](key)
      @hash[key]
    end

    def complete(short_id)
      # @hash.remove(short_id)
    end
  end
end
