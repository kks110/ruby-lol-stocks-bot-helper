module Services
  class Elo
    def self.calculate_elo(winning_team_elo, loosing_team_elo)
      winner_expected = expected_score(winning_team_elo, loosing_team_elo)
      loser_expected = expected_score(loosing_team_elo, winning_team_elo)

      new_winner_elo = elo_calculation(winning_team_elo, winner_expected, true)
      new_looser_elo = elo_calculation(loosing_team_elo, loser_expected, false)
      [new_winner_elo, new_looser_elo]
    end

    private

    def transformed_elo(elo)
      10**(elo / 400.0)
    end

    def expected_score(player_rating, opponent_rating)
      transformed_elo(player_rating) / (transformed_elo(player_rating) + transformed_elo(opponent_rating))
    end

    def elo_calculation(player_elo, expected_elo, win)
      i = win ? 1.0 : 0.0
      k_factor = 16.0
      (player_elo + k_factor * (i - expected_elo)).round
    end
  end
end
