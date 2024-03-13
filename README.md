# Quake Log Parser

It is a parser to read and analyse a QuakeIII Arena log to get statistics.

It gives you the players, the kils, the means of death separated by match:

    $ {"game_14"=>{:total_kills=>122, :players=>["Isgalamido", "Dono da Bola", "Zeh", "Oootsimo", "Chessus", "Assasinu Credi", "Mal"], :kills=>{:Isgalamido=>22, :Chessus=>7, :Mal=>-2, :Oootsimo=>9, :Credi=>12, :Bola=>9, :Zeh=>5, :Dono=>-7, :Assasinu=>-5}, :kills_by_means=>{"MOD_RAILGUN"=>20, "MOD_TRIGGER_HURT"=>31, "MOD_ROCKET"=>23, "MOD_ROCKET_SPLASH"=>24, "MOD_MACHINEGUN"=>4, "MOD_BFG_SPLASH"=>10, "MOD_FALLING"=>5, "MOD_BFG"=>5}}}

## Execution

It is just to execute the command on the bin folder given the path of the log file: 

    $ ./bin/parse-log file-path

There is an log file example in the `example` folder

## Development

It was created as a ruby project.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/viniciustferreira/quake_log_parser.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
