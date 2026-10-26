# Ściąga: 10 kluczowych rekordów DNS



1. A / example.com 3600 IN A 192.0.2.10 / Mapuje nazwę domeny na adres IPv4 / Brak wsparcia IPv6
2. AAAA / `www.example.com. 3600 IN AAAA 2001:db8::10`/ Mapuje nazwę domeny na adres IPv6 / zły adres IPv6 przy sprawnym IPv4 (A) powoduje, że systemy preferujące IPv6 będą próbować łączyć się w nieskończoność z błędem
3. CNAME /  `blog.example.com. 3600 IN CNAME example.net.`/ Przekirowanie nazwy na inna nazwę / Nie można utworzyć CNAME na wierzchołku domeny (apex) oraz CNAME nie może współistnieć z innymi rekordami (np. MX czy TXT) dla tej samej nazwy
4. MX / `example.com. 3600 IN MX 10 mail.example.com.` / Wskazuje serwery pocztowe odpowiedzialne za odbiór e-maili dla domeny / Brak rekordu A dla serwera z MX** – jeśli `mail.example.com` nie ma rekordu A/AAAA, poczta nie zostanie dostarczona 
5. TXT / `example.com. 3600 IN TXT "v=spf1 include:_spf.example.net ~all"` / Przechowuje dowolny tekst, używany głównie do SPF, DKIM, DMARC i weryfikacji własności domeny / Przekroczenie limitu 255 znaków w jednym stringu, powoduje konieczność podziału na wiele osobnych cudzysłowów
6. NS / `example.com. 86400 IN NS ns1.example.com.` / Wskazuje serwery autorytatywne dla danej domeny / Brak spójności - jeśli NS wskazuje serwer, który nie ma rekordów danej strefy, DNS przestaje działać
7. SOA / `example.com. 3600 IN SOA ns1.example.com. admin.example.com. 2023102601 7200 3600 1209600 3600` / Zawiera podstawowe informacje o strefie (serwer główny, kontakt, numer seryjny) / Brak aktualizacji numeru seryjnego – po zmianie rekordów stary numer SOA sprawia, że serwery wtórne nie zaciągną nowych danych
8. PTR /  `10.2.0.192.in-addr.arpa. 3600 IN PTR www.example.com.` / Tłumaczy adresy IP na nazwy (Reverse DNS) / Jeśli PTR wskazuje inną nazwę, serwery pocztowe uznają to za spam
9. SRV / `_sip._tcp.example.com. 3600 IN SRV 10 60 5060 sipserver.example.com.` / Wskazuje hosta i port dla konkretnej usługi (np. SIP) / Brak kropki na końcu nazwy celu – bez kropki system dokleja nazwę strefy (np.sipserver.example.com.example.com)
10. CAA /  `example.com. 3600 IN CAA 0 issue "letsencrypt.org"` / Określa, które Urzędy Certyfikacji (CA) mogą wydać certyfikat SSL/TLS dla domeny / Zbyt restrykcyjne blokowanie – brak wpisu dla danej CA powoduje, że automatyczne odnawianie certyfikatów kończy się błędem.
