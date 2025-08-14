#!/bin/bash
# dry-run.sh

echo "🏃 Code in the Dark - Dry Run Mode 🏃"
echo "------------------------------------"
echo "This is just practice - no actual changes will be pushed!"

# Get current branch name
current_branch=$(git branch --show-current)

# Validate if it's a contest branch
if [[ ! $current_branch == contest/* ]]; then
    echo "📢 Available contest branches:"
    git branch -r | grep "origin/contest/" | sed 's/origin\///'
    echo -e "\n❗ You're not on a contest branch!"
    echo "👉 Switch to your team's branch using: git checkout <branch-name>"
    exit 1
fi

# Extract team name from branch
team_name=$(echo $current_branch | sed 's/contest\///')

echo "👋 Hello Team ${team_name}!"

# Check if there are changes to submit
if [[ -z $(git status -s) ]]; then
    echo "📝 No changes detected. Try making some changes first!"
    exit 1
fi

# Show what would be submitted
echo -e "\n🔍 If this was real, here's what you'd be submitting:"
git status

# Show what would happen
echo -e "\n📋 Here's what would happen in a real submission:"
echo "1. These files would be added to git"
echo "2. A commit would be created with message: 'Code in the Dark Submission - ${team_name}'"
echo "3. Changes would be pushed to your branch: ${current_branch}"

echo -e "\n✅ Dry run completed successfully!"
echo "🎯 Remember: In the real challenge, use 'submit.sh' instead"
