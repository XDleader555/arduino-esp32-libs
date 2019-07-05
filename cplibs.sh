#!/bin/bash

rm ~/projects/esp32lib/lib/*
rm ~/projects/esp32lib/ld/*

rm -r ~/projects/blink/build/bootloader

find ~/projects/blink/build -name *.a -exec cp {} ~/projects/esp32lib/lib/ \;
find ~/projects/blink/components/esp-face/lib -name *.a -exec cp {} ~/projects/esp32lib/lib/ \;
find ~/projects/esp-idf/components/esp32 -name *.a -exec cp {} ~/projects/esp32lib/lib/ \;
find ~/projects/esp-idf/components/bt -name *.a -exec cp {} ~/projects/esp32lib/lib/ \;
cp ~/projects/esp-idf/components/newlib/lib/libc_nano.a ~/projects/esp32lib/lib/
cp ~/projects/esp-idf/components/newlib/lib/libc.a ~/projects/esp32lib/lib/

find ~/projects/blink/build -name *.ld -exec cp {} ~/projects/esp32lib/ld/ \;
find ~/projects/esp-idf/components/esp32/ld -maxdepth 1 -name *.ld  -exec cp {} ~/projects/esp32lib/ld/ \;
find ~/projects/esp-idf/components/esp32/ld/wifi_iram_opt/ -maxdepth 1 -name *.ld  -exec cp {} ~/projects/esp32lib/ld/ \;

cp sdkconfig ~/projects/esp32lib/

cd ~/projects/esp32lib/
rm ./lib/libarduino.a 
rm ./lib/libaws_iot.a
rm ./lib/libesp-face.a
rm ./lib/libidf_test.a
rm ./lib/libunity.a
rm ./lib/libmain.a
rm ./lib/libesp_https_server.a

zip -FSr /var/www/andrewmiyaguchi.com/html/build/esp32lib.zip ./
