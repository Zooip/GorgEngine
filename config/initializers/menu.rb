class MenuItems
  MENU_CONFIG = YAML.load_file(File.expand_path("config/menu.yml",Rails.root))

  # menu items are cached, we clear this cache when booting the apps
  Rails.cache.clear("menu_items_all")

  attr_accessor :id,
                :name,
                :icon,
                :ability_action,
                :ability_object,
                :link,
                :path,
                :url,
                :link,
                :login_required,
                :dropdown,
                :items

  def initialize(h)

    h.each {|k,v| public_send("#{k}=",v)}
    self.ability_action = h["ability_action"].parameterize.underscore.to_sym
    self.ability_object = h["ability_object"].parameterize.underscore.to_sym
    self.login_required = h["login_required"]

    # items is a Menu item collection
    self.items = []
    if h["items"]
      h["items"].values.each do |item|
        self.items << MenuItems.new(item)
      end
    end

    # set link to path unless url is present
    self.path ? self.link = eval('Rails.application.routes.url_helpers.'+self.path) : self.link = self.url

    # set menu id
    self.id = self.name.parameterize.underscore
  end


  def self.all
    Rails.cache.fetch("menu_items_all") do
      all_items = []
      MenuItems::MENU_CONFIG.values.each do |item|
       all_items << MenuItems.new(item)
      end
      all_items
    end
  end

  def login_not_required
    !self.login_required
  end

end