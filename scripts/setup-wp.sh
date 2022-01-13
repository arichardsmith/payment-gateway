echo "Wait for DB"
sleep 5s

echo "Installing Wordpress"
wp core install \
	--path=/var/www/html \
	--url=localhost:8888 \
	--title="Test WP Install" \
	--admin_name=admin \
	--admin_password=admin \
	--admin_email=admin@example.com \
	--skip-email

echo "Updating permalink structure"
wp rewrite structure '/%postname%/'

echo "Installing Woocommerce"
wp plugin install woocommerce --activate

echo "Installing and activating Storefront theme..."
wp theme install storefront --activate

echo "Importing WooCommerce shop pages..."
wp wc --user=admin tool run install_pages

echo "Installing Flywire"
wp plugin install flywire-payment-gateway --activate

echo "Importing DB Dump"
wp db import /var/db_dump/setup.sql