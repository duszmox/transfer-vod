#!/bin/bash

echo "1. VOD url-je:"
read vod1_url
echo "2. VOD url-je:"
read vod2_url
echo "Hányadik másodperctől kezdődjön az első VOD? [HH:MM:SS] (0 ha ne vágjon az elejéből)"
read cut1_from_start
printf "\n\n"
echo "Hányadik másodperctől érjen a véget az első VOD? (Ha volt vágás az elejéből azt ki kell vonni ebből az időből) [HH:MM:SS] (0 ha ne vágjon az elejéből)"
read cut1_from_end
printf "\n\n"
echo "Hányadik másodperctől kezdődjön az második VOD? [HH:MM:SS] (0 ha ne vágjon az elejéből)"
read cut2_from_start
printf "\n\n"
echo "Hányadik másodperctől érjen véget a második VOD? (Ha volt vágás az elejéből azt ki kell vonni ebből az időből) [HH:MM:SS] (0 ha ne vágjon az elejéből)"
read cut2_from_end
printf "\n\n"
echo "Mi legyen a videó címe?"
read title
printf "\n\n"
echo "Milyen legyen a videó láthatósága? (public | unlisted | private)"
read privacy
youtube-dl -f best -o "download1.mp4" $vod1_url
youtube-dl -f best -o "download2.mp4" $vod2_url
if [ "$cut1_from_start" = "0" ]; then
    if [ "$cut1_from_end" = "0" ]; then
        mencoder -oac pcm -ovc copy download1.mp4 -o merge1.mp4 -mc 0 -noskip
    else
        mencoder -endpos $cut1_from_end -oac pcm -ovc copy download1.mp4 -o merge1.mp4 -mc 0 -noskip
    fi
else
    if [ "$cut1_from_end" = "0" ]; then
        mencoder -ss $cut1_from_start -oac pcm -ovc copy download1.mp4 -o merge1.mp4 -mc 0 -noskip
    else
        mencoder -ss $cut1_from_start -endpos $cut1_from_end -oac pcm -ovc copy download1.mp4 -o merge1.mp4 -mc 0 -noskip
    fi
fi
if [ "$cut2_from_start" = "0" ]; then
    if [ "$cut2_from_end" = "0" ]; then
        mencoder -oac pcm -ovc copy download2.mp4 -o merge2.mp4 -mc 0 -noskip
    else
        mencoder -endpos $cut2_from_end -oac pcm -ovc copy download2.mp4 -o merge2.mp4 -mc 0 -noskip
    fi

else
    if [ "$cut2_from_end" = "0" ]; then
        mencoder -ss $cut2_from_start -oac pcm -ovc copy download2.mp4 -o merge2.mp4 -mc 0 -noskip
    else
        mencoder -ss $cut2_from_start -endpos $cut2_from_end -oac pcm -ovc copy download2.mp4 -o merge2.mp4 -mc 0 -noskip
    fi
fi
mkvmerge -o output.mp4 merge1.mp4 \+ merge2.mp4
youtube-upload --title="$title" --privacy="$privacy" output.mp4
printf "\n\n"
rm -rf *
echo "A folyamat bejeződött!"
