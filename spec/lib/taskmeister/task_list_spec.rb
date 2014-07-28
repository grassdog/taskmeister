require "taskmeister/task_list"
require "taskmeister/task"

module Taskmeister
  RSpec.describe TaskList do

    let(:task1) { Task.new("task 1", "78dc2561-8c9a-4780-a560-56e1e14f2ed3", nil) }
    let(:task2) { Task.new("task 2", "b2110029-ffa0-4e54-985a-2aa6d1bed53b", nil) }
    let(:task3) { Task.new("task 3", "1c890df0-97a5-4310-9b01-374983416af7", "a note") }
    let(:task4) { Task.new("task 4", "1c891df0-97a5-4310-9b01-374983416af7", nil) }
    let(:task5) { Task.new("task 5", "ef0915ee-3d11-4358-b12c-15a4ab0d1d26", nil) }
    let(:task6) { Task.new("task 6", "f2a0d281-f323-4909-8547-d4af5315a295", nil) }
    let(:task7) { Task.new("task 7", "f2a0d281-4323-4909-8547-d4af5315a295", nil) }

    let(:tasks) { [
      task1, task2, task3, task4, task5, task6, task7
    ]}

    describe "#[]" do
      let(:it) { described_class.new(tasks) }

      it "uses the shortest common prefix to index a task" do
        expect(it["7"]).to eq task1
        expect(it["b"]).to eq task2
        expect(it["1"]).to eq task3
        expect(it["1c"]).to eq task4
        expect(it["e"]).to eq task5
        expect(it["f"]).to eq task6
        expect(it["f2"]).to eq task7
      end
    end

    describe "short_list" do
      subject { described_class.new(tasks).short_list }

      it "returns an array of short ids and task texts with markers for those that have notes" do
        expect(subject).to eq([
          "7  - task 1",
          "b  - task 2",
          "1  - task 3 »",
          "1c - task 4",
          "e  - task 5",
          "f  - task 6",
          "f2 - task 7"
        ])
      end
    end
  end
end
