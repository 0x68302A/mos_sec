#!/bin/bash

tar -xvf ./tor-browser-*
cp ./user.js tor-browser_en-US/Browser/TorBrowser/Data/Browser/profile.default/
echo "cd /opt/mos-tbb_patch.d/tor-browser_en-US/ && ./start-tor-browser.desktop" > \
/usr/bin/start-tor-browser
