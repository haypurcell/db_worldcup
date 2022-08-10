# db_worldcup
Worldcup Database Project (freecodecamp)

Project Requirements:
  
	-Create database names "worldcup"
	
	-Create table named "teams" --> should end up with 24 rows total
		-Make the following columns:
			-team_id --> serial, primary key
			-name --> varchar, unique
	
	-Create table named "games" --> Should end up with 32 rows total
	    -Make the following columns:
	      -game_id --> serial, primary key
	      -year --> int
	      -round --> varchar
	      -winner_goals --> int
	      -opponent_goals --> int
	    -Add the following foreign key columns
	      -winner_id --> ref teams.team_id
	      -opponent_id --> ref teams.team_id
			
	-ALL columns must be NOT NULL
	
	-Both .sh files should have executable permissions
	
	-Correctly complete queries in queries.sh
		Output must match contents of expected_output.txt (provided file)
		 
	-Create insert_data.sh script
	    -Script should add each unique team to "teams" table
	    -Should also insert a row into "games" table for each line in games.csv (provided file)
	    -Make sure of correct ID's from "teams" table (don't hardcode!)
