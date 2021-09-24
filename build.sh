#!/usr/bin/env bash
set -eu
app_li=""
while read -r DIR; do
    rm -rf "$DIR/dist"
    npm run-script build --prefix "$DIR"
    rm -rf gh-pages/$(basename "$DIR")
    mkdir -p gh-pages
    cp -r "$DIR/dist" gh-pages/$(basename "$DIR")
    app_li="${app_li}<li><a href=\"$(basename "$DIR")/\">$(basename "$DIR")</a></li>"
done < <(find . -maxdepth 1 -type d -regextype posix-egrep -regex ".*(leaflet|openlayers|maplibre).*" | sort)
app_ul="<ul>${app_li}</ul>"
sed "s#{{ applications_list }}#${app_ul}#g" index/index.html >gh-pages/index.html
cp index/*.css gh-pages/
