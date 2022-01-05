require 'json'
require 'cli/ui'
require 'httparty'
require 'dotenv/load'
require 'pry'

require './program'
require './services/api_calls'
require './services/data_access'
require './services/startup'
require './services/initial_elo_calculation'
require './services/elo'
require './commands/validate_weekly_games'
require './commands/main_menu'

CLI::UI::StdoutRouter.enable
Dotenv.require_keys("SERVER_IP")

CLI::UI::Frame.open('Lol Stocks Bot Helper - Startup') do
  spin_group = CLI::UI::SpinGroup.new
  spin_group.add('Pulling Team List...') do |spinner|
    Services::Startup.new.pull_team_list
    spinner.update_title('Team List Pulled')
  end
  spin_group.wait
end

Program.new.run
