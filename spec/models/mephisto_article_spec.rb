require File.dirname(__FILE__) + '/../spec_helper'

describe MephistoArticle do
  before(:each) do
    @mephisto_article = MephistoArticle.new
  end

  it "should be valid" do
    @mephisto_article.should be_valid
  end
end
