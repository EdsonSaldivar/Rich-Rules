# Ejecuta los siguientes comandos para configurar un cliente del gateway

# Identifica tu interfaz de red:
ip a

#Asigna una IP estatica a tu interfaz de acuerdo al LAN SEGMENT en el que la tengas configurada, en este caso está maquina la tengo asignada a un LAN SEGMENT 10.0.0.0
sudo nmcli connection modify <nombre_interfaz_cliente> ipv4.addresses 10.0.0.10/24 ipv4.gateway 10.0.0.1 ipv4.dns 8.8.8.8 ipv4.method manual connection.autoconnect yes

#Encendemos la interfaz
sudo nmcli connection up <nombre_interfaz_cliente>

