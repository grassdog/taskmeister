require "taskmeister/task_list_reader"
require "taskmeister/task_list"
require "taskmeister/task"

module Taskmeister
  RSpec.describe TaskListReader do
    describe ".from_lines" do

      before do
        allow(Task).to receive(:from_lines).and_return(double(Task))
        allow(TaskList).to receive(:new).and_return(double(TaskList))
      end

      let(:it) { described_class.from_lines(lines) }

      describe "passed an empty list of lines" do
        let(:lines) { [] }

        it "creates an empty task list" do
          expect(Task).not_to receive(:from_lines)
          expect(TaskList).to receive(:new).with([])
          it
        end
      end

      describe "passed a list of simple tasks" do
        let(:lines) { [
          "Task number 1\n",
          "Task number 2\n"
          ]
        }

        it "creates a task for each line, stripping new lines" do
          expect(Task).to receive(:from_lines).with([ "Task number 1" ])
          expect(Task).to receive(:from_lines).with([ "Task number 2" ])
          it
        end
      end

      describe "passed a list of tasks with notes" do
        let(:lines) { [
          "Task number 1\n",
          "\n",
          "> note line 1\n",
          "> note line 2\n",
          "\n",
          "Task number 2\n",
          "Task number 3\n",
          "\n",
          "> note line 3\n",
          "> note line 4\n",
          "",
          "",
          ]
        }

        it "creates a task for each line with their associated notes, stripping newlines" do
          expect(Task).to receive(:from_lines).with([
            "Task number 1",
            "> note line 1",
            "> note line 2",
          ])
          expect(Task).to receive(:from_lines).with([
            "Task number 2"
          ])
          expect(Task).to receive(:from_lines).with([
            "Task number 3",
            "> note line 3",
            "> note line 4",
          ])

          it
        end
      end
    end
  end
end
