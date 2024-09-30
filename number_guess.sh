#!/bin/bash

#set up
#ADD PSQL Prompt
PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"

#generate secret number between 1 and 1000
SECRET_NUMBER=$(( 1 + $RANDOM % 1000 ))


#request user name
echo Enter your username:
read USERNAME
USERNAME_RESULT=$($PSQL "SELECT name FROM players WHERE name='$USERNAME'")
#if it is a new user
if [[ -z $USERNAME_RESULT ]]
then
  #flag that new user will need to be created, print welcome message
  NEW_USER_FLAG="true"
  echo "Welcome, $USERNAME! It looks like this is your first time here."
  #else print returning message
else
  USER_INFO=$($PSQL "SELECT games_played, best_game FROM players WHERE name = '$USERNAME'") 
  echo $USER_INFO | while IFS='|' read GAMES_PLAYED BEST_GAME
  do
  echo "Welcome back, $USERNAME! You have played $GAMES_PLAYED games, and your best game took $BEST_GAME guesses."
  done
fi

#data_storage
#if first time flag
SAVE_DATA () {
  if [[ -v NEW_USER_FLAG  ]]
  then
      #add new user record
    INSERT_NEW_USER=$($PSQL "INSERT INTO players(name, games_played, best_game) VALUES('$USERNAME', 1, $GUESS_COUNT)") 
      #else, pull best #guesses from DB
  else
      #increase number of games played by 1
    UPDATE_GAMES_PLAYED=$($PSQL "UPDATE players SET games_played = games_played + 1 WHERE name = '$USERNAME'")
    CURRENT_BEST_GUESS=$($PSQL "SELECT best_game FROM players WHERE name = '$USERNAME'")
      #if current guesses less than best guess
    if [[ $CURRENT_BEST_GUESS -gt $GUESS_COUNT ]]
    then
      #update best guess
      UPDATE_BEST_GAME=$($PSQL "UPDATE players SET best_game = $GUESS_COUNT WHERE name = '$USERNAME'")
    fi
  fi
}

#print number request
echo "Guess the secret number between 1 and 1000:"
GUESS_COUNT=0
#Number game function
NUMBER_GAME () {
  #read number
  read GUESS
  #count guess
  ((GUESS_COUNT++))
  #if it is not an integer, 
  if [[ ! $GUESS =~ ^[0-9]+$ ]]
  then
    #print error
    echo That is not an integer, guess again:
    #run function
    NUMBER_GAME
    #else, if greater than number
  else
    if [[ $GUESS -lt $SECRET_NUMBER ]]
    then  
      #print clue
      echo "It's higher than that, guess again:"
      #run function
      NUMBER_GAME
      #else if less than number
    else
      if [[ $GUESS -gt $SECRET_NUMBER ]]
      then
        #print clue
        echo "It's lower than that, guess again:"
        #run function
        NUMBER_GAME
        #else if equal to number
      else
        if [[ $GUESS == $SECRET_NUMBER ]]
        then
        #run data store function
          SAVE_DATA
          #print victory
          echo "You guessed it in $GUESS_COUNT tries. The secret number was $SECRET_NUMBER. Nice job!"
          
        fi
      fi
    fi  
  fi  
}
NUMBER_GAME

