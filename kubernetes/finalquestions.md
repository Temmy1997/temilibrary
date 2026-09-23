Pod Distribution Budget?

<VirtualHost 44.198.178.200:80>
    ServerAdmin webmaster@website1
    DocumentRoot /var/www/html/website1
    ErrorLog /var/log/httpd/website1_error.log
    CustomLog /var/log/httpd/website1_access.log combined
</VirtualHost>

<VirtualHost 44.198.178.200:80>
    ServerAdmin webmaster@website2
    DocumentRoot /var/www/html/website2
    ErrorLog /var/log/httpd/website2_error.log
    CustomLog /var/log/httpd/website2_access.log combined
</VirtualHost>

Project:

DO A PROJECT WITH CDN 
