class MenuItems
  MENU_CONFIG = YAML.load_file(File.expand_path("config/menu.yml",Rails.root))

  attr_accessor :name,
                :icon,
                :ability_action,
                :ability_object,
                :link,
                :path,
                :url,
                :link,
                :login_required
  # def initialize(name, ability)
  #   @name = name
  #   @ability = ability
  # end

  def initialize(h)
    h.each {|k,v| public_send("#{k}=",v)}
    self.ability_action = h["ability_action"].parameterize.underscore.to_sym
    self.ability_object = h["ability_object"].parameterize.underscore.to_sym
    self.login_required = h["login_required"]

    # set link to path unless url is present
    self.path ? self.link = eval('Rails.application.routes.url_helpers.'+self.path) : self.link = self.url
  end


  def self.all
    all_items = []
    MenuItems::MENU_CONFIG.values.each do |item|
     all_items << MenuItems.new(item)
    end
    all_items
  end

  def login_not_required
    !self.login_required
  end

end