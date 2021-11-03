#!/usr/bin/env bash

message=$(date +%d-%b-%H:%M)

git add .
git commit -m "$message"
git push origin main
