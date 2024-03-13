module QuakeLog
  module Analyser

    def insert_stats(stats, type)
      return nil if stats.nil?

      add_kill_values(stats) if type == "kill"
    end

    #{ killer: array_line[k_index], victim: array_line[v_index], mode: array_line[m_index] }
    def add_kill_values(kill_stats)
      @@total_kills += 1
      @@players << kill_stats[:victim]

      unless kill_stats[:killer] == "<world>"
        @@kills[kill_stats[:killer].to_sym] = @@kills[kill_stats[:killer].to_sym].to_i + 1
      else
        @@kills[kill_stats[:victim].to_sym] = @@kills[kill_stats[:victim].to_sym].to_i - 1
      end
    end

    def reset_values(game_number)
      @@match = "game_#{game_number}"
      @@players = []
      @@kills = {}
      @@total_kills = 0
    end

    def show_totals
      {
        @@match => {
          total_kills: @@total_kills,
          players: @@players.uniq,
          kills: @@kills
        }
      }
    end
  end
end