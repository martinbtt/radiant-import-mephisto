namespace :radiant do
  namespace :extensions do
    namespace :import_mephisto do
      
      desc "Import the contents of the mephisto database into Radiant"
      task :run => :environment do
        MephistoImport.all
      end
      
      desc "Runs the migration of the Import Mephisto extension"
      task :migrate => :environment do
        require 'radiant/extension_migrator'
        if ENV["VERSION"]
          ImportMephistoExtension.migrator.migrate(ENV["VERSION"].to_i)
        else
          ImportMephistoExtension.migrator.migrate
        end
      end
      
      desc "Copies public assets of the Import Mephisto to the instance public/ directory."
      task :update => :environment do
        is_svn_or_dir = proc {|path| path =~ /\.svn/ || File.directory?(path) }
        Dir[ImportMephistoExtension.root + "/public/**/*"].reject(&is_svn_or_dir).each do |file|
          path = file.sub(ImportMephistoExtension.root, '')
          directory = File.dirname(path)
          puts "Copying #{path}..."
          mkdir_p RAILS_ROOT + directory
          cp file, RAILS_ROOT + path
        end
      end  
    end
  end
end
