require 'rake/tasklib'

def msbuild(name=:msbuild, *args, &block)
  Albacore::MSBuildTask.new(name, *args, &block)
end
    
module Albacore
  class MSBuildTask < Albacore::AlbacoreTask    
    def execute(name, task_args)
      @msbuild = MSBuild.new
      @msbuild.load_config_by_task_name(name)
      @block.call(@msbuild, *task_args) unless @block.nil? 
      @msbuild.build
      fail if @msbuild.failed
    end    
  end
  
end
