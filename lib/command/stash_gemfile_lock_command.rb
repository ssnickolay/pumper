module Command
  class StashGemfileLockCommand < BaseCommand
    def cancel
      system('mv ./Gemfile.lock.stash ./Gemfile.lock')
    end

    def name
      'mv ./Gemfile.lock ./Gemfile.lock.stash'
    end
  end
end