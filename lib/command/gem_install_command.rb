module Command
  class GemInstallCommand
    def cancel
      Command::GemUninstallCommand.new(rvm_prefix, { gem_name: options[:specification].name }).execute
    end

    def name
      "#{ rvm_prefix } gem install ./pkg/#{ options[:specification].gem_file_name }"
    end
  end
end