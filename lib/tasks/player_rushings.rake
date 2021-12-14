namespace :player_rushing do
  task :import, [:rushings_json_path] => :environment do |_, args|
    rushings_json = File.read(args[:rushings_json_path])
    rushings_list = JSON.parse(rushings_json)

    rushings_list.each do |rushing_data|
      PlayerRushing.create(
        player_name: rushing_data["Player"],
        team_name: rushing_data["Team"],
        player_position: rushing_data["Pos"],
        rushing_attempts: rushing_data["Att"],
        avg_rushing_attempts_per_game: rushing_data["Att/G"],
        total_rushing_yards: rushing_data["Yds"],
        avg_yards_per_attempt: rushing_data["Avg"],
        yards_per_game: rushing_data["Yds/G"],
        total_touchdowns: rushing_data["TD"],
        longest_rush: rushing_data["Lng"],
        first_downs: rushing_data["1st"],
        first_downs_percentage: rushing_data["1st%"],
        twenty_yards_rushes: rushing_data["20+"],
        fourty_yards_rushes: rushing_data["40+"],
        fumbles: rushing_data["FUM"]
      )
    end
  end

  task :clear, [] => :environment do |_, args|
    PlayerRushing.destroy_all
  end
end