#!/bin/bash

> data.txt


for ((i = 40; i <= 1200; i += 40)); do
    make all
    $i >> data.txt
    ./a.out $i >> data.txt
done
