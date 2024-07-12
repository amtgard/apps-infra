server {

	root /var/www/html;

	# Add index.php to the list if you are using PHP
	index index.html index.htm index.nginx-debian.html;
    server_name go.apps.amtgard.com go.amtgard.com; # managed by Certbot


	location / {
        proxy_pass http://localhost:32080;
        include proxy_params;
	}

}