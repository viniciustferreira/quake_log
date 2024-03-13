# frozen_string_literal: true
require_relative "quake_log_parser/version"
require_relative "quake_log_file_reader"
require_relative "quake_log_analyser"

module QuakeLog
  class Parser
    extend QuakeLog::FileReader
    extend QuakeLog::Analyser

    def self.call(file_path)
      game_number = 0
      match_end = false

      reset_stats(game_number)
      File.open(file_path).each do |line|
        next if unimportant_line?(line)

        if get_start_match(line)
          reset_stats(game_number += 1)
          match_end = false
        end

        insert_stats(get_kill_stats(line), "kill")
        insert_stats(get_player(line), "player")

        if get_end_match(line) && match_end == false
          match_end = true
          show_stats
        end
      end
    rescue Errno::ENOENT => e
      raise e, "file not found"
    end
  end
end
#QuakeLog::Parser.call(File.dirname(__FILE__) + "/qgames.log")