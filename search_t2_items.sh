#!/usr/bin/env bash

# ==============================
# CONFIG: FULL ITEM LIST
# ==============================

ITEMS=(
  #"Harry Potter" "Lord of the Rings" "The Hobbit" "Star Wars" "James Bond" "Mission Impossible" "Indiana Jones" "Jurassic Park" "Fast & Furious" "John Wick" "The Matrix" "Die Hard" "Taken" "Bourne" "Oceans" "Mad Max" "Rambo" "Expendables" "Kingsman" "Marvel Avengers" "Captain America" "Iron Man" "Thor" "Guardians of the Galaxy" "Doctor Strange" "Black Panther" "Ant-Man" "Deadpool" "X-Men" "Spider-Man" "Wonder Woman" "Aquaman" "Superman" "Batman" "Justice League" "Alien" "Terminator" "Predator" "Halloween" "Nightmare on Elm Street" "Saw" "Scream" "Conjuring" "Scary Movie" "Planet of the Apes" "Transformers" "Hunger Games" "Maze Runner" "Pirates of the Caribbean" "Shrek" "Ice Age" "How to Train Your Dragon" "Despicable Me" "Minions" "Kung Fu Panda" "Incredibles" "Toy Story" "Finding Nemo" "Avatar" "Back to the Future" "Sherlock Holmes" "Dune" "The Godfather" "Knives Out"
  "Cartoon Network" "Nickelodeon" "Food Network" "Animal Planet" "National Geographic" "Adult Swim" "Discovery" "PBS" "NBC" "HGTV" "History" "TNT" "BBC America" "TLC" "Travel Channel" "VH1" "TBS" "truTV" "Freeform" "Science Channel" "A&E" "TCM" "Bravo TV" "Lifetime" "DisneyNOW" "USA Network" "FYI Network" "OXYGEN" "Investigation Discovery"
  "Adam Sandler" "Angelina Jolie" "Brad Pitt" "Christian Bale" "Clint Eastwood" "Denzel Washington" "Jim Carrey" "Johnny Depp" "Leonardo DiCaprio" "Margot Robbie" "Matt Damon" "Morgan Freeman" "Robert De Niro" "Robert Downey Jr" "Ryan Gosling" "Ryan Reynolds" "Seth Rogen" "Tom Cruise" "Tom Hanks" "Will Ferrell" "Will Smith"
  "Christopher Nolan" "Martin Scorsese" "Steven Spielberg" "Denis Villeneuve" "David Fincher" "Stanley Kubrick" "Alfred Hitchcock" "Wes Anderson"
)

# ==============================
# STEP 1: FILTER FILES
# ==============================
#!/usr/bin/env bash

# ... (ITEMS list remains the same) ...

# ==============================
# STEP 1: FILTER FILES
# ==============================

normalize() {
  # We convert to lowercase and change spaces/special chars to dashes
  # but we keep the output clean for partial matching
  echo "$1" | tr '[:upper:]' '[:lower:]' | sed 's/[^a-z0-9]/-/g' | sed 's/-\+/-/g'
}

echo "Scanning *_t2_* files..."
echo "------------------------"

# Use git to get the list once
mapfile -t FILES < <(git ls-files | grep "_t2_" | grep -v "_t2_flat_")

for item in "${ITEMS[@]}"; do
  # Example: "Prime Video" -> "prime-video"
  item_norm=$(normalize "$item")
  found=0

  for file in "${FILES[@]}"; do
    filename=$(basename "$file")
    
    # We normalize the filename the SAME way as the item
    # Example: "9-amazon-prime-video_t2_4k.jpg" -> "9-amazon-prime-video-t2-4k-jpg"
    file_norm=$(normalize "$filename")

    # The fix: Check if the file contains the item name
    if [[ "$file_norm" == *"$item_norm"* ]]; then
      if [[ $found -eq 0 ]]; then
        echo ""
        echo "MATCH: $item"
        echo "----------------------"
        found=1
      fi
      echo "$file"
    fi
  done
done