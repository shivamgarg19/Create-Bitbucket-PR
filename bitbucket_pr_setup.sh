#!/bin/bash
# Author : Shivam Garg

CONFIG_FILE="/usr/local/bin/create_pr"

# Colors
green=$(tput setaf 2)
reset=$(tput sgr0)


echo "${green}Bitbucket PR setup${reset}"
echo "${green}==========================${reset}"
echo
echo "You need to enter your workspace name, Username and password, If you don't have bitbucket password"
echo "you can go into personal setting -> App Passwords to create one"
echo
read -r -p "${green}Enter your workspace name: ${reset}" WORKSPACE
read -r -p "${green}Enter your username: ${reset}" USERNAME
read -r -p "${green}Enter your password: ${reset}" PASSWORD
cat > "$CONFIG_FILE" <<EOF
#!/bin/zsh
# Author : Shivam Garg

workspace='$WORKSPACE' # Add the bitbucket workspace name here
target='develop'
current=\$(git branch --show-current)
repo=\$(basename \`git rev-parse --show-toplevel\`)

if [[ "\$1" == "-h" ]]; then
  echo "Script for creating Bitbucket PR from terminal
  where:
       -h show this help text
       -t target branch (default - 'develop')
       -c branch of which you want to create the PR for (default - current branch)
       -r repository (default - current repo)
  usage example:
        create_pr -> For creating the PR from current branch to develop
        create_pr -t release_branch -> For creating the PR from current branch to release_branch"
  exit 0
fi

while getopts "c:t:r:" opt
do
   case "\$opt" in
      c ) current="\$OPTARG" ;;
      t ) target="\$OPTARG" ;;
      r ) repo="\$OPTARG" ;;
      ? )  ;;
   esac
done

if [ -z "\$repo" ]
then
   echo "Enter the current branch with option -r";
   exit 1;
fi

if [ -z "\$current" ]
then
   echo "Enter the current branch with option -c";
   exit 1;
fi

# Adding title as current branch after removing '_' and '-'
title=\${current//'_'/' '}
title=\${title//'-'/' '}
title=\${(C)title}

# Adding description as list of all commit message
description=\$(git log --reverse --pretty=format:"* %s" origin/\$target..origin/\$current)
description=\${description//
/'\n'}

echo 'https://bitbucket.org/api/2.0/repositories/'"\$workspace"'/'"\$repo"'/pullrequests'
echo "\$current" "\$target" "\$title"
echo "\$description"

# Create App passwords from Bitbucket Personal settings page
curl --location --request POST -u $USERNAME:$PASSWORD 'https://bitbucket.org/api/2.0/repositories/'"\$workspace"'/'"\$repo"'/pullrequests' \
--header 'Content-Type: application/json' \
--data-raw '{
    "title": "'"\$title"'",
    "description": "'"\$description"'",
    "source": {
        "branch": {
            "name": "'"\$current"'"
        }
    },
    "destination": {
        "branch": {
            "name": "'"\$target"'"
        }
    },
    "reviewers": [],
    "close_source_branch": true
}' | jq '.links.html,.error'
EOF
chmod +x "$CONFIG_FILE"
echo
echo "A bitbucket create PR script has been created at ${green}$CONFIG_FILE.${reset}"
echo "you can edit that file if you like. Otherwise you"
echo "are good to go!"
echo ""
$CONFIG_FILE -h
exit 0
