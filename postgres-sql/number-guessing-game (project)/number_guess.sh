#!/bin/bash

PSQL="psql -U freecodecamp -d number_guessing_game -A -t -c"

# Get username
echo "Enter your username:"
read USERNAME

# Check if username exists
USER_ID=$($PSQL "SELECT user_id FROM users WHERE username = '$USERNAME'")
if [[ ! -z $USER_ID ]]
then
  # Get info about games played
  RESULT=$($PSQL "SELECT n_guesses FROM games WHERE user_id = $USER_ID ORDER BY n_guesses")
  GAMES_PLAYED=$(echo "$RESULT" | wc -l) 
  MIN_TRIES=$(echo $RESULT | sed -r 's/([0-9]+).*/\1/')

  echo "Welcome back, $USERNAME! You have played $GAMES_PLAYED games, and your best game took $MIN_TRIES guesses."
else
  INSERT_RESULT=$($PSQL "INSERT INTO users(username) VALUES('$USERNAME')")
  USER_ID=$($PSQL "SELECT user_id FROM users WHERE username = '$USERNAME'")
  echo "Welcome, $USERNAME! It looks like this is your first time here."
fi

# Start game
RANDOM_N=$((RANDOM % 1001))

echo "Guess the secret number between 1 and 1000:"
read N

GUESS_COUNT=1

while [[ $N != $RANDOM_N ]]
do
  if [[ ! $N =~ ^[0-9]*$ ]]
  then
    echo "That is not an integer, guess again:"
  elif [[ $N < $RANDOM_N ]]
  then
    echo "It's higher than that, guess again:"
  else
    echo "It's lower than that, guess again:"
  fi
  read N
  ((GUESS_COUNT++))
done
# End game
echo "You guessed it in $GUESS_COUNT tries. The secret number was $RANDOM_N. Nice job!"

# Append game info -> games
INSERT_RESULT=$($PSQL "INSERT INTO games(user_id, n_guesses) VALUES($USER_ID, $GUESS_COUNT)")
