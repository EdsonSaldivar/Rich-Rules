# Ejecuta los siguientes comandos para configurar un cliente del gateway

# Identifica tu interfaz de red:
ip a

#Asigna una IP estatica a tu interfaz
sudo nmcli connection modify <nombre_interfaz_cliente> ipv4.addresses 10.0.0.10/24 ipv4.gateway 10.0.0.1 ipv4.dns 8.8.8.8 ipv4.method manual connection.autoconnect yes
sudo nmcli connection up <nombre_interfaz_cliente>

