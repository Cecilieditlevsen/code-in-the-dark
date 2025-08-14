#!/bin/bash
# submit.sh

echo "🎭 Code in the Dark - Submission Time! 🎭"
echo "----------------------------------------"

# Get current branch name
current_branch=$(git branch --show-current)

# Validate if it's a contest branch
if [[ ! $current_branch == contest/* ]]; then
    echo "😱 Whoops! Looks like you're not on a contest branch."
    echo "🔍 Available contest branches:"
    git branch -r | grep "origin/contest/" | sed 's/origin\///'
    echo -e "\n❓ Please switch to your assigned branch using: git checkout <branch-name>"
    exit 1
fi

# Extract team name from branch for messages
team_name=$(echo $current_branch | sed 's/contest\///')

# Check if there are changes to submit
if [[ -z $(git status -s) ]]; then
    echo "😅 Hey Team ${team_name}! There's nothing to submit. Did you actually code anything?"
    exit 1
fi

# Show changes that will be submitted
echo "🔍 Team ${team_name}, here's what you've been cooking up in the dark:"
git status

# Confirmation
echo -e "\n⚠️  Ready to submit your masterpiece? (y/n)"
read confirm

if [[ "$confirm" != "y" && "$confirm" != "Y" ]]; then
    echo "😮‍💨 Submission aborted. Take a deep breath and try again when ready!"
    exit 1
fi

# Submit the changes
echo "🚀 Launching your code into the repository..."
git add .
git commit -m "Code in the Dark Submission - ${team_name}"
git push origin $current_branch

# Check if push was successful
if [ $? -eq 0 ]; then
    echo "✨ Success! Team ${team_name}'s code has been submitted."
    echo "🤞 May the odds be ever in your favor!"
else
    echo "😱 Oops! Something went wrong with the submission."
    echo "🔧 Please call for help (yes, you can look at screens now)."
fi
