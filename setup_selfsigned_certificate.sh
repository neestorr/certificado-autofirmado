#!/bin/bash

# Genera y configura SSL autofirmado para Apache (Ubuntu/Debian).
set -e

CN="localhost" # Common Name (dominio o IP)
DAYS=365
CERT="/etc/ssl/certs/selfsigned.crt"
KEY="/etc/ssl/private/selfsigned.key"
CONF="/etc/apache2/sites-available/default-ssl.conf"

echo "Generando certificado SSL..."

# Genera llave privada y certificado autofirmado no interactivamente.
sudo openssl req -x509 -nodes -days $DAYS -newkey rsa:2048 \
  -keyout $KEY -out $CERT \
  -subj "/C=US/ST=NA/L=NA/O=Dev/OU=IT/CN=$CN"

# Actualiza el Virtual Host por defecto con las rutas del certificado.
sudo sed -i "s|SSLCertificateFile.*|SSLCertificateFile $CERT|" $CONF
sudo sed -i "s|SSLCertificateKeyFile.*|SSLCertificateKeyFile $KEY|" $CONF

# Habilita módulo SSL, sitio SSL por defecto y reinicia Apache.
sudo a2enmod ssl
sudo a2ensite default-ssl
sudo systemctl restart apache2

echo "SSL autofirmado configurado."
