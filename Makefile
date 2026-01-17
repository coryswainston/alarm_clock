# Variables
PI_USER = cswainston
PI_HOST = raspberrypi.local
PI_DEST = /home/cswainston/alarm_clock
SOURCE_DIR = ./build/flutter-pi/pi4

.PHONY: all build deploy

all: build deploy

build:
	flutterpi_tool build --arch=arm --cpu=pi4 --release

deploy:
	scp -r $(SOURCE_DIR) $(PI_USER)@$(PI_HOST):$(PI_DEST)