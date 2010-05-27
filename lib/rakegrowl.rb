module Rakegrowl
  
  GEM_PATH = File.expand_path(File.join(File.dirname(__FILE__), '..'))
  COMPLETE_IMG = File.join(GEM_PATH, 'img', 'complete.png')
  ABORT_IMG = File.join(GEM_PATH, 'img', 'abort.png')
  
  module Growl
    def self.growlnotify
      `which growlnotify`.chomp
    end

    def self.exists?
      !growlnotify.empty?
    end

    def self.notify(title, message, img_name=nil)
      command = "#{growlnotify} -t \"#{title}\" -m \"#{message}\""
      command << " --image \"#{img_name}\"" if img_name
      Kernel.system(command) if exists?
    end
  end
  
  def self.enhance_tasks
    if Growl.exists?
      Rake::Task.tasks.each do |task|
        task.enhance do
          Growl.notify "Rake", "Task #{task.name} finished", COMPLETE_IMG if Rake.application.top_level_tasks.include?(task.name)
        end
      end
    end
  end
  
  def self.notify_fail(top_level_tasks)
    Growl.notify "Rake", "Task #{top_level_tasks} failed", ABORT_IMG
  end  
  
  class OutputCatcher
    
    attr_accessor :messages
    
    def initialize(out)
      @out = out
      @messages = []
    end  
    
    def puts(message)
      @messages << message
      # Ensure no memory bloat
      @messages.take(1) if @messages.size > 99
      
      @out.puts message
    end  
    
    def method_missing(m, *args)
      @out.send(m, *args)
    end
    
    def respond_to?(*args)
      @out.respond_to?(*args)
    end    
  end  
  
end

Rake::Application.class_eval do
  def top_level_with_growl
    #output_catcher = Rakegrowl::OutputCatcher.new($>)
    #$> = output_catcher

    Rakegrowl.enhance_tasks
    begin
      top_level_without_growl
    rescue SystemExit
      Rakegrowl.notify_fail(top_level_tasks)
    end
  end
  
  
  alias_method :top_level_without_growl, :top_level
  alias_method :top_level, :top_level_with_growl
end
