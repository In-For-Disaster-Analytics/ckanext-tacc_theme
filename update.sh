# Clone the ckan repository into a temporary directory

REPOSITORY_HTTP_URL=https://github.com/In-For-Disaster-Analytics/ckan-docker.git
TEMP_DIR=$(mktemp -d)
echo "TEMP_DIR: $TEMP_DIR"

# Clone the repository
git clone $REPOSITORY_HTTP_URL $TEMP_DIR

# Check if the clone was successful
if [ $? -ne 0 ]; then
    echo "Error: Failed to clone the repository."
    exit 1
fi

# Check if the destination directory exists
ORIGIN=$TEMP_DIR/src/ckanext-tacc_theme/ckanext/tacc_theme
DESTINATION=ckanext/tacc_theme

# Check if the destination directory exists
if [ ! -d "$DESTINATION" ]; then
    echo "Error: Destination directory $DESTINATION does not exist."
    exit 1
fi

# Check if the origin directory exists
if [ ! -d "$ORIGIN" ]; then
    echo "Error: Origin directory $ORIGIN does not exist."
    exit 1
fi

# Use rsync to copy the files with delete mode
rsync -av --delete $ORIGIN/ $DESTINATION/

# Remove the temporary directory
rm -rf $TEMP_DIR

