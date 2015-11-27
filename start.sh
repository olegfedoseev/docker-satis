#!/bin/bash

mkdir /root/.ssh && ssh-keygen -t rsa -b 2048 -P "satis" -f /root/.ssh/id_rsa

echo -e "\n\nPublic key for Satis:"
cat /root/.ssh/id_rsa.pub
echo -e "\n\n"

exec apache2-foreground
