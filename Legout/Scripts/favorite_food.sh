#!/bin/bash

# --- Favorite Food Confirmation Script ---
# This script asks the user for their favorite food
# and then displays a personalized confirmation.

echo "------------------------------------------------"
echo "--- Discover Your Taste with Le Gout! ---"
echo "------------------------------------------------"

# Ask the user for their favorite food
read -p "What is your favorite food? " FAVORITE_FOOD

# Display a personalized confirmation message
if [ -z "$FAVORITE_FOOD" ]; then # Check if anything was entered
    echo "It seems you're keeping your culinary secrets hidden! No worries."
else
    echo "Ah, so your favorite food is: $FAVORITE_FOOD!"
    echo "Le Gout celebrates all kinds of delicious food, including that!"
fi

echo "------------------------------------------------"
echo "Thank you for sharing your culinary preference!"
echo "------------------------------------------------"