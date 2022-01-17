module Services
  class ApiCalls
    SERVER_ADDRESS = ENV['SERVER_IP']
    def self.load_teams
      puts "#{SERVER_ADDRESS}/teams"
      response = HTTParty.get("#{SERVER_ADDRESS}/teams")
      JSON.parse(response.body).each_with_object([]) do |team, team_list|
        team_list << team['name']
      end
    end

    def self.record_history
      HTTParty.post("#{SERVER_ADDRESS}/take_snapshot")
    end

    def self.log_game(game)
      options = {
        :body => game.to_json,
        :headers => { 'Content-Type' => 'application/json' },
      }

      HTTParty.post(
        "#{SERVER_ADDRESS}/register_game",
        options
      )
    end
  end
end
