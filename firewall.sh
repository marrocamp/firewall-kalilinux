#!/bin/bash         
cd /
ls -l

PATH='/sbin'


        echo "-------------------------------------"

    echo "Firewall!"
	echo "criador Marrocamp"
	echo "proteção para o sistema operacional Kali Linux "
    echo "-------------------------------------"

        echo 'Loading modules...'       

        $MODPROBE 'ip_tables' 

        $MODPROBE 'x_tables'  

        echo 'Cleaning up firewall...'  


        iptables -F 

        iptables -t nat -F    

        iptables -t mangle -F 

        iptables -X 

        iptables -t nat -X    

        iptables -t mangle -X 

        iptables -Z 

        iptables -t nat -Z    

        iptables -t mangle -Z 



        iptables -P INPUT DROP

        iptables -P FORWARD DROP        

        iptables -P OUTPUT ACCEPT       

        echo 'OK -> difinindo politicas padrão...'    



        echo  'OK -> liberandom o Loopback ...'         

        iptables -A INPUT -i lo -j ACCEPT         


        iptables -A FORWARD -p tcp --syn -m limit --limit 1/s -j ACCEPT

        echo 'OK -> proteção contra DOS'        


        echo 'OK -> abilitar comunicação com outras interfaces...'

        echo '1' > /proc/sys/net/ipv4/ip_forward     


        echo "====>Bloquear pacotes com estado "novo/invalido" que saiam pela placa  de rede (eth0/eth0/outras)<===="
	echo "modificar como a sua placa de rede para ter a proteção"
 	iptables -A FORWARD -o eth0 -m state --state NEW,INVALID -j DROP
        iptables -A FORWARD -o eth0 -m state --state NEW,INVALID -j DROP
	


        echo "====>Bloqueando conexão brute force via SSH:<===="      

        iptables -A INPUT -p tcp --dport 2222 --syn -j ACCEPT     

        echo 'OK -> Conexão SSH aceita (fail2ban abilitado)...'      



        echo "====>PROTEÇÃO CONTRA ATAQUES<===="     

        iptables -A INPUT -m state --state INVALID -j DROP         

        echo "OK -> bloqueando  attacks..."       


        echo "====>PROTEGE CONTRA PACOTES QUE PODEM PROCURAR E OBTER INFORMAÇÕES INTERNAS<===="        

        iptables -A FORWARD --protocol tcp --tcp-flags ALL SYN,ACK -j DROP   

        echo "OK -> proteção Spy-packages ..."


        echo "====>BLOQUEANDO TRACEROUTE<===="       

        iptables -A INPUT -p udp -s 0/0 -i eth0 --dport 33435:33525 -j DROP  

        echo "OK -> bloqueando traceroute..."    


        echo "====>REGRAS DE SEGURANÇA NA INTERNET<===="       

        iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT     

        iptables -A FORWARD -m state --state ESTABLISHED,RELATED -j ACCEPT   

        echo "OK -> regras de segurança na internet..."


        echo "====>PROTECOES DE KERNEL<===="         

	echo 0 > /proc/sys/net/ipv4/conf/all/accept_source_route

        echo 0 > /proc/sys/net/ipv4/conf/all/accept_redirects

        echo 0 > /proc/sys/net/ipv4/conf/all/accept_redirects

        echo 1 > /proc/sys/net/ipv4/icmp_ignore_bogus_error_responses

        echo 0 > /proc/sys/net/ipv4/icmp_echo_ignore_all

        echo 1 > /proc/sys/net/ipv4/tcp_syncookies

        echo 0 > /proc/sys/net/ipv4/conf/all/accept_source_route

        echo 1 > /proc/sys/net/ipv4/conf/all/rp_filter

        echo 1 > /proc/sys/net/ipv4/icmp_echo_ignore_broadcasts

        echo 1 > /proc/sys/net/ipv4/conf/all/log_martians

        echo "OK -> proteção para o Kernel ..."     



        #Liberar WebMin

        #iptables -A INPUT -p udp --dport 10000 -j ACCEPT        

        #iptables -A INPUT -p tcp --dport 10000 -j ACCEPT        



        echo "====>Portas do user do CH-OS<===="

    echo "------> Abrindo Portas do Apache"
    echo "open port tcp 80"
    iptables -A INPUT -p tcp --dport 80 -j ACCEPT
    echo "open port tcp 443"
    iptables -A INPUT -p tcp --dport 443 -j ACCEPT
    echo "open port tcp 8080 "
    iptables -A INPUT -p tcp --dport 8080 -j ACCEPT

    #iptables -A INPUT -p tcp --dport 45659 -j ACCEPT

    
    
    echo "-------> Abrindo Portas para DNS"
    echo "open port udp 53"
    iptables -A INPUT -p udp --dport 53 -j ACCEPT
	
    echo "-------> abrindo porta para o postgresql"
    echo "open port tcp 5432"
    iptables -A INPUT -p tcp --dport 5432 -j ACCEPT 
    

    echo "-------> Abrindo Portas para MYSQL"
    echo "open port tcp 3306"
    echo "open port udp 3306"
    iptables -A INPUT -p tcp --dport 3306 -j ACCEPT
    iptables -A INPUT -p udp --dport 3306 -j ACCEPT
   
    echo "-------> Abrindo Portas para SSH"
    echo "open port tcp 2222"
    echo "open port udp 2222"
    echo "----------------------"
    echo "tunelamento ssh ataque"
    echo "open port tcp 3212"
    echo "open port tcp 1232"
    iptables -A INPUT -p tcp --dport 2222 -j ACCEPT
    iptables -A INPUT -p udp --dport 2222 -j ACCEPT
    iptables -A INPUT -p tcp --dport 3212 -j ACCEPT
    iptables -A INPUT -p tcp --dport 1232 -j ACCEPT
    echo "====>PORTAS PARA ATAQUE<===="
    
    echo "====>BEEF-XSS<===="
    echo "open port tcp 3000"
    echo "open port udp 3000"
    iptables -A INPUT -p tcp --dport 3000 -j ACCEPT
    iptables -A INPUT -p udp --dport 3000 -j ACCEPT 
     
    echo "------->teamserver armitage/cobalt"
    echo "port open tcp 555554"
    echo "port open tcp 419"
    echo "port open tcp 5419"
    echo "port open udp 5419"
    echo "port open tcp 519"
    echo "port open udp 519"

    iptables -A INPUT -p tcp --dport 55554 -j ACCEPT
    iptables -A INPUT -p tcp --dport 419 -j ACCEPT
    iptables -A INPUT -p tcp --dport 5419 -j ACCEPT
    iptables -A INPUT -p udp --dport 5419 -j ACCEPT 
    iptables -A INPUT -p tcp --dport 519 -j ACCEPT
    iptables -A INPUT -p udp --dport 519 -j ACCEPT    

    echo "------->metasploit<--------"
    echo "open port 4444"
    echo "open port 4455"
    echo "open port 3322"
    echo "open port 2233"
    echo "open port 3322"
    echo "open port 5301"
    iptables -A INPUT -p tcp --dport 4444 -j ACCEPT
    iptables -A INPUT -p tcp --dport 4455 -j ACCEPT
    iptables -A INPUT -p tcp --dport 3322 -j ACCEPT 
    iptables -A INPUT -p tcp --dport 2233 -j ACCEPT
    iptables -A INPUT -p tcp --dport 3945 -j ACCEPT
    iptables -A INPUT -p tcp --dport 5301 -j ACCEPT
    
	
    echo "-------> abrindo porta  para beef-xss"
    iptables -A INPUT -p tcp --dport 3000 -j ACCEPT 



        echo "====>Proteções Adicionais<===="       

        iptables -A INPUT -p tcp --dport 5900 -j DROP  

        iptables -A INPUT -p tcp --dport 53 -j DROP    


		#se voce estiver usando um proxy na rede , altere e descomente
        #echo 'OK -> Definido redirecionamento de proxy transparente'

        #iptables -t nat -A PREROUTING -i eth0 -p tcp --dport 80 -j REDIRECT --to-port 3128



        echo "====>Proteção contra ping da morte<====" 

        # -------------------------------------------------------     

        iptables -A FORWARD -p icmp --icmp-type echo-request -m limit --limit 1/s -j ACCEPT     



        echo "====>Proteção contra trinoo<===="

        # -------------------------------------------------------        

        iptables -N TRINOO       

        iptables -A TRINOO -m limit --limit 15/m -j LOG --log-level 6 --log-prefix "FIREWALL: trinoo: "   

        iptables -A TRINOO -j DROP         

        iptables -A INPUT -p TCP -i eth0 --dport 27444 -j TRINOO         

        iptables -A INPUT -p TCP -i eth0 --dport 27665 -j TRINOO         

        iptables -A INPUT -p TCP -i eth0 --dport 31335 -j TRINOO         

        iptables -A INPUT -p TCP -i eth0 --dport 34555 -j TRINOO         

        iptables -A INPUT -p TCP -i eth0 --dport 35555 -j TRINOO         

        echo 'OK -> proteção Trinoo ...'  


        echo "====> Proteção contra trojans<===="

        # -------------------------------------------------------        

        iptables -N TROJAN       

        iptables -A TROJAN -m limit --limit 15/m -j LOG --log-level 6 --log-prefix "FIREWALL: trojan: "   

        iptables -A TROJAN -j DROP         

        iptables -A INPUT -p TCP -i eth0 --dport 666 -j TROJAN 

        iptables -A INPUT -p TCP -i eth0 --dport 4000 -j TROJAN

        iptables -A INPUT -p TCP -i eth0 --dport 6000 -j TROJAN

        iptables -A INPUT -p TCP -i eth0 --dport 6006 -j TROJAN

        iptables -A INPUT -p TCP -i eth0 --dport 16660 -j TROJAN         

        echo 'OK -> proteção contra Trojan ...'  


        echo "====>Proteção contra worms<===="  

        # -------------------------------------------------------        

        iptables -A FORWARD -p tcp --dport 135 -i eth0 -j REJECT         

        echo 'OK -> proteção contra Worm ...'    


        echo "====>Proteção contra port scanners<===="    

        # -------------------------------------------------------        

        iptables -N SCANNER      

        iptables -A SCANNER -m limit --limit 15/m -j LOG --log-level 6 --log-prefix "FIREWALL: port scanner: "      

        iptables -A SCANNER -j DROP        

        iptables -A INPUT -p tcp --tcp-flags ALL FIN,URG,PSH -i eth0 -j SCANNER    

        iptables -A INPUT -p tcp --tcp-flags ALL NONE -i eth0 -j SCANNER 

        iptables -A INPUT -p tcp --tcp-flags ALL ALL -i eth0 -j SCANNER  

        iptables -A INPUT -p tcp --tcp-flags ALL FIN,SYN -i eth0 -j SCANNER        

        iptables -A INPUT -p tcp --tcp-flags ALL SYN,RST,ACK,FIN,URG -i eth0 -j SCANNER         

        iptables -A INPUT -p tcp --tcp-flags SYN,RST SYN,RST -i eth0 -j SCANNER    

        iptables -A INPUT -p tcp --tcp-flags SYN,FIN SYN,FIN -i eth0 -j SCANNER    

        echo 'OK -> proteção contra Port Scanner ...'      


        echo "====>BLOQUEANDO PORT SCANNERS OCULTOS<===="

        iptables -A FORWARD -p tcp --tcp-flags SYN,ACK,FIN,RST RST -m limit --limit 1/s -j ACCEPT         

        echo 'OK -> proteção contra porte scanner oculto...'  


        echo "====>BackOrifice<===="   

        iptables -A INPUT -p tcp -m tcp --dport 31337 -j DROP  

        iptables -A INPUT -p udp -m udp --dport 31337 -j DROP  

        echo 'OK -> proteção BackOrifice ...'       


        echo "====>NetBus<===="       

        iptables -A INPUT -p tcp -m tcp --dport 12345:12346 -j DROP      

        iptables -A INPUT -p udp -m udp --dport 12345:12346 -j DROP      

        echo 'OK -> proteção NetBus ...'   


        echo "====>Ativa mascaramento de saída<===="

        # -------------------------------------------------------

        iptables -A POSTROUTING -t nat -o eth0 -j MASQUERADE     

        echo 'OK -> mascarando Packages de saida ...'   



        echo

        mkdir -p /var/lock/subsys/

        touch /var/lock/subsys/iptables 


      }   


   stop() {

        echo "parandom o firewall!"

        echo "OK -> Limpando todas as  chains" 

        iptables -F  

        iptables -t nat -F     

        iptables -t mangle -F  

        echo "OK ->removendo as chains do user " 

        iptables -X

        iptables -t nat -X   

        iptables -t mangle -X

        iptables -Z

        iptables -t nat -Z   

        iptables -t mangle -Z

        iptables -P INPUT ACCEPT       

        iptables -P FORWARD ACCEPT     

        iptables -P OUTPUT ACCEPT      

        echo "OK -> Cadeias internas redefinidas para a diretiva ACCEPT padrão"

        echo OK         

        echo  

        rm -f /var/lock/subsys/iptables     

  } 


 and in /etc/rc.local add before "exit 0"

# Lançamento minhas regras do netfilter 
if [ -e '/etc/firewall.sh' ]
then
    /bin/sh '/etc/firewall.sh'
fi

