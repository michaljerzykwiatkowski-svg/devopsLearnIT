# Paszport sieciowy maszyny
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet 10.255.255.254/32 brd 10.255.255.254 scope global lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host proto kernel_lo 
       valid_lft forever preferred_lft forever
2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state UP group default qlen 1000
    link/ether 00:15:5d:01:9b:dc brd ff:ff:ff:ff:ff:ff
    altname enx00155d019bdc
    inet 172.29.216.179/20 brd 172.29.223.255 scope global eth0
       valid_lft forever preferred_lft forever
    inet6 fe80::215:5dff:fe01:9bdc/64 scope link proto kernel_ll 
       valid_lft forever preferred_lft forever
3: docker0: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc noqueue state DOWN group default 
    link/ether 8a:e1:2a:ad:80:bb brd ff:ff:ff:ff:ff:ff
    inet 172.17.0.1/16 brd 172.17.255.255 scope global docker0
       valid_lft forever preferred_lft forever
Tablica routingu:
default via 172.29.208.1 dev eth0 proto kernel onlink 
172.17.0.0/16 dev docker0 proto kernel scope link src 172.17.0.1 linkdown 
172.29.208.0/20 dev eth0 proto kernel scope link src 172.29.216.179 
Wnioski:
Dostępny spoza maszyny jest tylko "eth0". Jest on dostępny z sieci 172.29.216.0/20 i dalej, jeśli routing/firewall pozwala
Tabela nasłuchu gniazd:
Netid State  Recv-Q Send-Q  Local Address:Port Peer Address:PortProcess                                                                                                                                                                                                                                                                                                            
udp   UNCONN 0      0      10.255.255.254:53        0.0.0.0:*                                                                                                                                                                                                                                                                                                                      
udp   UNCONN 0      0           127.0.0.1:323       0.0.0.0:*                                                                                                                                                                                                                                                                                                                      
udp   UNCONN 0      0               [::1]:323          [::]:*                                                                                                                                                                                                                                                                                                                      
tcp   LISTEN 0      128           0.0.0.0:22        0.0.0.0:*    users:(("sshd",pid=1415,fd=6))                                                                                                                                                                                                                                                                                    
tcp   LISTEN 0      511           0.0.0.0:80        0.0.0.0:*    users:(("nginx",pid=895,fd=5),("nginx",pid=894,fd=5),("nginx",pid=893,fd=5),("nginx",pid=892,fd=5),("nginx",pid=891,fd=5),("nginx",pid=890,fd=5),("nginx",pid=889,fd=5),("nginx",pid=888,fd=5),("nginx",pid=887,fd=5),("nginx",pid=886,fd=5),("nginx",pid=885,fd=5),("nginx",pid=884,fd=5),("nginx",pid=883,fd=5))
tcp   LISTEN 0      1000   10.255.255.254:53        0.0.0.0:*                                                                                                                                                                                                                                                                                                                      
tcp   LISTEN 0      128              [::]:22           [::]:*    users:(("sshd",pid=1415,fd=7))                                                                                                                                                                                                                                                                                    
tcp   LISTEN 0      511              [::]:80           [::]:*    users:(("nginx",pid=895,fd=6),("nginx",pid=894,fd=6),("nginx",pid=893,fd=6),("nginx",pid=892,fd=6),("nginx",pid=891,fd=6),("nginx",pid=890,fd=6),("nginx",pid=889,fd=6),("nginx",pid=888,fd=6),("nginx",pid=887,fd=6),("nginx",pid=886,fd=6),("nginx",pid=885,fd=6),("nginx",pid=884,fd=6),("nginx",pid=883,fd=6))


