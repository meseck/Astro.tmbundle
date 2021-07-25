#!/bin/sh
# Author: Fool's Mate (https://github.com/fools-mate)

# Dependency
# scout -https://github.com/ABridoux/scout#installation 

BUNDLE_DIR="./build/Astro.tmbundle"
URL="https://raw.githubusercontent.com/snowpackjs/astro/main/tools/vscode/syntaxes"

ASTRO_SYNTAX_FILE="astro.tmLanguage.json"
ASTRO_MARKDOWN_SYNTAX_FILE="astro-markdown.tmLanguage.json"

echo "Download latest syntax files from astro repo to 'tmp/'"
mkdir -pv "tmp"
curl --progress-bar "$URL/$ASTRO_SYNTAX_FILE" --output "./tmp/$ASTRO_SYNTAX_FILE"
curl --progress-bar "$URL/$ASTRO_MARKDOWN_SYNTAX_FILE" --output "./tmp/$ASTRO_MARKDOWN_SYNTAX_FILE"

echo "Remove 'build/'"
rm -r "$BUNDLE_DIR"

echo "Create '.tmbundle'"
mkdir -pv "$BUNDLE_DIR/Syntaxes"

echo "Create 'info.plist' and copy to '.tmbundle'"
cat > $BUNDLE_DIR/info.plist <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
	<key>contactEmailRot13</key>
	<string>znvy@sbbyf-zngr.qri</string>
	<key>contactName</key>
	<string>Fool's Mate</string>
	<key>description</key>
	<string>New shiny Astro bundle.</string>
	<key>name</key>
	<string>astro</string>
	<key>uuid</key>
	<string>F796CF84-1716-4F7B-B79B-8A5DECCBE8E7</string>
</dict>
</plist>
EOF

echo "Convert tmLanguage from JSON to XML format"
echo "Copy converted files to '.tmbundle'"
scout read -i "./tmp/$ASTRO_SYNTAX_FILE" -f json -e plist > "$BUNDLE_DIR/Syntaxes/astro.tmLanguage"
scout read -i "./tmp/$ASTRO_MARKDOWN_SYNTAX_FILE" -f json -e plist > "$BUNDLE_DIR/Syntaxes/astro-markdown.tmLanguage"

echo "Remove 'tmp/'"
rm -r tmp

echo "Done!"

