server {

	root /var/www/html;

	# Add index.php to the list if you are using PHP
	index index.html index.htm index.nginx-debian.html;
    server_name beholder.apps.amtgard.com beholder.amtgard.com; # managed by Certbot


	location / {
        proxy_pass http://localhost:33080;
        include proxy_params;
	}

}