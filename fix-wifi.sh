#!/usr/bin/env bash

sudo modprobe -r rtw88_8822ce  
sleep 1
sudo modprobe -r rtw88_8822c
sleep 1
sudo modprobe -r rtw88_pci
sleep 1
sudo modprobe -r rtw88_core
sleep 1
sudo modprobe rtw88_8822ce  
sleep 1
sudo modprobe rtw88_8822c  
sleep 1
sudo modprobe rtw88_pci  
sleep 1
sudo modprobe rtw88_core
sleep 2
wifi-rofi.sh
