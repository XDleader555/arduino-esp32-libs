#!/bin/bash

# Get script location
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
echo "Project Directory: $DIR"

if [ ! -d "$DIR/sdk" ]; then
    # Create sdk directories
    echo "Creating sdk directory"
    mkdir $DIR/sdk
    mkdir $DIR/sdk/ld
    mkdir $DIR/sdk/lib
else
    # Empty directories
    rm -f $DIR/sdk/ld/*
    rm -f $DIR/sdk/lib/*
    rm -f $DIR/sdk/sdkconfig
fi

echo "Copying files..."
# Copy compiled libraries
find $DIR/build -type d -path ./build/bootloader -prune -o -name *.a -exec cp {} $DIR/sdk/lib/ \;
find $DIR/components/esp-who/components/esp-face/lib -name *.a -exec cp {} $DIR/sdk/lib/ \;
find $IDF_PATH/components/esp32 -name *.a -exec cp {} $DIR/sdk/lib/ \;
find $IDF_PATH/components/bt -name *.a -exec cp {} $DIR/sdk/lib/ \;
cp $IDF_PATH/components/newlib/lib/libc_nano.a $DIR/sdk/lib/
cp $IDF_PATH/components/newlib/lib/libc.a $DIR/sdk/lib/

# Copy Linker files
find $DIR/build -type d -path ./build/bootloader -prune -o -name *.ld -exec cp {} $DIR/sdk/ld/ \;
find $IDF_PATH/components/esp32/ld -maxdepth 1 -name *.ld  -exec cp {} $DIR/sdk/ld/ \;
find $IDF_PATH/components/esp32/ld/wifi_iram_opt/ -maxdepth 1 -name *.ld  -exec cp {} $DIR/sdk/ld/ \;

# Copy sdkconfig
cp $DIR/sdkconfig $DIR/sdk/

# Cleanup sdk
#rm -f $DIR/sdk/lib/libarduino.a 
#rm -f $DIR/sdk/lib/libaws_iot.a
#rm -f $DIR/sdk/lib/libesp-face.a
#rm -f $DIR/sdk/lib/libidf_test.a
#rm -f $DIR/sdk/lib/libunity.a
#rm -f $DIR/sdk/lib/libmain.a
#rm -f $DIR/sdk/lib/libesp_https_server.a

# zip files
echo "Zipping sdk..."
cd $DIR/sdk
zip -FSrq $DIR/arduino-esp32-libs.zip ./

echo "Done! Replace the built in esp32 sdk folder with the one found here"
