module Command
  class GemUninstallCommand < BaseCommand
    def cancel
      puts "WARNING: You must reinstall gem #{ options[:gem_name] }"
    end

    def name
      clean "#{ rvm_prefix } gem uninstall #{ options[:gem_name] } --all -x"
    end
  end
end