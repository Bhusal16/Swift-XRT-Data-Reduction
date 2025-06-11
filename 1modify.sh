#!/bin/bash

# Input file
input_file="csub_t0.txt"

# Output file
output_file="csub_t0_modified.txt"

# Loop through each line in the input file
while IFS= read -r line; do
    # Extract the first field
    first_field=$(echo "$line" | cut -d',' -f1)
    
    # Perform the multiplication
    multiplied_field=$(bc <<< "scale=10; 19861 * $first_field")
    
    # Replace the first field with the multiplied value
    modified_line="${multiplied_field}${line#*,}"
    
    # Append the modified line to the output file
    echo "$modified_line" >> "$output_file"
done < "$input_file"

echo "Multiplication completed. Check '$output_file'."

