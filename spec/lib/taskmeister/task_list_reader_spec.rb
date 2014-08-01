require "taskmeister/task_list_reader"
require "taskmeister/task_list"
require "taskmeister/task"

module Taskmeister
  RSpec.describe TaskListReader do
    describe ".from_markdown" do

      before do
        allow(Task).to receive(:from_markdown).and_return(double(Task))
        allow(TaskList).to receive(:new).and_return(double(TaskList))
      end

      let(:it) { described_class.from_markdown(lines, "fake file") }

      describe "passed an empty list of lines" do
        let(:lines) { [] }

        it "creates an empty task list" do
          expect(Task).not_to receive(:from_markdown)
          expect(TaskList).to receive(:new).with([], "fake file")
          it
        end
      end

      describe "passed a list of simple tasks" do
        let(:lines) { [
          "# Task number 1 [∞](#e8fd82de-c379-496d-a77b-2873192e8ea8)\n",
          "\n",
          "# Task number 2 [∞](#e9fd82de-c379-496d-a77b-2873192e8ea8)\n",
          "\n"
          ]
        }

        it "creates a task for each line, stripping new lines" do
          expect(Task).to receive(:from_markdown).with([ "# Task number 1 [∞](#e8fd82de-c379-496d-a77b-2873192e8ea8)", ""])
          expect(Task).to receive(:from_markdown).with([ "# Task number 2 [∞](#e9fd82de-c379-496d-a77b-2873192e8ea8)", ""])
          it
        end
      end

      describe "passed a list of tasks with notes" do
        let(:lines) { [
          "# Task number 1 [∞](#e8fd82de-c379-496d-a77b-2873192e8ea8)\n",
          "\n",
          "note line 1\n",
          "\n",
          "\n",
          "note line 2\n",
          "\n",
          "# Task number 2 [∞](#18fd82de-c379-496d-a77b-2873192e8ea8)\n",
          "\n",
          "# Task number 3 [∞](#e9fd82de-c379-496d-a77b-2873192e8ea8)\n",
          "\n",
          "note line 3\n",
          "note line 4\n",
          "\n"
          ]
        }

        it "creates a task for each line with their associated notes, stripping newlines" do
          expect(Task).to receive(:from_markdown).with([
            "# Task number 1 [∞](#e8fd82de-c379-496d-a77b-2873192e8ea8)",
            "",
            "note line 1",
            "",
            "",
            "note line 2",
            "",
          ])
          expect(Task).to receive(:from_markdown).with([
            "# Task number 2 [∞](#18fd82de-c379-496d-a77b-2873192e8ea8)",
            "",
          ])
          expect(Task).to receive(:from_markdown).with([
            "# Task number 3 [∞](#e9fd82de-c379-496d-a77b-2873192e8ea8)",
            "",
            "note line 3",
            "note line 4",
            ""
          ])

          it
        end
      end
    end
  end
end
