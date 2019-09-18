Rails.cache.clear("menu_items_all") if File.exist?(File.expand_path('tmp/cache',Rails.root))

class MenuItems
  MENU_CONFIG = YAML.load_file(Rails.root.join("config", "menu.yml"))
end
