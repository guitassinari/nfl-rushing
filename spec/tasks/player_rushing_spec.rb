require 'rails_helper'
require 'rake'

Rails.application.load_tasks

describe 'player_rushing tasks' do
  before do
    Rake::Task.define_task(:environment)
  end

  describe 'import' do
    let (:player_rushings_json_path) { 'spec/fixtures/rushing.json' }
    let (:run_rake_task) do
      Rake::Task["player_rushing:import"].invoke(player_rushings_json_path)
    end
    let(:rushings_in_json_file) do 
      rushings_json = File.read(player_rushings_json_path)
      JSON.parse(rushings_json)
    end

    it 'creates one player rushing for each rushing in the file' do
      run_rake_task

      expect(PlayerRushing.count).to eq(rushings_in_json_file.size)

      rushings_in_json_file.each do |rushing_json|
        rushing_record = PlayerRushing.find_by!(player_name: rushing_json["Player"])
        expect(rushing_record.player_name).to eq(rushing_json["Player"])
        expect(rushing_record.team_name).to eq(rushing_json["Team"])
        expect(rushing_record.player_position).to eq(rushing_json["Pos"])
        expect(rushing_record.rushing_attempts).to eq(rushing_json["Att"].to_i)
        expect(rushing_record.avg_rushing_attempts_per_game).to eq(rushing_json["Att/G"].to_f)
        expect(rushing_record.total_rushing_yards).to eq(rushing_json["Yds"].to_i)
        expect(rushing_record.avg_yards_per_attempt).to eq(rushing_json["Avg"].to_f)
        expect(rushing_record.yards_per_game).to eq(rushing_json["Yds/G"].to_f)
        expect(rushing_record.total_touchdowns).to eq(rushing_json["TD"].to_i)
        expect(rushing_record.longest_rush).to eq(rushing_json["Lng"].to_s)
        expect(rushing_record.first_downs).to eq(rushing_json["1st"].to_i)
        expect(rushing_record.first_downs_percentage).to eq(rushing_json["1st%"].to_f)
        expect(rushing_record.twenty_yards_rushes).to eq(rushing_json["20+"].to_i)
        expect(rushing_record.fourty_yards_rushes).to eq(rushing_json["40+"].to_i)
        expect(rushing_record.fumbles).to eq(rushing_json["FUM"].to_i)
      end
    end
  end

  describe 'clear' do
    let (:run_rake_task) do
      Rake::Task["player_rushing:clear"].invoke
    end
    let!(:player_rushings) { create_list(:player_rushing, 50) }

    it 'removes all player rushings from database' do
      expect(PlayerRushing.count).to eq(50)

      run_rake_task

      expect(PlayerRushing.count).to eq(0)
    end
  end
end