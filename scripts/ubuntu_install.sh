#!/bin/bash -xe
echo "Installing libraries"
sudo apt -y install libhidapi-libusb0 libudev-dev libusb-1.0-0-dev python3-pip
sudo apt -y install python3-evdev python3-hid python3-pil python3-six python3-xlib

echo "Adding udev rules and reloading"
sudo usermod -a -G plugdev `whoami`
sudo tee /etc/udev/rules.d/99-streamdeck.rules << EOF
SUBSYSTEM=="usb", ATTRS{idVendor}=="0fd9", ATTRS{idProduct}=="0060", MODE:="666", GROUP="plugdev"
SUBSYSTEM=="usb", ATTRS{idVendor}=="0fd9", ATTRS{idProduct}=="0063", MODE:="666", GROUP="plugdev"
SUBSYSTEM=="usb", ATTRS{idVendor}=="0fd9", ATTRS{idProduct}=="006c", MODE:="666", GROUP="plugdev"
SUBSYSTEM=="usb", ATTRS{idVendor}=="0fd9", ATTRS{idProduct}=="006d", MODE:="666", GROUP="plugdev"
EOF

sudo udevadm control --reload-rules
sudo udevadm trigger

echo "Installing streamdeck_ui"
pip3 install --user https://github.com/flexiondotorg/streamdeck-ui/archive/master.zip
echo "If the installation was successful, run 'streamdeck' to start."
