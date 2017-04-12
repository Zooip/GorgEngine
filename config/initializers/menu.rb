Rails.cache.clear("menu_items_all") if File.exist?('tmp/cache')

MENU_CONFIG = YAML.load_file(File.expand_path("config/menu.yml",Rails.root))