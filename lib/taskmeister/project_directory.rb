require "pathname"

module Taskmeister
  class ProjectDirectory
    def self.list_name_for(dir)
      return list_name(dir) if dir.children.any? { |child|
        child.directory? && is_project_dir?(child)
      }

      return nil if dir == Pathname.new("/") || dir.parent.nil?

      return self.list_name_for(dir.parent)
    end

    def self.is_project_dir?(dir)
      dir.basename == Pathname.new(".git") || dir.basename == Pathname.new(".hg")
    end

    def self.list_name(dir)
      dir.basename.sub_ext(".md")
    end
  end
end
