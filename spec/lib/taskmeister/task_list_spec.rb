require "taskmeister/task_list"
require "taskmeister/task"

module Taskmeister
  RSpec.describe TaskList do
    describe "#from_lines" do
      let(:it) { described_class.from_lines(lines) }

      describe "passed an empty list of lines" do
        let(:lines) { [] }

        it "creates an empty task list" do
          expect(it.tasks).to be_empty
        end
      end

      describe "passed a list of simple tasks" do
        let(:lines) { [
          "Task number 1",
          "Task number 2"
          ]
        }

        before do
          allow(Task).to receive(:from_lines).and_return(double(Task))
        end

        it "creates a task for each line" do
          expect(Task).to receive(:from_lines).with([ "Task number 1" ])
          expect(Task).to receive(:from_lines).with([ "Task number 2" ])
          it
        end

        it "returns each of the created tasks" do
          expect(it.tasks.size).to eq 2
        end
      end

      describe "passed a list of tasks with notes" do
        let(:lines) { [
          "Task number 1",
          "",
          "> note line 1",
          "> note line 2",
          "",
          "Task number 2",
          "Task number 3",
          "",
          "> note line 3",
          "> note line 4",
          "",
          "",
          ]
        }

        before do
          allow(Task).to receive(:from_lines).and_return(double(Task))
        end

        it "creates a task for each line with their associated notes" do
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

        it "returns each of the created tasks" do
          expect(it.tasks.size).to eq 3
        end
      end
    end
  end
end
