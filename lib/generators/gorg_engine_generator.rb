require 'rails/generators/active_record'

module GorgEngine
  module Generators
    class InstallGenerator < ::Rails::Generators::Base
      include Rails::Generators::Migration

      source_root File.expand_path('../templates', __FILE__)

      # ...

      def copy_migrations
        copy_migration "init_gorg_engine"
      end


      protected

      def self.next_migration_number(path)
        @migration_number = Time.now.utc.strftime("%Y%m%d%H%M%S").to_i.to_s
      end

      def copy_migration(filename)
        if self.class.migration_exists?("db/migrate", "#{filename}")
          say_status("skipped", "Migration #{filename}.rb already exists")
        else
          migration_template "migrations/#{filename}.rb", "db/migrate/#{filename}.rb"
          puts "#######################################"
          puts "You HAVE TO edit db/migrate/#{filename}.rb to avoid conflict with your current migration"
          puts "For each table and for each column : check if exist in your current project, and comment the line if needed."
        end
      end
    end
  end
end