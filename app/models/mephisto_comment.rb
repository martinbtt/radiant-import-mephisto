class MephistoComment < ActiveRecord::Base
  self.abstract_class = true
  establish_connection "mephisto"
  set_table_name :contents
  self.inheritance_column = nil
  
  belongs_to :article, :conditions => ["type = ?",'Article'], :class_name => 'MephistoArticle', :foreign_key => 'article_id'

  # fake STI
  def self.find(*args)
    with_scope(:find=>{ :conditions=> {:type => 'Comment'} }) do
      super(*args)
    end
  end 
  
  def to_comment
    Comment.new(
       :author       => author,
       :author_url   => author_url,
       :author_email => author_email.blank? ? 'anon@anon.com' : author_email,
       :author_ip    => author_ip,
       :content      => body,
       :content_html => body_html,
       :created_at   => created_at,
       :updated_at   => updated_at,
       :user_agent   => user_agent,
       :referrer     => referrer,
       :approved_at  => published_at
     ) 
  end
  
end
