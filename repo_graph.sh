#!/bin/bash

# Set the start date as 6 months ago
start_date=$(date -v-6m +%Y-%m-%d)

# Set the end date as today
end_date=$(date +%Y-%m-%d)

# Initialize the current date as the start date
current_date=$start_date

# Create or clear the output file
echo "" > line_counts.txt

# Get the current branch
current_branch=$(git rev-parse --abbrev-ref HEAD)

# Iterate over each day
while [[ $current_date != $end_date ]]
do
  # Checkout the repository state of the current date
  git checkout $(git rev-list -n 1 --before="$current_date 23:59" $current_branch)

  # Count the lines of code and append to the file
  count=`scc . --no-complexity --no-cocomo --no-size | tail -n 3 | head -n 1 | awk '{print $3}'`

  # Append the date and total lines to the output file
  echo "$current_date, $count" >> line_counts.txt

  # Increment the date
  current_date=$(date -j -v+1d -f "%Y-%m-%d" $current_date +%Y-%m-%d)
done

# Checkout master again
git checkout $current_branch
