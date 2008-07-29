class MephistoTagging < ActiveRecord::Base
  self.abstract_class = true
  establish_connection "mephisto"
  set_table_name :taggings

  has_many :tag, :class_name => 'MephistoTag',
  :finder_sql =>  'SELECT tags.* FROM tags INNER JOIN taggings ON tags.id = taggings.tag_id where taggings.id=#{id}'
end