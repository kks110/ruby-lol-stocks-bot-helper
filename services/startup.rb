module Services
  class Startup
    def initialize; end

    def pull_team_list
      CLI::UI::Spinner.spin('Pulling Team List...') do
        teams = ApiCalls.load_teams
        DataAccess.save_teams(teams)
      end
    end
  end
end
