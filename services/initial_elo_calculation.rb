module Services
  class InitialEloCalculation
    def self.run
      k_factor = CLI::UI.ask(
        'K factor value? (16 is default)',
        options: [
          'default',
          '2',
          '4',
          '8'
        ]
      )

      k_factor = 16 if k_factor == 'default'
      k_factor = k_factor.to_i

      games = Services::DataAccess.load_all_games
      teams = Services::DataAccess.load_teams
      teams_and_elos = teams.each_with_object({}) do |team, hash|
        hash[team] = 500
      end

      games['game'].each do |game|
        next unless teams_and_elos.keys.include? game['winner']
        next unless teams_and_elos.keys.include? game['looser']

        winning_elo = teams_and_elos[game['winner']]
        loosing_elo = teams_and_elos[game['looser']]

        new_winning_elo, new_loosing_elo = Services::Elo.calculate_elo(winning_elo, loosing_elo, k_factor)
        teams_and_elos[game['winner']] = new_winning_elo
        teams_and_elos[game['looser']] = new_loosing_elo
      end

      teams_and_elos.sort_by {|_,v| -v}

      teams_and_elos.each do |team, elo|
        puts "#{team}: #{team.length == 2 ? " " : ""}#{elo}"
      end
    end
  end
end
