#!/bin/bash
apt-get update
apt-get install apache2 -y
systemctl restart apache2
