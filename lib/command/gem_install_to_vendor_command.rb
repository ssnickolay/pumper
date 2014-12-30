module Command
  class GemInstallToVendorCommand
    def cancel
      Command::GemUninstallCommand.new(rvm_prefix, { gem_name: options[:specification].name }).execute
    end

    def name
      "cp pkg/* #{ path }/vendor/cache && cd #{ path } && #{ rvm_prefix } bundle install --local"
    end

    private

    def path
      options[:project].path
    end
  end
end