#!/bin/bash

timeout 0.5 /usr/bin/gpioset -c 0 5=1 | true
timeout 0.5 /usr/bin/gpioset -c 0 6=1 | true
timeout 0.5 /usr/bin/gpioset -c 1 3=0 | true
sleep 1
timeout 0.5 /usr/bin/gpioset -c 0 5=0 | true
timeout 0.5 /usr/bin/gpioset -c 0 6=0 | true
timeout 0.5 /usr/bin/gpioset -c 1 3=1 | true
