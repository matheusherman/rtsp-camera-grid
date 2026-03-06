#!/bin/bash
source .env

ffmpeg \
-i rtsp://$USER:$PASSWORD@$CAMERA_MURO:554/12 \
-i rtsp://$USER:$PASSWORD@$CAMERA_MATHEUS:554/12 \
-i rtsp://$USER:$PASSWORD@$CAMERA_VO:554/12 \
-f lavfi -i color=size=640x352:color=black \
-filter_complex \
    "[0:v][1:v][2:v][3:v]xstack=inputs=4:layout=0_0|w0_0|0_h0|w0_h0[v]" \
    -map "[v]" \
    -c:v rawvideo -an -f nut - | ffplay -i -