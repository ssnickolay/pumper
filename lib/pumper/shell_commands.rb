module Pumper
  module ShellCommands
    def gem_rebuild
      add('rm -rf pkg')
      add('bundle exec rake build')
    end

    def gem_uninstall(gem_name)
      add("gem uninstall #{ gem_name} --all -x", :rvm)
    end

    def gem_install(specification)
      add("gem install ./pkg/#{ specification.gem_file_name }", :rvm)
    end

    def gem_install_to_vendor
      add("cp pkg/* #{ project.path }/vendor/cache")
      add("cd #{ project.path }")
      add('bundle install --local', :rvm)
    end
  end
end