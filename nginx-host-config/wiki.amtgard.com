server {

	root /var/www/html;

	# Add index.php to the list if you are using PHP
	index index.html index.htm index.nginx-debian.html;
    server_name wiki.apps.amtgard.com wiki.amtgard.com; # managed by Certbot


	location / {
		#try_files $uri $uri/ =404;
                proxy_pass http://localhost:21080;
                include proxy_params;
	}

    listen [::]:443 ssl ipv6only=on; # managed by Certbot
    listen 443 ssl; # managed by Certbot
    ssl_certificate /etc/letsencrypt/live/wiki.apps.amtgard.com/fullchain.pem; # managed by Certbot
    ssl_certificate_key /etc/letsencrypt/live/wiki.apps.amtgard.com/privkey.pem; # managed by Certbot
    include /etc/letsencrypt/options-ssl-nginx.conf; # managed by Certbot
    ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem; # managed by Certbot

}
server {
    if ($host = wiki.apps.amtgard.com) {
        return 301 https://$host$request_uri;
    } # managed by Certbot

    if ($host = wiki.amtgard.com) {
        return 301 https://$host$request_uri;
    } # managed by Certbot

	listen 80 ;
	listen [::]:80 ;
    server_name wiki.apps.amtgard.com wiki.amtgard.com;
    return 404; # managed by Certbot


}
