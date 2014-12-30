module Command
  class GemUninstallCommand
    def cancel
      puts "WARNING: You must reinstall gem #{ options[:gem_name] }"
    end

    def name
      "#{ rvm_prefix } gem uninstall #{ options[:gem_name] } --all -x"
    end
  end
end