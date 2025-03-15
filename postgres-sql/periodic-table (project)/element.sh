#!/bin/bash
#
# Use the atomic number, name or symbol to get information about the element

PSQL="psql -U freecodecamp -d periodic_table -A -t -c"

if [[ -z $1 ]]
then
  echo -e "Please provide an element as an argument."
else
  
  if [[ $1 =~ ^[0-9]*$ ]]
  then
    RESULT=$($PSQL "SELECT atomic_number, name, symbol, type, atomic_mass, melting_point_celsius, boiling_point_celsius FROM elements LEFT JOIN properties USING(atomic_number) LEFT JOIN types USING(type_id) WHERE atomic_number=$1" )
  elif [[ $1 =~ ^[a-zA-Z]{1,2}$ ]]
  then
    RESULT=$($PSQL "SELECT atomic_number, name, symbol, type, atomic_mass, melting_point_celsius, boiling_point_celsius FROM elements LEFT JOIN properties USING(atomic_number) LEFT JOIN types USING(type_id) WHERE symbol='$1'" )
  elif [[ $1 =~ ^[a-zA-Z]+$ ]]
  then
    RESULT=$($PSQL "SELECT atomic_number, name, symbol, type, atomic_mass, melting_point_celsius, boiling_point_celsius FROM elements LEFT JOIN properties USING(atomic_number) LEFT JOIN types USING(type_id) WHERE name='$1'" )
  fi

  if [[ -z $RESULT ]]
  then
    echo "I could not find that element in the database."
  else 
    echo $RESULT | while IFS="|" read NO NAME SYMBOL TYPE MASS M_POINT B_POINT
    do
      echo -e "The element with atomic number $NO is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $M_POINT celsius and a boiling point of $B_POINT celsius."
    done
  fi

fi

