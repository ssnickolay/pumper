module Command
  class GemRebuildCommand
    def cancel
      system('rm -rf pkg')
    end

    def name
      'rm -rf pkg && bundle exec rake build'
    end
  end
end