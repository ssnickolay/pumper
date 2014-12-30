module Command
  class GemInstallToVendorCommand < BaseCommand
    def cancel
      Command::GemUninstallCommand.new(rvm_prefix, { gem_name: options[:gem_name] }).execute
    end

    def name
      clean "cp pkg/* #{ options[:project_path] }/vendor/cache && cd #{ options[:project_path] } && #{ rvm_prefix } bundle install --local"
    end
  end
end