#!/bin/bash

echo "VOD url:"
read vod_url
printf "\n\n"
echo "Hányadik másodperctől kezdődjön a VOD? [HH:MM:SS] (0 ha ne vágjon az elejéből)"
read cut_from_start
printf "\n\n"
echo "Hányadik másodperctől érjen véget a VOD? (Ha volt vágás az elejéből azt ki kell vonni ebből az időből) [HH:MM:SS] (0 ha ne vágjon az elejéből)"
read cut_from_end
printf "\n\n"
echo "Mi legyen a videó címe?"
read title
printf "\n\n"
echo "Milyen legyen a videó láthatósága? (public | unlisted | private)"
read privacy
printf "\n\n"
youtube-dl -f best -o "download.mp4" $vod_url

if [ "$cut_from_start" = "0" ]; then
    if [ "$cut_from_end" = "0" ]; then
        mencoder -oac pcm -ovc copy download.mp4 -o output.mp4
    else
        mencoder -endpos $cut_from_end -oac pcm -ovc copy download.mp4 -o output.mp4
    fi
else
    if [ "$cut_from_end" = "0" ]; then
        mencoder -ss $cut_from_start -oac pcm -ovc copy download.mp4 -o output.mp4
    else
        mencoder -ss $cut_from_start -endpos $cut_from_end -oac pcm -ovc copy download.mp4 -o output.mp4
    fi
fi
# youtube-upload --title="$title" --privacy="$privacy" output.mp4
printf "\n\n"
# rm -rf *
echo "Sikeresen feltöltődött a videó"
