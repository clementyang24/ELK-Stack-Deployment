#!/bin/bash
mkdir -p /var/backup
tar cvzf /var/backup/hom.tar.gz /home
mv /var/backup/home..tar.gz /var/backup/home.0101020201.tar.gz
ls -lah /var/backup > /var/backup/file_report.txt
free -h > /var/backup/disk_report.txt
