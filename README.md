# arduino-esp32-libs
Recompiling libraries for arduino-esp32 made easy.
This repo will automatically install arduino-esp32 as a component
along with the necessary libraries. The included script copies files from
both the esp-idf and build directory.

# Prerequisites
Follow the [official instructions to install the ESP-IDF Development Environment.](https://docs.espressif.com/projects/esp-idf/en/latest/get-started/#setting-up-development-environment)

Install the appropriate [arduino-esp32 release](https://github.com/espressif/arduino-esp32/releases) (cloned source is v1.0.3-rc1)

Checkout the appropriate commit:
ESP-IDF v3.2.2: [055943e](https://github.com/espressif/esp-idf/releases/tag/v3.2.2)

# Usage
Clone the repo recursively
```
$ git clone --recursive https://github.com/XDleader555/arduino-esp32-libs.git
```
If you forget to clone recursively you can run the following command
```
$ git submodule update --init --recursive
```
Run the config, make your changes, compile and copy
```
$ make menuconfig
$ make -j4
$ ./cplibs.sh
```

# Build Notes
ESP-IDF requires python2 instead of python3. If your distro's executable is
python2, then change the config to reflect this under:
```
SDK tool configuration->Python 2 interpreter->python2
```
To change versions of arduino-esp32, checkout the appropriate commits for the
submodules in the component folder and the comit for the ESP-IDF.
