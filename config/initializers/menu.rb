Rails.cache.clear("menu_items_all") if File.exist?(File.expand_path('tmp/cache',Rails.root))

MENU_CONFIG = YAML.load_file(File.expand_path("config/menu.yml",Rails.root))
