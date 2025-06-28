#!/run/current-system/sw/bin/bash

# === Config ===
DEST_DIR="/home/barab/brice/wallpapers"
UNSPLASH_COLLECTION_ID="_A6eGnQBtvQ"    # Unsplash Collection ID

mkdir -p "$DEST_DIR"

response=$(curl -s "https://api.unsplash.com/photos/random?orientation=landscape&collections=$UNSPLASH_COLLECTION_ID&client_id=$(cat "$UNSPLASH_API_KEY")")

if [[ -z "$response" ]]; then
    echo "Erreur : réponse vide de l'API"
    exit 1
fi

# Extract URL from image
image_url=$(echo "$response" | jq -r '.urls.raw')

# URL check
if [[ $image_url == "null" || -z $image_url ]]; then
    echo "Erreur : Impossible de récupérer l'URL de l'image"
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

echo "Luminosité : $LUM_INT, Couleur choisie : $color"


magick $filename \
  -gravity Southwest \
  -fill "$color" \
  -font "Noto-Sans-Mono-CJK-SC-Medium" \
  -pointsize 32 \
  -annotate +12+40 "Photo by $photographer on Unsplash" \
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
    echo "Image téléchargée avec succès : $filename"
else
    echo "Erreur : téléchargement échoué"
    exit 1
fi
