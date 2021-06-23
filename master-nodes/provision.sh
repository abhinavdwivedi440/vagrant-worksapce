#!/usr/bin/env bash

sudo apt update && sudo apt install sshpass

echo 'export TERM=xterm' >> /home/vagrant/.bashrc

sudo sed -i "s/.*PasswordAuthentication.*/PasswordAuthentication no/g" /etc/ssh/sshd_config
sudo systemctl restart ssh



# with pass-phrase
#ssh-keygen -t ed25519 -C "comment" -P "examplePassphrase" -f "desired pathAndName" -q
ssh-keygen -t ed25519 -C "ash default" -P "ash" -f "/home/vagrant/.ssh/id_ed25519" -q



# cpoy ssh key - bypassing the prompt with sshpass and -o StrictHostKeyChecking=no
sshpass -p "vagrant" ssh-copy-id -i /home/vagrant/.ssh/id_ed25519.pub 192.168.205.11 -o StrictHostKeyChecking=no
sshpass -p "vagrant" ssh-copy-id -i /home/vagrant/.ssh/id_ed25519.pub 192.168.205.12 -o StrictHostKeyChecking=no
sshpass -p "vagrant" ssh-copy-id -i /home/vagrant/.ssh/id_ed25519.pub 192.168.205.13 -o StrictHostKeyChecking=no

# no passphrase
#ssh-keygen -t ed25519 -C "comment" -N "" -f "desired path and name" -q
ssh-keygen -t ed25519 -C "ansible" -N "" -f "/home/vagrant/.ssh/ansible" -q

# copy ansible key -  bypassing the prompt with sshpass and -o StrictHostKeyChecking=no
sshpass -P "Enter passphrase for key '/home/vagrant/.ssh/id_ed25519':" -p "ash" ssh-copy-id -i /home/vagrant/.ssh/ansible.pub 192.168.205.11 -o StrictHostKeyChecking=no
sshpass -P "Enter passphrase for key '/home/vagrant/.ssh/id_ed25519':" -p "ash" ssh-copy-id -i /home/vagrant/.ssh/ansible.pub 192.168.205.12 -o StrictHostKeyChecking=no
sshpass -P "Enter passphrase for key '/home/vagrant/.ssh/id_ed25519':" -p "ash" ssh-copy-id -i /home/vagrant/.ssh/ansible.pub 192.168.205.13 -o StrictHostKeyChecking=no

echo "Finished"