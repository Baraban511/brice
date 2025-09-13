#!/run/current-system/sw/bin/bash

# === Config ===
DEST_DIR="/home/barab/.config/brice"
UNSPLASH_COLLECTION_ID="_A6eGnQBtvQ"    # Unsplash Collection ID

mkdir -p "$DEST_DIR"

response=$(curl -s "https://api.unsplash.com/photos/random?orientation=landscape&collections=$UNSPLASH_COLLECTION_ID&client_id=$(cat "$UNSPLASH_API_KEY")")

if [[ -z "$response" ]]; then
    echo "Error: Empty API response"
    exit 1
fi

if [[ "$response" == "Rate Limit Exceeded" ]]; then
    echo "Error: Rate limit exceeded"
    exit 1
fi

# Extract URL from image
image_url=$(echo "$response" | jq -r '.urls.raw')

# URL check
if [[ $image_url == "null" || -z $image_url ]]; then
    echo "Error: Can't fetch image's URL"
    exit 1
fi

# Download image
filename="$DEST_DIR/unsplash.jpg"
curl -s -L "$image_url&w=3840&h=2160&fit=crop&crop=entropy&auto=true" -o "$filename"

photographer=$(echo "$response" | jq -r '.user.name')
location=$(echo "$response" | jq -r '.location.name')


luminosity=$(magick "$filename" -gravity Southwest -crop 100%x10%+0+0 +repage -colorspace Gray -format "%[fx:mean*255]" info:)

LUM_INT=${luminosity%.*}

# Choose color based on luminosity
if [ $LUM_INT -gt 128 ]; then
    color="rgba(0,0,0,0.7)"
else
    color="rgba(255,255,255,0.7)"
fi

echo "Luminosity : $LUM_INT, Chosen color : $color"


magick $filename \
  -gravity Southwest \
  -fill "$color" \
  -font "Noto-Sans-Mono-CJK-SC-Medium" \
  -pointsize 32 \
  -annotate +12+40 "Picture by $photographer on Unsplash" \
  $filename

if [[ "$location" != "null" ]]; then
    magick $filename \
      -gravity Southwest \
      -fill "$color" \
      -font "Noto-Sans-Mono-CJK-SC-Medium" \
      -pointsize 32 \
      -annotate +12+7 "Location: $location" \
      $filename
fi


# Final check
if [[ -f "$filename" ]]; then
    echo "Sucess: $filename"
else
    echo "Error: Download failed"
    exit 1
fi
