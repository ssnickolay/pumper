module Command
  class GemInstallCommand < BaseCommand
    def cancel
      Command::GemUninstallCommand.new(rvm_prefix, { gem_name: options[:gem_name] }).execute
    end

    def name
      clean "#{ rvm_prefix } gem install ./pkg/#{ options[:gem_file_name] }"
    end
  end
end