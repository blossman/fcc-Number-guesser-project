#!/bin/bash

#set up commit 1
#ADD PSQL Prompt
PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"

#generate secret number between 1 and 1000
SECRET_NUMBER=$(( 1 + $RANDOM % 1000 ))


#commit 2
#request user name
echo Enter your username:
read USERNAME
USERNAME_RESULT=$($PSQL "SELECT name FROM players WHERE name='$USERNAME'")
#if it is a new user
if [[ -z $USERNAME_RESULT ]]
then
  #flag that new user will need to be created, print welcome message
  NEW_USER_FLAG=true
  echo "Welcome, $USERNAME! It looks like this is your first time here."
  #else print returning message
else
  USER_INFO=$($PSQL "SELECT games_played, best_game FROM players WHERE name = '$USERNAME'") | while IFS='|' read GAMES_PLAYED BEST_GAME
  do
  echo "Welcome back, $USERNAME! You have played $GAMES_PLAYED games, and your best game took $BEST_GAME guesses."
  done
fi

#commit 3
#print number request
echo "Guess the secret number between 1 and 1000:"
echo $SECRET_NUMBER
GUESS_COUNT=0
#Number game function
NUMBER_GAME () {
  #read number
  read GUESS
  #count guess
  ((GUESS_COUNT++))
  echo "Guess #$GUESS_COUNT"
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
      echo "it's higher than that, guess again:"
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
          #print victory
          echo "You guessed it in $GUESS_COUNT tries. The secret number was $SECRET_NUMBER. Nice job!"
          #run data store function
        fi
      fi
    fi  
  fi  
}
NUMBER_GAME
#commit 4
#data_storage
  #if first time flag
    #add new user record
    #else, pull best #guesses from DB
    #increase number of games played by 1
    #if current guesses less than best guess
    #update best guess
