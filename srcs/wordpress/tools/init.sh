#!/bin/sh

# Wait for MariaDB
echo "Waiting for MariaDB..."

until mysql -h mariadb -u$MYSQL_USER -p$MYSQL_PASSWORD -e "SELECT 1" > /dev/null 2>&1; do
    sleep 2
done

if [ ! -f /var/www/html/wp-config.php ]; then

    echo "Downloading WordPress..."
    cd /var/www/html
    wp core download --allow-root

    echo "Creating wp-config.php..."
    wp config create \
        --dbname=$MYSQL_DATABASE \
        --dbuser=$MYSQL_USER \
        --dbpass=$MYSQL_PASSWORD \
        --dbhost=mariadb \
        --allow-root

    echo "Installing WordPress..."
    wp core install \
        --url=$DOMAIN_NAME \
        --title="$WP_TITLE" \
        --admin_user=$WP_ADMIN_USER \
        --admin_password=$WP_ADMIN_PASSWORD \
        --admin_email=$WP_ADMIN_EMAIL \
        --allow-root

    cat > /var/www/html/dbinfo.php << 'EOF'
<?php

$host = "mariadb";
$db   = getenv("MYSQL_DATABASE");
$user = getenv("MYSQL_USER");
$pass = getenv("MYSQL_PASSWORD");

$conn = new mysqli($host, $user, $pass, $db);

if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

echo "<h1>Database Overview</h1>";

echo "<h2>Tables:</h2>";
$result = $conn->query("SHOW TABLES");
echo "<ul>";
while ($row = $result->fetch_array()) {
    echo "<li>" . $row[0] . "</li>";
}
echo "</ul>";

$result = $conn->query("SELECT COUNT(*) as total FROM wp_users");
$row = $result->fetch_assoc();

echo "<h2>Total WordPress Users: " . $row['total'] . "</h2>";

$conn->close();

?>
EOF
    echo "Creating additional user..."
    wp user create $WP_USER $WP_USER_EMAIL \
        --role=author \
        --user_pass=$WP_USER_PASSWORD \
        --allow-root

fi

echo "Starting PHP-FPM..."
exec php-fpm82 -F
