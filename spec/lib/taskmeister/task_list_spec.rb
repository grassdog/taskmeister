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

    let(:list) { described_class.new(tasks) }

    describe "#[]" do
      it "uses the shortest common prefix to index a task" do
        expect(list["7"]).to eq task1
        expect(list["b"]).to eq task2
        expect(list["1"]).to eq task3
        expect(list["1c"]).to eq task4
        expect(list["e"]).to eq task5
        expect(list["f"]).to eq task6
        expect(list["f2"]).to eq task7
      end
    end

    describe "#to_short_list" do
      subject { list.to_short_list }

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

    describe "#complete" do
      it "removes the identified task" do
        expect(list["7"]).to eq task1
        result = list.complete("7")
        expect(result).to be_truthy
        expect(list["7"]).to be_nil
      end

      it "ignores non-existent tasks" do
        result = list.complete("345")
        expect(result).to be_falsy
        expect(list.tasks.size).to eq tasks.size
      end
    end

    describe "#replace" do
      it "replaces the text of the specified task" do
        result = list.replace("7", "A new task text")
        expect(result).to be_truthy
        task = list["7"]
        expect(task.text).to eq "A new task text"
      end

      it "ignores a non-existent task" do
        result = list.replace("345", "A new task text")
        expect(result).to be_falsy
        expect(list.tasks.size).to eq tasks.size
      end
    end

    describe "#details" do
      before do
        allow_any_instance_of(Task).to receive(:to_markdown).and_return([
          "line 1",
          "line 2"
        ])
      end

      it "returns an empty list if the id doesn't exist" do
        expect(list.details("34")).to eq []
      end

      it "returns the lines of a task" do
        expect(list.details("7")).to eq ["line 1", "line 2"]
      end
    end

    describe "#add" do
      it "adds the task and assigns it a short id" do
        task8 = Task.new("task 8", "f23891df0-97a5-4310-9b01-374983416af7", nil)
        result = list.add(task8)
        expect(result).to be_truthy
        expect(list.tasks.size).to eq 8
        expect(list["f23"]).to eq task8
      end
    end
  end
end
