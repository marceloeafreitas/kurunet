#!/bin/bash



DHCP= echo -e "#Configuração cabeada -  Kurunet DHCP\n\n"auto eth0 "\n"allow-hotplug eth0 "\n"iface eth0 inet dhcp >> /etc/network/interfaces
LOOPBACK= echo -e "#Configuração de loopack - Kurunet IP Estático\n\n"auto lo"\n"iface lo inet loopback >> /etc/network/interfaces

	`echo -e "figlet -c Kurunet"`  
	`echo -e "figlet -c #LAN"`

	echo "Bem vindo ao Kurunet para conexão cabeada. Serei seu assistente virtual para configurar sua rede."
	echo -e "\n"
	echo -e "Lembre-se que as configurações só serão implementadas se programas automatizandos.\nTais como: WICD ou Network Manager estiverem desativados."
	echo -e "\n"
	echo "Escolha dentre as opções a baixo, o tipo de rede que você quer configurar:"
	echo -e "\n"
	echo "(1) DHCP"
	echo "(2) Estático"
	echo "(3) DNS"
	echo -e "\n"

	read TIPOREDE

	case $TIPOREDE in
	1)

		echo $DHCP
		echo "Agora iremos reiniciar a rede para entrar as novas configurações"
	        echo "Aguarde..."
	        /etc/init.d/networking restart
	        echo -e "\n"
	        echo "Você configurou com sucesso sua rede DHCP!";;

	2)

		echo $LOOPBACK
		`echo -e "#IP estático - Kurunet \n\nauto eth0 \niface eth0 inet static" >> /etc/network/interfaces`
		echo -n "Digite o IP da sua rede: "
		read ip_rede 
		echo -n "Digite um IP para o computador: "
		read ip_computador
		echo -n "Digite um IP para o gateway: "
		read ip_gateway
		echo -n "Digite a máscara de rede: "
		read ip_netmask
		`echo "network $ip_rede" >> /etc/network/interfaces`
		`echo "address $ip_computador" >> /etc/network/interfaces`
		`echo "gateway $ip_gateway" >> /etc/network/interfaces`
		`echo "netmask $ip_netmask" >> /etc/network/interfaces`
		/etc/init.d/networking restart
		echo -e "IP estático configurado com sucesso! \n\n***AGORA CONFIGURE O SERVIDOR DNS NA OPÇÃO 3***";;	

	3)

		echo "Digite o primeiro IP do seu DNS: "
		echo "Digite o segundo IP: "
		read ip_dns1
		read ip_dns2
		`echo "Configuração DNS - Kurunet\n" >> /etc/resolv.conf`
		`echo "nameserver $ip_dns1" >> /etc/resolv.conf`
		`echo "nameserver $ip_dns2" >> /etc/resolv.conf`
		echo "DNS configurado com sucesso";;
	*)

		echo -e "\033[05;31mErro em $0\033[00;37m, digite um parâmetro válido."

exit
;;
esac


