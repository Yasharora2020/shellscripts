#!/bin/bash

echo $(pwd)

# Set the directory path
directory=$(pwd)

# Set the output file name
output_file="combined.py"

# Change to the specified directory
cd "$directory" || exit

# Get the list of .py files
files=(*.py)

# Check if there are no .py files in the directory
if [ ${#files[@]} -eq 0 ]; then
    echo "No .py files found in $directory"
    exit 1
fi

# Display the list of files
echo "The following files will be combined:"
for file in "${files[@]}"; do
    echo "$(basename "$file")"
done
echo

# Confirmation message
read -r -p "Are you sure you want to combine these files into 
$output_file? [y/N] " response

# Convert response to lowercase
response=${response,,}

# Check if response is "y" or "yes"
if [[ $response =~ ^(yes|y)$ ]]; then
    # Create the output file
    > "$output_file"

    # Loop through each .py file in the directory
    for file in "${files[@]}"; do
        # Get the file name (without extension)
        name=$(basename "$file" .py)

        # Add the file name before its contents and append to the output 
file
        echo -e "\n# File: $name.py\n" >> "$output_file"
        cat "$file" >> "$output_file"
    done

    echo "All .py files have been combined into $output_file"
else
    echo "Operation cancelled by the user"
fi
