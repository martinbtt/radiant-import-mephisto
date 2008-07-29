class MephistoTag < ActiveRecord::Base
  self.abstract_class = true
  establish_connection "mephisto"
  set_table_name :tags

  belongs_to :taggings, :class_name => 'MephistoTagging', :foreign_key => 'tag_id'

end
