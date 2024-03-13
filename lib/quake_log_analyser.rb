# frozen_string_literal: true

module QuakeLog
  module Analyser
    def insert_stats(stats, type)
      return nil if stats.to_s.empty?

      add_kill_values(stats) if type == "kill"
      add_player(stats) if type == "player"
    end

    def add_player(player)
      @@players << player
    end

    #{ killer: array_line[k_index], victim: array_line[v_index], mode: array_line[m_index] }
    def add_kill_values(kill_stats)
      @@total_kills += 1
      @@kills_by_cause[kill_stats[:mode]] = @@kills_by_cause[kill_stats[:mode]].to_i + 1

      if kill_stats[:killer] == "<world>"
        @@kills[kill_stats[:victim].to_sym] = @@kills[kill_stats[:victim].to_sym].to_i - 1
      else
        @@kills[kill_stats[:killer].to_sym] = @@kills[kill_stats[:killer].to_sym].to_i + 1
      end
    end

    def reset_stats(game_number)
      @@match = "game_#{game_number}"
      @@players = []
      @@kills = {}
      @@total_kills = 0
      @@kills_by_cause = {}
    end

    def parse_total_kills
      {
        @@match => {
          total_kills: @@total_kills,
          players: @@players.uniq,
          kills: @@kills,
          kills_by_means: @@kills_by_cause
        }
      }
    end

    def show_stats
      print "#{parse_total_kills}\n\n"
    end
  end
end