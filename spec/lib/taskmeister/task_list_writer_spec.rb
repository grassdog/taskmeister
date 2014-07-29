require "taskmeister/task_list_writer"
require "taskmeister/task_list"
require "taskmeister/task"

module Taskmeister
  RSpec.describe TaskListWriter do
    describe ".to_lines" do
      let(:task1) { double(Task, to_markdown: ["line1", "line2"]) }
      let(:task2) { double(Task, to_markdown: ["line3", "line4"]) }
      let(:task_list) { double(TaskList, tasks: [ task1, task2 ]) }

      subject { described_class.to_lines(task_list) }

      it "returns a concatenated list of all the underlying task markdown" do
        expect(subject).to eq [
          "line1",
          "line2",
          "line3",
          "line4"
        ]
      end
    end
  end
end

