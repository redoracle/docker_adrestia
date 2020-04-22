#!/bin/bash

IPH=$(ifconfig eth0 | grep inet | awk '{ print $2 }') 
cd ~/adrestia/user-guide  
hugo server -t book --minify --baseURL=http://$IPH:1313/ --bind $IPH
