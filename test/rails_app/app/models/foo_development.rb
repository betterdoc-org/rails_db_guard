class FooDevelopment < ActiveRecord::Base
  self.table_name = "foos"
  establish_connection YAML.load(File.open(Rails.root.join("config/database.yml")).read)["development"]
end
