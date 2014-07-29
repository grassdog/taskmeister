require "pathname"

module Taskmeister
  module Cli
    class TaskListName
      def self.from_project_dir(dir)
        project_dir = find_project_dir(dir)

        return project_dir.basename.to_s + ".md" if project_dir
      end

      def self.find_project_dir(dir)
        return dir if dir.children.any? { |child| is_project_dir?(child) }

        return nil if dir == Pathname.new("/") || dir.parent.nil?

        return self.find_project_dir(dir.parent)
      end

      def self.is_project_dir?(dir)
        dir.directory? && (
          dir.basename == Pathname.new(".git") ||
          dir.basename == Pathname.new(".hg")
        )
      end
    end
  end
end
