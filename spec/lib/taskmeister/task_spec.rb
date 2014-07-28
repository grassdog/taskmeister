require "taskmeister/task"

module Taskmeister
  RSpec.describe Task do
    describe ".from_lines" do
      subject { described_class.from_lines(lines) }

      describe "passed a single valid line" do
        let(:lines) { [
          "A task name - [id](78dc2561-8c9a-4780-a560-56e1e14f2ed3)"
        ]}

        it "sets the name and id of the task" do
          expect(subject.id).to eq "78dc2561-8c9a-4780-a560-56e1e14f2ed3"
          expect(subject.text).to eq "A task name"
          expect(subject.notes).to eq ""
        end
      end

      describe "passed a single valid line and notes" do
        let(:lines) { [
          "A task name - [id](78dc2561-8c9a-4780-a560-56e1e14f2ed3)",
          "> line one of a note",
          "> line two of a note"
        ]}

        it "sets the name and id of the task" do
          expect(subject.id).to eq "78dc2561-8c9a-4780-a560-56e1e14f2ed3"
          expect(subject.text).to eq "A task name"
        end

        it "concatenates together the notes of the task" do
          expect(subject.notes).to eq "line one of a note\nline two of a note"
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
  end
end
