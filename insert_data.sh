#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.

echo $($PSQL "truncate teams, games")

# insert into teams and games
cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS
do
  if [[ $YEAR != "year" ]]
  then
    # get team_id (winner)
    TEAM_ID_WINNER=$($PSQL "select team_id from teams where name='$WINNER'")
    # if not found
    if [[ -z $TEAM_ID_WINNER ]]
    then
      # insert team_id (winner)
      INSERT_WINNER_RESULT=$($PSQL "insert into teams(name) values('$WINNER')")
      if [[ $INSERT_WINNER_RESULT == "INSERT 0 1" ]]
      then
        echo Inserted winner into teams, $WINNER
      fi
    fi

    # get team_id (opponent)
    TEAM_ID_OPPONENT=$($PSQL "select team_id from teams where name='$OPPONENT'")
    # if not found
    if [[ -z $TEAM_ID_OPPONENT ]]
    then
    #insert team_id (opponent)
     INSERT_OPPONENT_RESULT=$($PSQL "insert into teams(name) values('$OPPONENT')")
      if [[ $INSERT_OPPONENT_RESULT == "INSERT 0 1" ]]
      then
        echo Inserted opponent into teams, $OPPONENT
      fi
    fi
    # get new team_id
    TEAM_ID=$($PSQL "select team_id from teams where name='$WINNER' or name='$OPPONENT'")

    # define team_id
    TEAM_ID_WINNER=$($PSQL "select team_id from teams where name='$WINNER'")
    TEAM_ID_OPPONENT=$($PSQL "select team_id from teams where name='$OPPONENT'")

    # insert game
    INSERT_GAME_RESULT=$($PSQL "insert into games(year,round,winner_id,opponent_id,winner_goals,opponent_goals) values($YEAR,'$ROUND',$TEAM_ID_WINNER,$TEAM_ID_OPPONENT,$WINNER_GOALS,$OPPONENT_GOALS)")
    if [[ $INSERT_GAME_RESULT == "INSERT 0 1" ]]
    then
      echo Inserted into games, $YEAR $ROUND
    fi
    fi


done
