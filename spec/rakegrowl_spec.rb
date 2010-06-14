require 'spec_helper'

describe Rakegrowl::Growl do
  
  describe "exists?" do
    
    it "should return true if growlnotify is installed in the system" do
      Rakegrowl::Growl.stub!(:`).with("which growlnotify").and_return("/wadus/bin/growlnotify\n")
      Rakegrowl::Growl.exists?.should be_true
    end
    
    it "should return false if growlnotify is not installed in the system" do
      Rakegrowl::Growl.stub!(:`).with("which growlnotify").and_return("\n")
      Rakegrowl::Growl.exists?.should be_false
    end
    
  end
  
  describe "notify" do
    
    it "should call growlnotify with title, message and image" do
      Rakegrowl::Growl.stub!(:`).with("which growlnotify").and_return("/wadus/bin/growlnotify\n")
      Kernel.should_receive(:system).with("/wadus/bin/growlnotify -t \"wadus\" -m \"wadus wadus\" --image \"image_path\"").once
      Rakegrowl::Growl.notify("wadus", "wadus wadus", 'image_path')
    end
    
    it "should call growlnotify with title, message and no image" do
      Rakegrowl::Growl.stub!(:`).with("which growlnotify").and_return("/wadus/bin/growlnotify\n")
      Kernel.should_receive(:system).with("/wadus/bin/growlnotify -t \"wadus\" -m \"wadus wadus\"").once
      Rakegrowl::Growl.notify("wadus", "wadus wadus")
    end
    
    
    it "should not call anything if growlnotify is not installed in the system" do
      Rakegrowl::Growl.stub!(:`).with("which growlnotify").and_return("\n")
      Kernel.should_not_receive(:system)
      Rakegrowl::Growl.notify("wadus", "wadus wadus")
    end
    
  end
  
end

describe "rakegrowl" do
  
  before(:each) do
    Rakegrowl::Growl.stub!(:notify => true, :exists? => true)
    clear_tasks
  end
  
  it "should notify when the main task ends" do
    Rakegrowl::Growl.should_receive(:notify).with("Rake", "Task main finished", Rakegrowl::COMPLETE_IMG).once
    run_tasks "main"
  end
  
  it "should not notify when a dependency task ends" do
    Rakegrowl::Growl.should_not_receive(:notify).with("Rake", "Task pre finished", Rakegrowl::COMPLETE_IMG)
    run_tasks "main"    
  end
  
  it "should notify when each main task ends" do
    Rakegrowl::Growl.should_receive(:notify).with("Rake", "Task main finished", Rakegrowl::COMPLETE_IMG).once
    Rakegrowl::Growl.should_receive(:notify).with("Rake", "Task main2 finished", Rakegrowl::COMPLETE_IMG).once
    run_tasks "main", "main2"
  end
  
  it "should notify when a task fails" do
    Rakegrowl::Growl.should_receive(:notify).with("Rake", "Task buggy failed", Rakegrowl::ABORT_IMG)
    run_tasks "buggy"
  end
  
  it "should notify when a subtask fails" do
    Rakegrowl::Growl.should_receive(:notify).with("Rake", "Task call_multi_with_buggy failed", Rakegrowl::ABORT_IMG)
    run_tasks "call_multi_with_buggy"
  end  
  
  it "should work with namespaced tasks" do
    Rakegrowl::Growl.should_not_receive(:notify).with("Rake", "Task wadus:wadus finished", Rakegrowl::COMPLETE_IMG).once
    run_tasks "wadus:wadus"
  end
  
  context 'running rspecs' do
    it 'should output the spec counts on pass' do
      pending
      Rakegrowl::Growl.should_receive(:notify).with("Rake", "Task passing_spec:spec finished\n1 example, 0 failures", Rakegrowl::COMPLETE_IMG).once
      run_tasks "passing_spec:spec"    
    end  
    
    it 'should output the spec counts on failure' do
      pending
      Rakegrowl::Growl.should_receive(:notify).with("Rake", "Task failing_spec:spec failed\n1 example, 1 failure", Rakegrowl::ABORT_IMG).once
      run_tasks "failing_spec:spec"    
    end    
  end  
  
end