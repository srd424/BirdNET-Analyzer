#!/bin/bash  
  
# Define the directories and image names  
builds=(  
  "/home/clark/BirdNET-Analyzer mmcc73/birdnetserver:latest"  
)  
  
# Loop through the builds and execute the build commands  
for build in "${builds[@]}"; do  
  dir=$(echo "$build" | cut -d' ' -f1)  
  image=$(echo "$build" | cut -d' ' -f2)  
    
  echo "Building in directory: $dir"  
    
  # Change to the current directory  
  cd "$dir" || { echo "Error: Failed to change to directory $dir"; exit 1; }  
    
  # Build and push the arm64 image  
  docker buildx build --platform linux/arm64 -t "$image" --push .  
    
  # Build and push the amd64 image  
  docker buildx build --platform linux/amd64 -t "$image" --push .  
    
  # Pull the amd64 image to update the local Docker daemon  
  docker pull "$image"  
    
  # Change back to the initial directory  
  cd - || { echo "Error: Failed to change back to the initial directory"; exit 1; }  
  
  echo "Finished building in directory: $dir"  
done  
  
echo "All builds completed successfully."  
