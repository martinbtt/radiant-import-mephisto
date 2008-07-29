class MephistoUser < ActiveRecord::Base
  self.abstract_class   = true
  establish_connection :mephisto
  set_table_name       :users
  
  class << self
    attr_accessor :id_mappings
    id_mappings     = {}
    
  end
    
  def to_user
    password = 'radiant'
    User.new(
       :login      => login,
       :name       => login,
       :email      => email,
       :created_at => created_at,
       :updated_at => updated_at,
       :admin      => admin, 
       :notes      => 'Imported from Mephisto',
       :password   => password,
       :password_confirmation => password
     )
  end
  
end
