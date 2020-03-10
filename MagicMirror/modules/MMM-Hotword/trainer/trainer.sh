#! /usr/bin/env bash
ENDPOINT="https://snowboy.kitt.ai/api/v1/train/"

############# MODIFY THE FOLLOWING #############
# Secret user token
TOKEN="YOUR_TOKEN"
#String, or “unknown” if we don’t know hotword name
NAME="mirror_mirror"
# ar (Arabic), zh (Chinese), nl (Dutch), en (English), fr (French), dt (German), hi (Hindi), it (Italian), jp (Japanese), ko (Korean), fa (Persian), pl (Polish), pt (Portuguese), ru (Russian), es (Spanish), ot (Other)
LANGUAGE="en"
# 0_9, 10_19, 20_29, 30_39, 40_49, 50_59, 60+
AGE_GROUP="60+"
# F/M
GENDER="M"
# String, your microphone type
MICROPHONE="Logitech HD Pro Webcam C920"
############### END OF MODIFY ##################

if [[ "$#" != 4 ]]; then
    printf "Usage: %s wave_file1 wave_file2 wave_file3 out_model_name" $0
    exit
fi

WAV1=`base64 $1`
WAV2=`base64 $2`
WAV3=`base64 $3`
OUTFILE="$4"

cat <<EOF >data.json
{
    "name": "$NAME",
    "language": "$LANGUAGE",
    "age_group": "$AGE_GROUP",
    "token": "$TOKEN",
    "gender": "$GENDER",
    "microphone": "$MICROPHONE",
    "voice_samples": [
        {"wave": "$WAV1"},
        {"wave": "$WAV2"},
        {"wave": "$WAV3"}
    ]
}
EOF

curl -H "Content-Type: application/json" -X POST -d @data.json $ENDPOINT > $OUTFILE
