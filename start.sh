#!/bin/bash

mkdir /root/.ssh && ssh-keygen -t rsa -b 2048 -P "" -f /root/.ssh/id_rsa

echo -e "\n\nPublic key for Satis:"
cat /root/.ssh/id_rsa.pub
echo -e "\n\n"

echo "Creating known_hosts..."
for domain in $PRIVATE_DOMAINS ; do
    ssh-keyscan -t rsa $domain >> /root/.ssh/known_hosts
done

chown -R www-data:www-data /var/www/satisfy/web/dist /var/www/composer
cp -r /root/.ssh /var/www/.ssh && chown -R www-data:www-data /var/www/.ssh

exec apache2-foreground
