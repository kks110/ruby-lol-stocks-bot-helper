class Program
  def initialize
    @running = true
    @clear_screen = false
  end

  def run
    while running
      clear_screen = false
      CLI::UI::Frame.open('Lol Stocks Bot Helper') do
        command = Commands::MainMenu.new.run

        case command
        when 'Validate weekly games'
          validate_weekly_games
        when 'Log weekly games'
          log_weekly_games
        when 'Initial Elo calculation'
          Services::InitialEloCalculation.run
        when 'Clear screen'
          clear_screen = true
        when 'Quit'
          return
        end
      end
      system('clear') || system('cls') if clear_screen
    end
  end

  private

  attr_accessor :running, :clear_screen

  def validate_weekly_games
    game_validation = ''

    CLI::UI::Spinner.spin('Loading Team List...') do
      game_validation = Commands::ValidateWeeklyGames.new
    end

    games_are_valid = ''
    CLI::UI::Spinner.spin('Validating...') do
      games_are_valid = game_validation.valid?
    end

    if games_are_valid
      puts CLI::UI.fmt '{{v}} {{green:Games are all valid}}'
    else
      puts CLI::UI.fmt '{{x}} {{red:Games are not valid}}'
      game_validation.find_error
    end
  end

  def log_weekly_games
    CLI::UI::Spinner.spin('Taking history snapshot...') do
      Services::ApiCalls.record_history
    end
    games = Services::DataAccess.load_weekly_games['games']

    CLI::UI::Spinner.spin('Logging Games...') do
      games.each do |game|
        Services::ApiCalls.log_game(game)
      end
    end
    puts CLI::UI.fmt '{{v}} {{green:Games logged successfully}}'
  end
end
