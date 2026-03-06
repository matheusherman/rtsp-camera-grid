# Camera Grid Viewer

Lightweight RTSP camera viewer that combines multiple IP camera streams into a **video grid** using `ffmpeg`.

The project is intended to run on **embedded Linux devices** (such as single-board computers) to create a simple dedicated monitor for security cameras.

> [!IMPORTANT]
> Work in progress / experimental.

## Overview

This project connects to multiple RTSP cameras and composes them into a single video output displayed locally.

It is designed to be:

- simple
- lightweight
- configurable
- suitable for embedded systems

Example architecture:

```

IP Cameras
↓
ffmpeg
↓
video grid composition
↓
local display

```

## Grid Layout

Currently the system displays **3 cameras in a 2×2 grid**, with one empty placeholder.

```

## Camera 1 | Camera 2

Camera 3 | (empty)

````
## Requirements

Software:

- `ffmpeg`
- `ffplay`
- `bash`

Install on Debian/Ubuntu:

```bash
sudo apt install ffmpeg
````

## Project Structure

```
camera/
├── start.sh
└── .env
```

### start.sh

Main script that:

* loads camera configuration
* fetches RTSP streams
* composes the video grid
* launches the viewer

### .env

Stores camera configuration and credentials.

## Configuration

Create a `.env` file:

```bash
CAMERA_MURO=192.168.1.202
CAMERA_MATHEUS=192.168.1.203
CAMERA_VO=192.168.1.204

USER=admin
PASSWORD=your_password
```

Each camera should expose an RTSP stream like:

```
rtsp://USER:PASSWORD@CAMERA_IP:554/12
```

## Usage

Make the script executable:

```bash
chmod +x start.sh
```

Run the viewer:

```bash
./start.sh
```

The video grid will open in a window using `ffplay`.


## How It Works

The script performs the following steps:

1. Loads environment variables from `.env`
2. Connects to RTSP camera streams
3. Generates a blank placeholder frame
4. Combines the streams into a 2×2 grid
5. Pipes the result to `ffplay` for display

Video composition is done using the `xstack` filter in `ffmpeg`.

## Target Use Case

The goal is to run this project on **embedded Linux hardware**, such as:

* BeagleBone
* Raspberry Pi
* other single-board computers

The device would act as a **dedicated camera monitor**, connected to a display.

## Current Limitations

* CPU usage depends heavily on the number of cameras
* no hardware acceleration yet
* limited error handling
* fixed grid layout
