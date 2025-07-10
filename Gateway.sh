#Ejecuta los siguientes comandos para configurar la maquina de rich rules que funcionará como gateway:

sudo dnf update -y
sudo dnf install -y policycoreutils-python-utils # Útil para SELinux, aunque no lo tocaremos a fondo aquí

# Verifica tus interfaces de red:
ip a

sudo nmcli connection modify <nombre_interfaz_lan> ipv4.addresses 10.0.0.1/24 ipv4.method manual connection.autoconnect yes
sudo nmcli connection up <nombre_interfaz_lan>

sudo nmcli connection modify <nombre_interfaz_lan> ipv4.addresses 20.0.0.1/24 ipv4.method manual connection.autoconnect yes
sudo nmcli connection up <nombre_interfaz_lan>

sudo sysctl -w net.ipv4.ip_forward=1
echo "net.ipv4.ip_forward = 1" | sudo tee /etc/sysctl.d/99-ip-forward.conf
sudo sysctl --system # Para aplicar la configuración del archivo

sudo systemctl enable --now firewalld
sudo systemctl status firewalld # Debe decir 'active (running)'

sudo firewall-cmd --zone=public --add-interface=<nombre_interfaz_nat> --permanent
sudo firewall-cmd --zone=lan --add-interface=<nombre_interfaz_lan> --permanent
sudo firewall-cmd --zone=dmz --add-interface=<nombre_interfaz_lan> --permanent

sudo firewall-cmd --zone=lan --set-target=ACCEPT --permanent # Asegura que la zona interna acepte tráfico
sudo firewall-cmd --zone=dmz --set-target=ACCEPT --permanent # Asegura que la zona interna acepte tráfico

sudo firewall-cmd --zone=public --add-masquerade --permanent
sudo firewall-cmd --reload

sudo firewall-cmd --zone=public --add-rich-rule='rule family="ipv4" source address="10.0.0.0/24" masquerade' --permanent
sudo firewall-cmd --zone=public --add-rich-rule='rule family="ipv4" source address="20.0.0.0/24" masquerade' --permanent
sudo firewall-cmd --reload

# Explicación de la rich rule:
    #rule family="ipv4"`: La regla aplica para IPv4.
    #source address="10.0.0.0/24"`: El origen del tráfico es nuestra red LAN Segment.
    #masquerade`: Realiza Network Address Translation (NAT) para que el tráfico parezca venir de la IP pública del Gateway.







