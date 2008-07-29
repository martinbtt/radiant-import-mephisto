require File.dirname(__FILE__) + '/../spec_helper'

describe MephistoSection do
  before(:each) do
    @mephisto_section = MephistoSection.new
  end

  it "should be valid" do
    @mephisto_section.should be_valid
  end
end
