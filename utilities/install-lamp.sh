#!/bin/bash

sudo apt-get install apache2 || { echo "Apache installation failed";exit 1; }
echo -e "Running firefox, apache should be working\n "
#firefox localhost &

sudo apt-get install php7.0 libapache2-mod-php7.0  || { echo "Php installation failed"; exit 1; } 
echo -e "Installed php7.0\n"
echo "Restarting apache"
#sudo /etc/init.d/apache2 restart 
echo "Creating php test file"
#sudo touch /var/www/html/testphp.php 
#sudo chmod 766 /var/www/html/testphp.php
#sudo echo "<?php phpinfo(); ?>" >> /var/www/html/testphp.php
echo "Running firefox" 
#firefox http://localhost/testphp.php 
sudo apt-get install mysql-server || { echo "MySql installation failed"; exit 1; }
echo -e "Installed MySql Server\n"

# In order for other computers on your network to view the server 
#you have created, you must first edit the "Bind Address". 
#Begin by opening up Terminal to edit the my.cnf file.
#gksudo gedit /etc/mysql/my.cnf
#Change the line
#bind-address = 127.0.0.1

#if not asked to set a password
#mysql -u root
#SET PASSWORD FOR 'root'@'localhost' = PASSWORD('yourpassword');
sudo apt-get install php7.0-mysql  || { echo "php7.0-mysql installation failed; exit 1; }
sudo apt-get install phpmyadmin || { echo "PhpMyAdmin installation failed; exit 1; }
echo -e "Installed phpmyadmin"

#sudo gedit /etc/apache2/apache2.conf
sudo chmod 766 /etc/apache2/apache2.con
#add the following Include /etc/phpmyadmin/apache.conf
sudo echo "Include /etc/phpmyadmin/apache.conf" >> /var/www/html/testphp.php
#restart apache
sudo /etc/init.d/apache2 restart
