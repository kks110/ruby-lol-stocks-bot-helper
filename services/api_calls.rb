module Services
  class ApiCalls
    def self.load_teams
      puts "#{ENV['SERVER_IP']}/teams"
      response = HTTParty.get("#{ENV['SERVER_IP']}/teams")
      JSON.parse(response.body).each_with_object([]) do |team, team_list|
        team_list << team['name']
      end
    end

    def self.record_history
      HTTParty.post("#{ENV['SERVER_IP']}/take_snapshot")
    end

    def self.log_game(game)
      options = {
        :body => game,
        :headers => { 'Content-Type' => 'application/json' },
      }

      HTTParty.post(
        "#{ENV['SERVER_IP']}/register_game",
        options
      )
    end
  end
end

