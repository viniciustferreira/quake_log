# frozen_string_literal: true
require_relative "quake_log_parser/version"
require_relative 'quake_log_file_reader.rb'
require_relative 'quake_log_analyser.rb'

module QuakeLog
  class Parser
    extend QuakeLog::FileReader
    extend QuakeLog::Analyser

    def self.call(file_path)
      game_number = 1
      reset_values(game_number)
      File.open(file_path).each do |line|
        next if unimportant_line(line)

        insert_stats(get_kill_stats(line), "kill") 
          
        if get_start_match(line)
          puts show_totals
          reset_values(game_number += 1)
        end
      end
    end
  end
end


QuakeLog::Parser.call(File.dirname(__FILE__) + "/qgames.log")