Tablica routingu opis:
Linia 1: "default via 172.29.208.1 dev eth0 proto kernel onlink" oznacza "trasę domyślną" - jest to najważniejsza reguła routingu w systemie:
- DEFAULT - oznacza "wszystko co nie pasuje do żadnej innej, bardziej szczegółowej trasy".
- via 172.29.208.1 - oznacza, że pakiet należy przekazać do bramy o adresie: 172.29.208.1.
- dev eth0 - pakiet wysyłany przez interfejs sieciowy: eth0.
- proto kernel - trasa automatycznie dodana przez jądro systemu, a nie manualnie przez admina.
- onlink - oznacza, że brama: 172.29.208.1 jest osiągalna bezpośrednio przez eth0.


Linia 2: "172.17.0.0/16 dev docker0 proto kernel scope link src 172.17.0.1 linkdown" - jest to trasa dla sieci wewnętrznej Dockera:
- 172.17.0.0/16 - docelowa sieć.
- dev docker0 - ruch ma być wysyłany przez interfejs docker0.
- proto kernel - trasa dodana automatycznie przez jądro.
- scope link - tylko w obrębie tego samego łącza; adresy osiagalne bez pośrednictwa routera.
- src 172.17.0.1 - adres źródłowy przy wysyłaniu pakietów będzie użyty: 172.17.0.1
- linkdown - interfejs docker0 jest nieaktywny.


Linia 3: "172.29.208.0/20 dev eth0 proto kernel scope link src 172.29.216.179" - jest to trasa dla sieci lokalnej LAN, tej samej w której znajduje się maszyna i brama domyślna:
- 172.29.208.0/20 - docelowa sieć lokalna.
- dev eth0 - ruch ma być wysyłany bezpośrednio przez kartę eth0.
- proto kernel - trasa dodana automatycznie przez jądro.
- scope link - adresy osiagalne bezpośrednio.
- src 172.29.216.179 - adres źródłowy, który będzie używany przy wysyłaniu pakietów.


Zadanie domowe nr. 2. ZESZYT PODSIECI
Dla adresu: 192.168.50.77/26:
Address:   192.168.50.77        11000000.10101000.00110010.01 001101
Netmask:   255.255.255.192 = 26 11111111.11111111.11111111.11 000000
Wildcard:  0.0.0.63             00000000.00000000.00000000.00 111111
=>
Network:   192.168.50.64/26     11000000.10101000.00110010.01 000000
HostMin:   192.168.50.65        11000000.10101000.00110010.01 000001
HostMax:   192.168.50.126       11000000.10101000.00110010.01 111110
Broadcast: 192.168.50.127       11000000.10101000.00110010.01 111111
Hosts/Net: 62                    Class C, Private Internet



Dla adresu: 10.10.10.200/25:
Address:   10.10.10.200         00001010.00001010.00001010.1 1001000
Netmask:   255.255.255.128 = 25 11111111.11111111.11111111.1 0000000
Wildcard:  0.0.0.127            00000000.00000000.00000000.0 1111111
=>
Network:   10.10.10.128/25      00001010.00001010.00001010.1 0000000
HostMin:   10.10.10.129         00001010.00001010.00001010.1 0000001
HostMax:   10.10.10.254         00001010.00001010.00001010.1 1111110
Broadcast: 10.10.10.255         00001010.00001010.00001010.1 1111111
Hosts/Net: 126                   Class A, Private Internet



Dla adresu: 172.16.5.130/23:
Address:   172.16.5.130         10101100.00010000.0000010 1.10000010
Netmask:   255.255.254.0 = 23   11111111.11111111.1111111 0.00000000
Wildcard:  0.0.1.255            00000000.00000000.0000000 1.11111111
=>
Network:   172.16.4.0/23        10101100.00010000.0000010 0.00000000
HostMin:   172.16.4.1           10101100.00010000.0000010 0.00000001
HostMax:   172.16.5.254         10101100.00010000.0000010 1.11111110
Broadcast: 172.16.5.255         10101100.00010000.0000010 1.11111111
Hosts/Net: 510                   Class B, Private Internet



