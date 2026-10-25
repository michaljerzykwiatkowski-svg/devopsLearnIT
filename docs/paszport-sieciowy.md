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
