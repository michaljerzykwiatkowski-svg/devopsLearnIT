# Kluczowe metryki DORA (Deployment Frequency, Lead Time, MTTR, Change Failure Rate)
Metryki DORA dziela sie na dwie grupy:
1. Ze wzgledu na tempo - Deployment Frequency i Lead Time
2. Ze wzgledu na stabilnosc - Change Failure Rate i MTTR

1.1 Deployment Frequency (DF) - definiuje jak czesto zespol wypuszcza zmiany na srodowisko produkcyjne oraz mierzy tempo dostarczania wartosci do uzytkownika. Moze byc poprawione przez automatyzacje i male commity
1.2 Lead Time for changes (LT) - definiuje czas od momentu gdy kod zostal zatwierdzony (zrobiony commit) do momentu gdy dzialal na srodowiku produkcyjnym. Mierzy czasod zatwierdzenia do wdrozenia aby byl dostepny dla uzytkownika koncowego. Sposob na poprawe: automatyzacja testow, krotkie code review. 

2.1 Change Failure Rate (CFR) - oznacza wskaznik nieudanych zmian w srodowisku produkcyjnym, ktore wymagaly napraw (rollback, patch). Innymi slowami mierzy jakosc zmian trafiajacych na produkcje. Można poprawic poprzez: automatyzacje testow, stopniowe wdrazanie.
2.2 MTTR (Mean Time To Recovery) - definiuje sredni czas od momentu awarii na produkcji do momentu przywrocenia normalnego dzialania uslugi. Mozliwa poprawa przez: monitoring, alerty, automatyzacje rollbacku.
