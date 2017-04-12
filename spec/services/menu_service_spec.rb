require 'rails_helper'


RSpec.describe MenuItems, type: :service do
  Rails.cache.clear("menu_items_all") #if File.exist?('tmp/cache')
  MENU_CONFIG_TEST =  [
      {
        "name" => "title_du_menu1_test",
        "title" => "Titre du menu1 test",
        "ability_action" => "read",
        "ability_object" => "admin",
        "url" => "#",
        "path" => "admin_configurable_path",
        "login_required" => true,
        "dropdown" => false
      },
      {
          "name" => "title_du_menu2_test",
          "title" => "Titre du menu2 test",
          "ability_action" => "read",
          "ability_object" => "admin",
          "url" => "#",
          "login_required" => true,
          "dropdown" => false
      },
      {
          "name" => "title_du_menu3_test",
          "title" => "Titre du menu3 test",
          "ability_action" => "read",
          "ability_object" => "admin",
          "url" => "#",
          "login_required" => true,
          "dropdown" => false,
          "items" =>[
                {
                    "name" => "title_du_drop_menu1_test",
                    "title" => "Titre du drop menu1 test",
                    "ability_action" => "read",
                    "ability_object" => "admin",
                    "url" => "#",
                    "login_required" => true,
                    "dropdown" => false
                }
              ]
      }
  ]

   # require "byebug"
   # byebug

  describe "return menu object" do
    before :each do
      @all_items = MenuItems.all(MENU_CONFIG_TEST)
    end

    it "load names" do
      expect(@all_items.first.name).to eq("title_du_menu1_test")
    end
    it "load title" do
      expect(@all_items.first.title).to eq("Titre du menu1 test")
    end

    it "load abilities" do
      expect(@all_items.first.ability_action).to eq(:read)
      expect(@all_items.first.ability_object).to eq(:admin)
    end

    it "load sub menu" do
      expect(@all_items[2].items.first.name).to eq("title_du_drop_menu1_test")
    end

    it "set link to path unless url is present" do
      expect(@all_items.first.link).to eq("/admin/configurable")
      expect(@all_items[1].link).to eq("#")
    end

  end
end