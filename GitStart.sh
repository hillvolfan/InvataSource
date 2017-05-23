#!/bin/bash
# This script will help a user get started with the GIT setup
#
# Author: John Hill
# Date: 5/23/2017
#

# Global variables / Default variables
REMOTEREPO=$1

# Function declaration - START

# Function to create the local GIT repo from remote repository
funcCreateLocalGITRepo () {
  echo ""
  if [ -d ~/gitRepos ]; then
    cd ~/gitRepos
    "`git clone -b master $REMOTEREPO`" 2>/dev/null
  else
    echo ""
    mkdir -p ~/gitRepos
    cd ~/gitRepos
    "`git clone -b master $REMOTEREPO`" 2>/dev/null
  fi
}

# Function to add config info for git repos
funcAddConfigInfo () {
  clear
  while [ "$CHOICE" != "Y" ] && [ "$CHOICE" != "y" ];
  do
    echo "Your information added will be put in GIT Config"
    echo ""
    echo "Please enter your FULL name: "
    read FULLNAME
    echo "Please enter your email address: "
    read EMAILADDRESS
    echo ""
    echo "Your name is $FULLNAME"
    echo "Your email is $EMAILADDRESS"
    echo ""
    echo "Are these correct?  (Y / N) "
    read CHOICE
  done

  git config --global user.name "$FULLNAME"
  git config --global user.email "$EMAILADDRESS"

  echo ""
  echo "Your git config is: ...."
  git config --list

  echo ""
  echo "You can get this information from the command line - 'git config --list'"
}

# Function to add some simple aliases for git
funcAddSomeAliases () {
  clear
  echo "Adding some aliases for git"
  echo "======================================================"
  echo ""
  echo "Aliases will be added for:"
  echo "  Checkout - now 'git co'"
    git config --global alias.co checkout
  echo "  Branch - now 'git br'"
    git config --global alias.br branch
  echo "  Commit - now 'git ci'"
    git config --global alias.ci commit
  echo "  Status - now 'git st'"
    git config --global alias.st status
  echo "  Log of last - now 'git last'"
    git config --global alias.last 'log -1 HEAD'
  echo "  Log graphically - now 'git logline"
    git config --global alias.logline "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
  echo ""
  echo "Your git config is: ...."
  git config --list

  echo ""
  echo "You can get this information from the command line - 'git config --list'"
}

# Function to list the branches for Remote
funcListBranches () {
  clear
  echo "The remote branches and your branches are as follows: "
  echo "======================================================"
  echo ""
  if [ -d ~/gitRepos/InvataSource ]; then
    cd ~/gitRepos/InvataSource
    git branch -a
    echo ""
  else
    echo ""
    echo "The gitRepos directory doesn't appear to be available"
  fi
}

# Function for Menu Listing
funcMenuList () {
  clear
  echo "GIT START MAIN MENU"
  echo "==================="
  echo " 1) Create clone from remote MASTER branch"
  echo " 2) Add GIT config changes to begin using GIT"
  echo " 3) ADD some aliases to quicked GIT commands"
  echo " 4) See the list of branches"
  echo ""
  echo "Enter Choice: "
  read MENUCHOICE

  case $MENUCHOICE in
    1)
      funcCreateLocalGITRepo;;
    2)
      funcAddConfigInfo;;
    3)
      funcAddSomeAliases;;
    4)
      funcListBranches;;
    *)
      echo "You chose unwisely";;
  esac
} 

# Function declaration - STOP

# Script - START

funcMenuList
