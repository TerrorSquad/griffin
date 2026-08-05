#!/usr/bin/env bash

# Fetch the Zscaler root certificate
URL="https://raw.githubusercontent.com/TerrorSquad/griffin/master/post-installation/defaults/ZscalerRootCA.crt"
LOCATION_TO_STORE="/usr/local/share/ca-certificates/ZscalerRootCA.crt"

# Download with error checking and output suppression
if sudo curl -ksSL "$URL" -o "$LOCATION_TO_STORE"; then
  # Update the certificate store only if the download succeeded
  sudo update-ca-certificates
else
  echo "Error downloading the Zscaler root certificate. Exiting." >&2
  exit 1
fi
