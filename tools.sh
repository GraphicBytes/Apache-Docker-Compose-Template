#!/bin/bash

while true; do
  clear
  echo "############################"
  echo " " 
  echo "        SHELL TOOLS"
  echo " "
  echo "############################"
  echo " "
  branchName=$(git rev-parse --abbrev-ref HEAD)
  echo "Current Branch: $branchName"
  echo " "
  echo "Select an option:"
  echo " "
  echo "1. Cancel/Close"
  echo "2. Start/Reboot docker container"
  echo "3. Git pull changes"
  echo "4. Git push changes to current branch"
  echo "5. Shut down docker container"
  echo " "
  read -p "Enter option (1 to 5): " option

  case $option in
  1)
    echo " "
    echo "Operation cancelled. Bye Ó_ó"
    echo " "
    break
    ;;
  2)
    echo " "
    read -p "Launch docker container? Confirm [y/n]: " confirmation
    if [ "$confirmation" = "y" ]; then
      docker-compose --env-file .env down
      docker-compose --env-file .env up -d --build
    else
      echo "Operation cancelled."
    fi
    ;;
  3)
    echo " "
    echo "Pull all changes for this branch?"
    read -p "Confirm [y/n]: " confirmation
    if [ "$confirmation" = "y" ]; then
      git reset --hard
      git pull
    else
      echo "Operation cancelled."
    fi
    ;;
  4)
    echo " "
    echo "Push changes to git?"
    read -p "Confirm [y/n]: " confirmation
    if [ "$confirmation" = "y" ]; then
      echo "Select an option for your commit message:"
      echo "1. Use default message ('Primary Dev Update')"
      echo "2. Enter a custom message"
      read -p "Enter option (1 or 2): " msgOption

      if [ "$msgOption" = "1" ]; then
        commitMessage="Primary Dev Update"
      elif [ "$msgOption" = "2" ]; then
        read -p "Enter your custom commit message: " customMessage
        commitMessage="$customMessage"
      else
        echo "Invalid option selected. Exiting."
        break
      fi

      git add --all
      git commit -m "$commitMessage"
      git push
    else
      echo "Operation cancelled."
    fi
    ;;
  5)
    echo " "
    read -p "Shut down container? Confirm [y/n]: " confirmation
    if [ "$confirmation" = "y" ]; then
      if [[ "$branchName" == "master" || "$branchName" == "production" ]]; then
        docker-compose --env-file .env down
      else
        echo " "
        echo "Must be in one of the 3 main git branches (master or production)."
        echo " "
      fi
    else
      echo "Operation cancelled."
    fi
    ;;
  *)
    echo "Invalid option selected. Exiting."
    ;;
  esac
done
