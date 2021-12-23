module Services
  class DataAccess
    def self.load_teams
      file = File.read('./data/teams.json')
      JSON.parse(file)
    end

    def self.save_teams(teams)
      File.open('./data/teams.json',"w") do |f|
        f.write(teams.to_json)
      end
    end

    def self.load_all_games
      file = File.read('./data/games.json')
      JSON.parse(file)
    end

    def self.load_weekly_games
      file = File.read('./data/weekly_games.json')
      JSON.parse(file)
    end
  end
end

