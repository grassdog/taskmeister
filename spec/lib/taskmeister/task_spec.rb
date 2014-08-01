require "taskmeister/task"

module Taskmeister
  RSpec.describe Task do
    describe ".from_markdown" do
      subject { described_class.from_markdown(lines) }

      describe "passed a task with an empty note" do
        let(:lines) { [
          "# A task name [∞](#78dc2561-8c9a-4780-a560-56e1e14f2ed3)",
          "",
        ]}

        it "sets the name and id of the task" do
          expect(subject.id).to eq "78dc2561-8c9a-4780-a560-56e1e14f2ed3"
          expect(subject.text).to eq "A task name"
          expect(subject.notes).to eq [""]
        end
      end

      describe "passed a single valid line and notes" do
        let(:lines) { [
          "# A task name [∞](#78dc2561-8c9a-4780-a560-56e1e14f2ed3)",
          "",
          "note line 1",
          "",
          "",
          "note line 2",
          ""
        ]}

        it "sets the name and id of the task" do
          expect(subject.id).to eq "78dc2561-8c9a-4780-a560-56e1e14f2ed3"
          expect(subject.text).to eq "A task name"
        end

        it "sets the notes of the task" do
          expect(subject.notes).to eq [
            "",
            "note line 1",
            "",
            "",
            "note line 2",
            ""
          ]
        end
      end

      describe "passed a single invalid line" do
        let(:lines) { [
          "A task name"
        ]}

        it "raises an error" do
          expect{ subject }.to raise_error
        end
      end
    end

    describe ".create" do
      it "returns a task with the specified text, a new id, and empty notes" do
        task = described_class.create("My task text")
        expect(task.text).to eq "My task text"
        expect(task.id).to match(/[\w-]+/)
        expect(task.notes).to eq [""]
      end
    end

    describe "#notes?" do
      it "returns true if there is a non-empty string in the notes list" do
        task = Task.new("My task text", "f23891df0-97a5-4310-9b01-374983416af7", ["", "a note", ""])
        expect(task.notes?).to be_truthy
      end

      it "returns false if there is are only empty strings in the notes list" do
        task = Task.new("My task text", "f23891df0-97a5-4310-9b01-374983416af7", ["", ""])
        expect(task.notes?).to be_falsy
      end
    end

    describe "#to_markdown" do
      it "returns a list of markdown-formatted lines" do
        task = described_class.new("task 8", "f23891df0-97a5-4310-9b01-374983416af7", [""])
        expect(task.to_markdown).to eq [
          "# task 8 [∞](#f23891df0-97a5-4310-9b01-374983416af7)",
          ""
        ]
      end

      it "returns a list of markdown-formatted lines including notes" do
        task = described_class.new("task 8", "f23891df0-97a5-4310-9b01-374983416af7",
                        ["", "First line of a note", "second line", "", "third line"])
        expect(task.to_markdown).to eq [
          "# task 8 [∞](#f23891df0-97a5-4310-9b01-374983416af7)",
          "",
          "First line of a note",
          "second line",
          "",
          "third line"
        ]
      end
    end
  end
end
