module QuakeLog
  module FileReader 
    #Kill: 2 3 7: Isgalamido killed Mocinha by MOD_ROCKET_SPLASH
    def get_kill_stats(line)
      return nil unless line.include?("killed")

      array_line = line.split(" ")
      index = array_line.index("killed")
      k_index = index - 1
      v_index = index + 1
      m_index = array_line.size - 1

      { killer: array_line[k_index], victim: array_line[v_index], mode: array_line[m_index] }
    end

    #InitGame: \sv_floodProtect\1\sv_maxPing\0\sv_minPing\0\sv_maxRate\10000\sv_minRate\0\sv_hostname\Code Miner Server\g_gametype\0\sv_privateClients\2\sv_maxclients\16\sv_allowDownload\0\dmflags\0\fraglimit\20\timelimit\15\g_maxGameClients\0\capturelimit\8\version\ioq3 1.36 linux-x86_64 Apr 12 2009\protocol\68\mapname\q3dm17\gamename\baseq3\g_needpass\0
    def get_start_match(line)
      return false unless line.include?("InitGame:")

      true
    end

    #ClientUserinfoChanged: 2 n\Isgalamido\t\0\model\uriel/zael\hmodel\uriel/zael\g_redteam\\g_blueteam\\c1\5\c2\5\hc\100\w\0\l\0\tt\0\tl\0
    def get_player(line)
      return "" unless line.include?("ClientUserinfoChanged")
      player = line[/n\\(.*?)\\t/].gsub("n\\","").gsub("\\t","")

      player
    end

    def unimportant_line(line)
      ["InitGame","killed","ClientUserinfoChanged"].each do |element|
        return false if line.include?(element)
      end

      true
    end
  end
end