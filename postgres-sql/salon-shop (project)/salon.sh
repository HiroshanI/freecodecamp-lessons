#!/bin/bash
PSQL="psql -U freecodecamp -d salon -A -t -c"

echo -e "\n~~ Welcome to FreeCodeCamp Salon ~~"


SERVICES_MENU() {
  if [[ $1 ]]
  then
    echo $1
  else 
    echo -e "\nServices available:"
  fi

  SERVICES_LIST=$($PSQL "SELECT service_id, name FROM services")
  echo "$SERVICES_LIST" | while IFS="|" read S_ID NAME
  do
    echo "$S_ID) $NAME"
  done

  echo -e "\nHow may I help you?"

  read SERVICE_ID_SELECTED

  if [[ ! $SERVICE_ID_SELECTED =~ ^[0-9]*$ ]]
  then
    SERVICES_MENU "Please enter a valid number."
  else
    SERVICE_NAME=$($PSQL "SELECT name FROM services WHERE service_id = $SERVICE_ID_SELECTED")
    if [[ $SERVICE_NAME ]]
    then
      echo -e "\nPlease enter your phone number:"
      read CUSTOMER_PHONE

      CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone = '$CUSTOMER_PHONE'")
      if [[ -z $CUSTOMER_ID ]]
      then
        echo -e "\nYou are a new customer. Enter your details to continue ..."
        echo "Please enter your name:"
        read CUSTOMER_NAME
        INSERT_CUSTOMER_RESULT=$($PSQL "INSERT INTO customers(name, phone) VALUES('$CUSTOMER_NAME','$CUSTOMER_PHONE')")
        CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone = '$CUSTOMER_PHONE'")
      else
        CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE phone = '$CUSTOMER_PHONE'")

      fi

      echo -e "\nWhen do you want to schedule the $SERVICE_NAME?"
      read SERVICE_TIME 

      INSERT_APP_RESULT=$($PSQL "INSERT INTO appointments (time, customer_id, service_id) VALUES ('$SERVICE_TIME', $CUSTOMER_ID, $SERVICE_ID_SELECTED)")
      echo -e "\nI have put you down for a $SERVICE_NAME at $SERVICE_TIME, $CUSTOMER_NAME."
    else
      SERVICES_MENU "Please enter a valid service number"
    fi
  fi

}

SERVICES_MENU