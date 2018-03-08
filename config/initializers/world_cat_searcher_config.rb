# Try to load a local version of the config file if it exists - expected to be in quick_search_root/config/searchers/catalog_config.yml
if File.exists?(File.join(Rails.root, "/config/searchers/world_cat_config.yml"))
  config_file = File.join Rails.root, "/config/searchers/world_cat_config.yml"
else
  # otherwise load the default config file
  config_file = File.expand_path("../../world_cat_config.yml", __FILE__)
end
QuickSearch::Engine::WORLD_CAT_CONFIG = YAML.load(ERB.new(File.read(config_file)).result)[Rails.env]
