#!/bin/bash

ffmpeg -f v4l2 -framerate 25 -thread_queue_size 512 -i /dev/video0 \
       -f alsa -thread_queue_size 512 -i hw:2,0 -t 02:14:32 -c:v h264 \
       -c:a aac -pix_fmt yuv420p output.mmp4
