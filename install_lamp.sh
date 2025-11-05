#!/bin/bash

# Script de instalación de LAMP (Linux, Apache, MariaDB, PHP) para Ubuntu/Debian.
set -e

echo "Iniciando instalación de LAMP..."

#Actualizar e instalar Apache, MariaDB y PHP con módulos esenciales
sudo apt update -y
sudo apt install -y apache2 mariadb-server php libapache2-mod-php php-mysql

# 2Habilitar e iniciar servicios
sudo systemctl enable --now apache2 mariadb

# Reiniciar Apache para asegurar la carga de los módulos PHP
sudo systemctl restart apache2

echo "¡Instalación de LAMP básica completada!"
echo "Acción pendiente: Asegurar MariaDB con 'sudo mysql_secure_installation'"
