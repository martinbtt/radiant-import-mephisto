# Uncomment this if you reference any of your controllers in activate
# require_dependency 'application'

class ImportMephistoExtension < Radiant::Extension
  version "0.1"
  description "Import the contents of a Mephisto blog into Radiant"
  url "http://github.com/martinbtt/radiant-import-mephisto"
  
  # redirect old style routes to new. Example:
  # OLD:  http://www.beyondthetype.com/2008/1/3/new-rss-feed-url
  # NEW: http://www.beyondthetype.com/articles/2008/01/03/new-rss-feed-url/
  define_routes do |map|
      map.connect ':year/:month/:day/:slug', :controller => 'mephisto', :action => 'redirect', 
                  :year => /\d{4}/,  :month  => /\d{1,2}/, :day        => /\d{1,2}/
      
                   
    end
  
  def activate
    # admin.tabs.add "Import Mephisto", "/admin/import_mephisto", :after => "Layouts", :visibility => [:all]
  end
  
  def deactivate
    # admin.tabs.remove "Import Mephisto"
  end
  
end