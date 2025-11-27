function taskautomation() {
    echo "Creating a new feature branch..."
    git checkout -b feature
    echo "Adding all files..."
    git add .
    echo "Committing changes..."
    git commit -m "Automation commit"
    echo "Merging feature branch into main..."
    git checkout main
    git merge feature
}
taskautomation