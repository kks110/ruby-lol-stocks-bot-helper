module Commands
  class MainMenu
    def initialize; end

    def run
      CLI::UI.ask(
        'What would you like to do?',
        options: [
          'Validate weekly games',
          'Log weekly games',
          'Initial Elo calculation',
          'Clear screen',
          'Quit'
        ]
      )
    end
  end
end