Dla adresu: 192.0.2.9/30:
Address:   192.0.2.9            11000000.00000000.00000010.000010 01
Netmask:   255.255.255.252 = 30 11111111.11111111.11111111.111111 00
Wildcard:  0.0.0.3              00000000.00000000.00000000.000000 11
=>
Network:   192.0.2.8/30         11000000.00000000.00000010.000010 00
HostMin:   192.0.2.9            11000000.00000000.00000010.000010 01
HostMax:   192.0.2.10           11000000.00000000.00000010.000010 10
Broadcast: 192.0.2.11           11000000.00000000.00000010.000010 11
Hosts/Net: 2                     Class C



Podział adresu: 192.168.200.0/24 na 8 równych podsieci
Address:   192.168.200.0        11000000.10101000.11001000. 00000000
Netmask:   255.255.255.0 = 24   11111111.11111111.11111111. 00000000
Wildcard:  0.0.0.255            00000000.00000000.00000000. 11111111
=>
Network:   192.168.200.0/24     11000000.10101000.11001000. 00000000
HostMin:   192.168.200.1        11000000.10101000.11001000. 00000001
HostMax:   192.168.200.254      11000000.10101000.11001000. 11111110
Broadcast: 192.168.200.255      11000000.10101000.11001000. 11111111
Hosts/Net: 254                   Class C, Private Internet

1. Requested size: 30 hosts
Netmask:   255.255.255.224 = 27 11111111.11111111.11111111.111 00000
Network:   192.168.200.0/27     11000000.10101000.11001000.000 00000
HostMin:   192.168.200.1        11000000.10101000.11001000.000 00001
HostMax:   192.168.200.30       11000000.10101000.11001000.000 11110
Broadcast: 192.168.200.31       11000000.10101000.11001000.000 11111
Hosts/Net: 30                    Class C, Private Internet

2. Requested size: 30 hosts
Netmask:   255.255.255.224 = 27 11111111.11111111.11111111.111 00000
Network:   192.168.200.32/27    11000000.10101000.11001000.001 00000
HostMin:   192.168.200.33       11000000.10101000.11001000.001 00001
HostMax:   192.168.200.62       11000000.10101000.11001000.001 11110
Broadcast: 192.168.200.63       11000000.10101000.11001000.001 11111
Hosts/Net: 30                    Class C, Private Internet

3. Requested size: 30 hosts
Netmask:   255.255.255.224 = 27 11111111.11111111.11111111.111 00000
Network:   192.168.200.64/27    11000000.10101000.11001000.010 00000
HostMin:   192.168.200.65       11000000.10101000.11001000.010 00001
HostMax:   192.168.200.94       11000000.10101000.11001000.010 11110
Broadcast: 192.168.200.95       11000000.10101000.11001000.010 11111
Hosts/Net: 30                    Class C, Private Internet

4. Requested size: 30 hosts
Netmask:   255.255.255.224 = 27 11111111.11111111.11111111.111 00000
Network:   192.168.200.96/27    11000000.10101000.11001000.011 00000
HostMin:   192.168.200.97       11000000.10101000.11001000.011 00001
HostMax:   192.168.200.126      11000000.10101000.11001000.011 11110
Broadcast: 192.168.200.127      11000000.10101000.11001000.011 11111
Hosts/Net: 30                    Class C, Private Internet

5. Requested size: 30 hosts
Netmask:   255.255.255.224 = 27 11111111.11111111.11111111.111 00000
Network:   192.168.200.128/27   11000000.10101000.11001000.100 00000
HostMin:   192.168.200.129      11000000.10101000.11001000.100 00001
HostMax:   192.168.200.158      11000000.10101000.11001000.100 11110
Broadcast: 192.168.200.159      11000000.10101000.11001000.100 11111
Hosts/Net: 30                    Class C, Private Internet

6. Requested size: 30 hosts
Netmask:   255.255.255.224 = 27 11111111.11111111.11111111.111 00000
Network:   192.168.200.160/27   11000000.10101000.11001000.101 00000
HostMin:   192.168.200.161      11000000.10101000.11001000.101 00001
HostMax:   192.168.200.190      11000000.10101000.11001000.101 11110
Broadcast: 192.168.200.191      11000000.10101000.11001000.101 11111
Hosts/Net: 30                    Class C, Private Internet

