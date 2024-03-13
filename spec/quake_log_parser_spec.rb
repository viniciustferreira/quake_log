# frozen_string_literal: true

RSpec.describe QuakeLog::Parser do
  describe "call" do
    before do
      @parser = QuakeLog::Parser
      @output = StringIO.new
      @normal_response =
        "{\"game_1\"=>{:total_kills=>4, :players=>[\"Dono da Bola\", \"Mocinha\", \"Isgalamido\", \"Zeh\"], "\
        ":kills=>{:Isgalamido=>1, :Zeh=>-2, :Dono=>-1}, "\
        ":kills_by_means=>{\"MOD_ROCKET\"=>1, \"MOD_TRIGGER_HURT\"=>2, \"MOD_FALLING\"=>1}}}\n\n"
      @broken_response =
        "{\"game_1\"=>{:total_kills=>11, :players=>[\"Isgalamido\", \"Dono da Bola\", \"Mocinha\"], "\
        ":kills=>{:Isgalamido=>-5}, "\
        ":kills_by_means=>{\"MOD_TRIGGER_HURT\"=>7, \"MOD_ROCKET_SPLASH\"=>3, \"MOD_FALLING\"=>1}}}\n\n"
    end

    it "receives a wrong file path" do
      expect { @parser.call("wrong") }.to raise_error(Errno::ENOENT)
    end

    it "receives a path to a file with normal match end" do
      file_path = "#{File.dirname(__FILE__)}/files/normal_end.log"

      expect { @parser.call(file_path) }.to output(@normal_response).to_stdout
    end

    it "receives a path to a file with a broken match end" do
      file_path = "#{File.dirname(__FILE__)}/files/broken_end.log"

      expect { @parser.call(file_path) }.to output(@broken_response).to_stdout
    end
  end
end
