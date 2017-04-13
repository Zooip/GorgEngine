class MenuItems
  # menu items are cached, we clear this cache when booting the apps

  attr_accessor :name,
                :title,
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

    # items is a Menu item collection
    self.items = []
    if h["items"]
      h["items"].each do |item|
       self.items << MenuItems.new(item)
      end
    end

    # set link to path unless url is present
    self.path ?
        self.link = eval('Rails.application.routes.url_helpers.'+self.path) :
        self.link = self.url

  end


  def self.all(config_file = MenuItems::MENU_CONFIG)
    Rails.cache.fetch("menu_items_all") do
      config_file.map{|item| MenuItems.new(item) }
    end
  end

  def login_not_required?
    !self.login_required
  end

end