7. Requested size: 30 hosts
Netmask:   255.255.255.224 = 27 11111111.11111111.11111111.111 00000
Network:   192.168.200.192/27   11000000.10101000.11001000.110 00000
HostMin:   192.168.200.193      11000000.10101000.11001000.110 00001
HostMax:   192.168.200.222      11000000.10101000.11001000.110 11110
Broadcast: 192.168.200.223      11000000.10101000.11001000.110 11111
Hosts/Net: 30                    Class C, Private Internet

8. Requested size: 30 hosts
Netmask:   255.255.255.224 = 27 11111111.11111111.11111111.111 00000
Network:   192.168.200.224/27   11000000.10101000.11001000.111 00000
HostMin:   192.168.200.225      11000000.10101000.11001000.111 00001
HostMax:   192.168.200.254      11000000.10101000.11001000.111 11110
Broadcast: 192.168.200.255      11000000.10101000.11001000.111 11111
Hosts/Net: 30                    Class C, Private Internet

Needed size:  256 addresses.
Used network: 192.168.200.0/24
Unused:


Podział adresu: 10.50.0.0/16 na 4 podsieci
Address:   10.50.0.0            00001010.00110010. 00000000.00000000
Netmask:   255.255.0.0 = 16     11111111.11111111. 00000000.00000000
Wildcard:  0.0.255.255          00000000.00000000. 11111111.11111111
=>
Network:   10.50.0.0/16         00001010.00110010. 00000000.00000000
HostMin:   10.50.0.1            00001010.00110010. 00000000.00000001
HostMax:   10.50.255.254        00001010.00110010. 11111111.11111110
Broadcast: 10.50.255.255        00001010.00110010. 11111111.11111111
Hosts/Net: 65534                 Class A, Private Internet

1. Requested size: 16382 hosts
Netmask:   255.255.192.0 = 18   11111111.11111111.11 000000.00000000
Network:   10.50.0.0/18         00001010.00110010.00 000000.00000000
HostMin:   10.50.0.1            00001010.00110010.00 000000.00000001
HostMax:   10.50.63.254         00001010.00110010.00 111111.11111110
Broadcast: 10.50.63.255         00001010.00110010.00 111111.11111111
Hosts/Net: 16382                 Class A, Private Internet

2. Requested size: 16382 hosts
Netmask:   255.255.192.0 = 18   11111111.11111111.11 000000.00000000
Network:   10.50.64.0/18        00001010.00110010.01 000000.00000000
HostMin:   10.50.64.1           00001010.00110010.01 000000.00000001
HostMax:   10.50.127.254        00001010.00110010.01 111111.11111110
Broadcast: 10.50.127.255        00001010.00110010.01 111111.11111111
Hosts/Net: 16382                 Class A, Private Internet

3. Requested size: 16382 hosts
Netmask:   255.255.192.0 = 18   11111111.11111111.11 000000.00000000
Network:   10.50.128.0/18       00001010.00110010.10 000000.00000000
HostMin:   10.50.128.1          00001010.00110010.10 000000.00000001
HostMax:   10.50.191.254        00001010.00110010.10 111111.11111110
Broadcast: 10.50.191.255        00001010.00110010.10 111111.11111111
Hosts/Net: 16382                 Class A, Private Internet

4. Requested size: 16382 hosts
Netmask:   255.255.192.0 = 18   11111111.11111111.11 000000.00000000
Network:   10.50.192.0/18       00001010.00110010.11 000000.00000000
HostMin:   10.50.192.1          00001010.00110010.11 000000.00000001
HostMax:   10.50.255.254        00001010.00110010.11 111111.11111110
Broadcast: 10.50.255.255        00001010.00110010.11 111111.11111111
Hosts/Net: 16382                 Class A, Private Internet

Needed size:  65536 addresses.
Used network: 10.50.0.0/16
Unused:
