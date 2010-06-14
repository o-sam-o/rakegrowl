require 'spec_helper'

describe 'used to test rake running a failing spec' do

  it 'should fail' do
    true.should == false
  end

end
