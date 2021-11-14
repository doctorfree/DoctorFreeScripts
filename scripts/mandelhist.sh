#!/bin/bash
#
## @file mandelhist.sh
## @brief Display a zoom on the Mandelbrot set with histograms
## @version 1.0.1
##
## See http://trac.ffmpeg.org/wiki/FancyFilteringExamples
#

ffplay -f lavfi -i mandelbrot -vf "split=4[a][b][c][d],[d]histogram=display_mode=overlay:level_height=244[dd],[a]histogram=mode=waveform:waveform_mode=row:display_mode=overlay[aa],[b]histogram=mode=waveform:waveform_mode=column:display_mode=overlay[bb],[c]pad=iw+256:ih+256[cc],[cc][aa]overlay=x=W-256[ccc],[ccc][bb]overlay=y=H-256[x],[x][dd]overlay=y=H-256:x=W-256"

