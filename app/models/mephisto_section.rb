class MephistoSection < ActiveRecord::Base
  self.abstract_class = true
  establish_connection "mephisto"
  set_table_name :sections
  
end
