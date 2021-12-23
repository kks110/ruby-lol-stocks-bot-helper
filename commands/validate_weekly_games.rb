module Commands
  class ValidateWeeklyGames
    def initialize
      @teams = Services::DataAccess.load_teams
      @weekly_games = Services::DataAccess.load_weekly_games['games']
    end

    def valid?
      weekly_games.each do |game|
        return false unless teams.include?(game['winner'])
        return false unless teams.include?(game['looser'])
      end
    end

    def find_error
      weekly_games.each do |game|
        puts "Team does not exist #{game['winner']}" unless teams.include?(game['winner'])
        puts "Team does not exist #{game['looser']}" unless teams.include?(game['looser'])
      end
    end

    private

    attr_reader :teams, :weekly_games
  end
end
