require File.dirname(__FILE__) + '/../spec_helper'

describe MephistoComment do
  before(:each) do
    @mephisto_comment = MephistoComment.new
  end

  it "should be valid" do
    @mephisto_comment.should be_valid
  end
end
