#!/bin/bash

#set up commit 1
#ADD PSQL Prompt
PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"

#generate secret number between 1 and 1000
SECRET_NUMBER=$(( 1 + $RANDOM % 1000 ))
echo $SECRET_NUMBER

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
#Number game function
  #read number
  #count guess
  #if it is not an integer, 
  #print error
  #run function
  #else, if greater than number
  #print clue
  #run function
  #else if less than number 
  #print clue
  #run function
  #else if equal to number
  #print victory
  #run data store function

#commit 4
#data_storage
  #if first time flag
    #add new user record
    #else, pull best #guesses from DB
    #increase number of games played by 1
    #if current guesses less than best guess
    #update best guess
