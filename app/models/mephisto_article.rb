class MephistoArticle < ActiveRecord::Base
  self.abstract_class = true
  establish_connection "mephisto"
  set_table_name :contents
  self.inheritance_column = nil
 
  has_many :comments, :conditions => ["type = ?",'Comment'], :class_name => 'MephistoComment', :foreign_key => 'article_id'
  
             
  has_many :tags, :class_name => 'MephistoTag', 
           :finder_sql => 'SELECT tags.* FROM tags  INNER JOIN taggings ON tags.id = taggings.tag_id   WHERE ((taggings.taggable_id = #{id}) AND (taggable_type="Content"))'

  has_many :sections, :class_name => 'MephistoSection', 
        :finder_sql => 'SELECT sections.* FROM sections  INNER JOIN assigned_sections ON sections.id = assigned_sections.section_id WHERE ((assigned_sections.article_id = #{id}))' 
        
        
  # fake STI
  def self.find(*args)
    with_scope(:find=>{ :conditions=> {:type => 'Article'} }) do
      super(*args)
    end
  end
  
  def tag_names
    tags.collect{|t| t.name}.join(',')
  end
  
  def section_names
    sections.collect{|t| t.name}.join(',')
  end
  
  def to_page
    UserActionObserver.current_user = User.find(MephistoUser.id_mappings[user_id])#bit of a hack 
    page = Page.new(
      :title           => title,
      :created_at      => created_at,
      :updated_at      => updated_at,
      :slug            => permalink,
      :status          => Status[:published],
      :breadcrumb      => title,
      :published_at    => published_at, 
      :enable_comments => true,
      :keywords        => [tag_names,section_names].join(',').split(',').uniq.compact.join(','),
      :created_by_id   => MephistoUser.id_mappings[user_id],
      :updated_by_id   => MephistoUser.id_mappings[updater_id]
    )
    filter_name = filter.gsub('_filter','').camelcase
    page.parts << PagePart.new(:name => 'body',  :filter_id =>  filter_name, :content => body )
    page
  end

  def self.find_all_published
    find(:all, :conditions => "published_at != ''")
  end

end
