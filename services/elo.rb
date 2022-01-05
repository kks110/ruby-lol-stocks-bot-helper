module Services
  class Elo
    def self.calculate_elo(winning_team_elo, loosing_team_elo, k_factor)
      winner_expected = expected_score(winning_team_elo, loosing_team_elo)
      loser_expected = expected_score(loosing_team_elo, winning_team_elo)

      new_winner_elo = elo_calculation(winning_team_elo, winner_expected, true, k_factor)
      new_looser_elo = elo_calculation(loosing_team_elo, loser_expected, false, k_factor)
      [new_winner_elo, new_looser_elo]
    end

    def self.transformed_elo(elo)
      10**(elo / 400.0)
    end

    def self.expected_score(player_rating, opponent_rating)
      transformed_elo(player_rating) / (transformed_elo(player_rating) + transformed_elo(opponent_rating))
    end

    def self.elo_calculation(player_elo, expected_elo, win, k_factor = 16)
      i = win ? 1.0 : 0.0
      (player_elo + k_factor * (i - expected_elo)).round
    end

    private_class_method :transformed_elo, :expected_score, :elo_calculation
  end
end
