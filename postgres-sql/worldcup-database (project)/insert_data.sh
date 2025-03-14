#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.

# Truncating Tables 
TRUNCATE_RESULT=$($PSQL "TRUNCATE teams, games")
if [[ $TRUNCATE_RESULT == "TRUNCATE TABLE" ]]
then
  echo -e "\nTables truncated"
fi

# Inserting data starts here
echo -e "\n~~ Inserting Teams ~~\n"

# loop through games file
cat "games.csv" | while IFS="," read YEAR ROUND WINNER OPPONENT W_GOALS O_GOALS
do
  if [[ $YEAR != "year" ]]
  then

    # 1. Insert team data -> teams table
  
    WINNER_ID=$($PSQL "SELECT team_id FROM teams WHERE name = '$WINNER'") 
    OPPONENT_ID=$($PSQL "SELECT team_id FROM teams WHERE name = '$OPPONENT'")

    if [[ -z $WINNER_ID ]]
    then
      # insert winner into teams
      INSERT_RESULT=$($PSQL "INSERT INTO teams(name) VALUES('$WINNER')")
      if [[ $INSERT_RESULT == "INSERT 0 1" ]]
      then
        echo "Inserted $WINNER into teams"
        WINNER_ID=$($PSQL "SELECT team_id FROM teams WHERE name = '$WINNER'")
      fi
    fi
    if [[ -z $OPPONENT_ID ]]
    then
      # insert opponent into teams
      INSERT_RESULT=$($PSQL "INSERT INTO teams(name) VALUES('$OPPONENT')")
      if [[ $INSERT_RESULT == "INSERT 0 1" ]]
      then
        echo "Inserted $OPPONENT into teams"
        OPPONENT_ID=$($PSQL "SELECT team_id FROM teams WHERE name = '$OPPONENT'")
      fi
    fi

    # 2. Insert game data -> games table

    INSERT_RESULT=$($PSQL "INSERT INTO games(year, round, winner_id, opponent_id, winner_goals, opponent_goals) VALUES($YEAR, '$ROUND', $WINNER_ID, $OPPONENT_ID, $W_GOALS, $O_GOALS)")
    if [[ $INSERT_RESULT == "INSERT 0 1" ]]
    then
      echo "Inserted game $WINNER vs $OPPONENT in $YEAR into games"
    fi
  fi
done

echo -e "\n~~ Inserting Completed ~~\n"