import 'package:BSApp/widgets/bars/app_bar_back_button.dart';
import 'package:BSApp/widgets/bars/base_app_bar.dart';
import 'package:BSApp/widgets/common/form_field_divider.dart';
import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  static const routeName = '/privacy-policy';

  static const TextStyle h1 = TextStyle(fontSize: 15, fontWeight: FontWeight.w600);
  static const TextStyle h2 = TextStyle(fontSize: 13);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BaseAppBar(
        leading: AppBarBackButton(Colors.white),
        title: 'Polityka prywatności',
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 14.0),
          child: Column(
            children: [
              FormFieldDivider(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Poniższa Polityka Prywatności określa zasady zapisywania i uzyskiwania dostępu do danych na Urządzeniach Użytkowników korzystających z Serwisu do celów świadczenia usług drogą elektroniczną przez Administratora oraz zasady gromadzenia i przetwarzania danych osobowych Użytkowników, które zostały podane przez nich osobiście i dobrowolnie za pośrednictwem narzędzi dostępnych w Serwisie.',
                    style: h2,
                  ),
                  FormFieldDivider(),
                  Text(
                    'Poniższa Polityka Prywatności jest integralną częścią Regulaminu Serwisu, który określa zasady, prawa i obowiązki Użytkowników korzystających z Serwisu.',
                    style: h2,
                  ),
                  FormFieldDivider(),
                  Text(
                    '§1 Definicje',
                    style: h1,
                  ),
                  FormFieldDivider(),
                  Text(
                    '• Serwis – aplikacja mobilna "Bobify"',
                    style: h2,
                  ),
                  Text(
                    '• Serwis zewnętrzny - serwisy internetowe partnerów, usługodawców lub usługobiorców współpracujących z Administratorem',
                    style: h2,
                  ),
                  Text(
                    '• Administrator Serwisu / Danych - Administratorem Serwisu oraz Administratorem Danych (dalej Administrator) jest osoba fizyczna "Maciej Krośnicki" zamieszkała w Gdyni, świadcząca usługi drogą elektroniczną za pośrednictwem Serwisu',
                    style: h2,
                  ),
                  Text(
                    '• Użytkownik - osoba fizyczna, dla której Administrator świadczy usługi drogą elektroniczną za pośrednictwem Serwisu.',
                    style: h2,
                  ),
                  Text(
                    '• Cookies (ciasteczka) - dane tekstowe gromadzone w formie plików zamieszczanych na Urządzeniu Użytkownika',
                    style: h2,
                  ),
                  Text(
                    '• RODO - Rozporządzenie Parlamentu Europejskiego i Rady (UE) 2016/679 z dnia 27 kwietnia 2016 r. w sprawie ochrony osób fizycznych w związku z przetwarzaniem danych osobowych i w sprawie swobodnego przepływu takich danych oraz uchylenia dyrektywy 95/46/WE (ogólne rozporządzenie o ochronie danych)',
                    style: h2,
                  ),
                  Text(
                    '• Dane osobowe - oznaczają informacje o zidentyfikowanej lub możliwej do zidentyfikowania osobie fizycznej („osobie, której dane dotyczą”); możliwa do zidentyfikowania osoba fizyczna to osoba, którą można bezpośrednio lub pośrednio zidentyfikować, w szczególności na podstawie identyfikatora takiego jak imię i nazwisko, numer identyfikacyjny, dane o lokalizacji, identyfikator internetowy lub jeden bądź kilka szczególnych czynników określających fizyczną, fizjologiczną, genetyczną, psychiczną, ekonomiczną, kulturową lub społeczną tożsamość osoby fizycznej',
                    style: h2,
                  ),
                  Text(
                    '• Przetwarzanie - oznacza operację lub zestaw operacji wykonywanych na danych osobowych lub zestawach danych osobowych w sposób zautomatyzowany lub niezautomatyzowany, taką jak zbieranie, utrwalanie, organizowanie, porządkowanie, przechowywanie, adaptowanie lub modyfikowanie, pobieranie, przeglądanie, wykorzystywanie, ujawnianie poprzez przesłanie, rozpowszechnianie lub innego rodzaju udostępnianie, dopasowywanie lub łączenie, ograniczanie, usuwanie lub niszczenie;',
                    style: h2,
                  ),
                  Text(
                    '• Ograniczenie przetwarzania - oznacza oznaczenie przechowywanych danych osobowych w celu ograniczenia ich przyszłego przetwarzania',
                    style: h2,
                  ),
                  Text(
                    '• Profilowanie - oznacza dowolną formę zautomatyzowanego przetwarzania danych osobowych, które polega na wykorzystaniu danych osobowych do oceny niektórych czynników osobowych osoby fizycznej, w szczególności do analizy lub prognozy aspektów dotyczących efektów pracy tej osoby fizycznej, jej sytuacji ekonomicznej, zdrowia, osobistych preferencji, zainteresowań, wiarygodności, zachowania, lokalizacji lub przemieszczania się',
                    style: h2,
                  ),
                  Text(
                    '• Zgoda - zgoda osoby, której dane dotyczą oznacza dobrowolne, konkretne, świadome i jednoznaczne okazanie woli, którym osoba, której dane dotyczą, w formie oświadczenia lub wyraźnego działania potwierdzającego, przyzwala na przetwarzanie dotyczących jej danych osobowych',
                    style: h2,
                  ),
                  Text(
                    '• Naruszenie ochrony danych osobowych - oznacza naruszenie bezpieczeństwa prowadzące do przypadkowego lub niezgodnego z prawem zniszczenia, utracenia, zmodyfikowania, nieuprawnionego ujawnienia lub nieuprawnionego dostępu do danych osobowych przesyłanych, przechowywanych lub w inny sposób przetwarzanych',
                    style: h2,
                  ),
                  Text(
                    '• Pseudonimizacja - oznacza przetworzenie danych osobowych w taki sposób, by nie można ich było już przypisać konkretnej osobie, której dane dotyczą, bez użycia dodatkowych informacji, pod warunkiem że takie dodatkowe informacje są przechowywane osobno i są objęte środkami technicznymi i organizacyjnymi uniemożliwiającymi ich przypisanie zidentyfikowanej lub możliwej do zidentyfikowania osobie fizycznej',
                    style: h2,
                  ),
                  Text(
                    '• Anonimizacja - Anonimizacja danych to nieodwracalny proces operacji na danych, który niszczy / nadpisuje "dane osobowe" uniemożliwiając identyfikację, lub powiązanie danego rekordu z konkretnym użytkownikiem lub osobą fizyczną.',
                    style: h2,
                  ),
                ],
              ),
              FormFieldDivider(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '§2 Inspektor Ochrony Danych',
                    style: h1,
                  ),
                  FormFieldDivider(),
                  Text(
                    'Na podstawie Art. 37 RODO, Administrator nie powołał Inspektora Ochrony Danych.',
                    style: h2,
                  ),
                  FormFieldDivider(),
                  Text(
                    'W sprawach dotyczących przetwarzania danych, w tym danych osobowych, należy kontaktować się bezpośrednio z Administratorem.',
                    style: h2,
                  ),
                ],
              ),
              FormFieldDivider(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '§3 Rodzaje Plików Cookies',
                    style: h1,
                  ),
                  FormFieldDivider(),
                  Text(
                    '• Cookies wewnętrzne - pliki zamieszczane i odczytywane z Urządzenia Użytkownika przez system teleinformatyczny Serwisu',
                    style: h2,
                  ),
                  Text(
                    '• Cookies zewnętrzne - pliki zamieszczane i odczytywane z Urządzenia Użytkownika przez systemy teleinformatyczne Serwisów zewnętrznych. Skrypty Serwisów zewnętrznych, które mogą umieszczać pliki Cookies na Urządzeniach Użytkownika zostały świadomie umieszczone w Serwisie poprzez skrypty i usługi udostępnione i zainstalowane w Serwisie',
                    style: h2,
                  ),
                  Text(
                    '• Cookies sesyjne - pliki zamieszczane i odczytywane z Urządzenia Użytkownika przez Serwis podczas jednej sesji danego Urządzenia. Po zakończeniu sesji pliki są usuwane z Urządzenia Użytkownika.',
                    style: h2,
                  ),
                  Text(
                    '• Cookies trwałe - pliki zamieszczane i odczytywane z Urządzenia Użytkownika przez Serwis do momentu ich ręcznego usunięcia. Pliki nie są usuwane automatycznie po zakończeniu sesji Urządzenia chyba że konfiguracja Urządzenia Użytkownika jest ustawiona na tryb usuwanie plików Cookie po zakończeniu sesji Urządzenia.',
                    style: h2,
                  ),
                ],
              ),
              FormFieldDivider(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '§4 Bezpieczeństwo składowania danych',
                    style: h1,
                  ),
                  FormFieldDivider(),
                  Text(
                    '• Mechanizmy składowania i odczytu plików Cookie - Mechanizmy składowania, odczytu i wymiany danych pomiędzy Plikami Cookies zapisywanymi na Urządzeniu Użytkownika a Serwisem są realizowane poprzez wbudowane mechanizmy przeglądarek internetowych i nie pozwalają na pobieranie innych danych z Urządzenia Użytkownika lub danych innych witryn internetowych, które odwiedzał Użytkownik, w tym danych osobowych ani informacji poufnych. Przeniesienie na Urządzenie Użytkownika wirusów, koni trojańskich oraz innych robaków jest także praktycznie niemożliwe.',
                    style: h2,
                  ),
                  Text(
                    '• Cookie wewnętrzne - zastosowane przez Administratora pliki Cookie są bezpieczne dla Urządzeń Użytkowników i nie zawierają skryptów, treści lub informacji mogących zagrażać bezpieczeństwu danych osobowych lub bezpieczeństwu Urządzenia z którego korzysta Użytkownik.',
                    style: h2,
                  ),
                  Text(
                    '• Cookie zewnętrzne - Administrator dokonuje wszelkich możliwych działań w celu weryfikacji i doboru partnerów serwisu w kontekście bezpieczeństwa Użytkowników. Administrator do współpracy dobiera znanych, dużych partnerów o globalnym zaufaniu społecznym. Nie posiada on jednak pełnej kontroli nad zawartością plików Cookie pochodzących od zewnętrznych partnerów. Za bezpieczeństwo plików Cookie, ich zawartość oraz zgodne z licencją wykorzystanie przez zainstalowane w serwisie Skrypty, pochodzących z Serwisów zewnętrznych, Administrator nie ponosi odpowiedzialności na tyle na ile pozwala na to prawo. Lista partnerów zamieszczona jest w dalszej części Polityki Prywatności.',
                    style: h2,
                  ),
                  Text(
                    '• Kontrola plików Cookie',
                    style: h2,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 14.0),
                    child: Column(
                      children: [
                        Text('- Użytkownik może w dowolnym momencie, samodzielnie zmienić ustawienia dotyczące zapisywania, usuwania oraz dostępu do danych zapisanych plików Cookies przez każdą witrynę internetową'),
                        Text('- Użytkownik może w dowolnym momencie usunąć wszelkie zapisane do tej pory pliki Cookie korzystając z narzędzi Urządzenia Użytkownika, za pośrednictwem którego Użytkownik korzysta z usług Serwisu.'),
                      ],
                    ),
                  ),
                  Text(
                    '• Zagrożenia po stronie Użytkownika - Administrator stosuje wszelkie możliwe środki techniczne w celu zapewnienia bezpieczeństwa danych umieszczanych w plikach Cookie. Należy jednak zwrócić uwagę, że zapewnienie bezpieczeństwa tych danych zależy od obu stron w tym działalności Użytkownika. Administrator nie bierze odpowiedzialności za przechwycenie tych danych, podszycie się pod sesję Użytkownika lub ich usunięcie, na skutek świadomej lub nieświadomej działalność Użytkownika, wirusów, koni trojańskich i innego oprogramowania szpiegującego, którymi może jest lub było zainfekowane Urządzenie Użytkownika. Użytkownicy w celu zabezpieczenia się przed tymi zagrożeniami powinni stosować się do zasad korzystania z sieci.',
                    style: h2,
                  ),
                  Text(
                    '• Przechowywanie danych osobowych - Administrator zapewnia, że dokonuje wszelkich starań, by przetwarzane dane osobowe wprowadzone dobrowolnie przez Użytkowników były bezpieczne, dostęp do nich był ograniczony i realizowany zgodnie z ich przeznaczeniem i celami przetwarzania. Administrator zapewnia także, że dokonuje wszelkich starań w celu zabezpieczenia posiadanych danych przed ich utratą, poprzez stosowanie odpowiednich zabezpieczeń fizycznych jak i organizacyjnych.',
                    style: h2,
                  ),
                  Text(
                    '• Przechowywanie haseł - Administrator oświadcza, że hasła przechowywane są w zaszyfrowanej postaci, używając najnowszych standardów i wytycznych w tym zakresie. Deszyfracja podawanych w Serwisie haseł dostępu do konta jest praktycznie niemożliwa.',
                    style: h2,
                  ),
                ],
              ),
              FormFieldDivider(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '§5 Cele do których wykorzystywane są pliki Cookie',
                    style: h1,
                  ),
                  FormFieldDivider(),
                  Text(
                    '• Usprawnienie i ułatwienie dostępu do Serwisu',
                    style: h2,
                  ),
                  Text(
                    '• Umożliwienie Logowania do serwisu',
                    style: h2,
                  ),
                  Text(
                    '• Marketing, Remarketing w serwisach zewnętrznych',
                    style: h2,
                  ),
                  Text(
                    '• Usługi serwowania reklam',
                    style: h2,
                  ),
                  Text(
                    '• Prowadzenie statystyk (użytkowników, ilości odwiedzin, rodzajów urządzeń, łącze itp.)',
                    style: h2,
                  ),
                  Text(
                    '• Świadczenie usług społecznościowych',
                    style: h2,
                  ),
                ],
              ),
              FormFieldDivider(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '§6 Cele przetwarzania danych osobowych',
                    style: h1,
                  ),
                  FormFieldDivider(),
                  Text(
                    'Dane osobowe dobrowolnie podane przez Użytkowników są przetwarzane w jednym z następujących celów:',
                    style: h2,
                  ),
                  FormFieldDivider(),
                  Text(
                    '• Realizacji usług elektronicznych:',
                    style: h2,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 14.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('- Usługi rejestracji i utrzymania konta Użytkownika w Serwisie i funkcjonalności z nim związanych'),
                        Text('- Usługi komentowania / polubienia wpisów w Serwisie bez konieczności rejestrowania się'),
                        Text('- Usługi udostępniania informacji o treści umieszczonych w Serwisie w serwisach społecznościowych lub innych witrynach.'),
                      ],
                    ),
                  ),
                  Text(
                    '• Komunikacji Administratora z Użytkownikami w sprawach związanych z Serwisem oraz ochrony danych',
                    style: h2,
                  ),
                  Text(
                    '• Zapewnienia prawnie uzasadnionego interesu Administratora',
                    style: h2,
                  ),
                  Text(
                    '• Warunki umieszczania treści przez Usługobiorców w Serwisie:',
                    style: h2,
                  ),
                  FormFieldDivider(),
                  Text(
                    'Dane o Użytkownikach gromadzone anonimowo i automatycznie są przetwarzane w jednym z następujących celów:',
                    style: h2,
                  ),
                  Text(
                    '• Prowadzenie statystyk',
                    style: h2,
                  ),
                  Text(
                    '• Remarketing',
                    style: h2,
                  ),
                  Text(
                    '• Serwowanie reklam dostosowanych do preferencji Użytkowników',
                    style: h2,
                  ),
                  Text(
                    '• Zapewnienia prawnie uzasadnionego interesu Administratora',
                    style: h2,
                  ),
                ],
              ),
              FormFieldDivider(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '§7 Pliki Cookies Serwisów zewnętrznych',
                    style: h1,
                  ),
                  FormFieldDivider(),
                  Text(
                    'Administrator w Serwisie wykorzystuje skrypty javascript i komponenty webowe partnerów, którzy mogą umieszczać własne pliki cookies na Urządzeniu Użytkownika. Pamiętaj, że w ustawieniach swojej przeglądarki możesz sam decydować o dozwolonych plikach cookies jakie mogą być używane przez poszczególne witryny internetowe. Poniżej znajduje się lista partnerów lub ich usług zaimplementowanych w Serwisie, mogących umieszczać pliki cookies:',
                    style: h2,
                  ),
                  FormFieldDivider(),
                  Text(
                    '• Usługi społecznościowe / łączone (Rejestracja, Logowanie, udostępnianie treści, komunikacja, itp.) :',
                    style: h2,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 14.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('- Facebook'),
                      ],
                    ),
                  ),
                  Text(
                    '• Prowadzenie statystyk:',
                    style: h2,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 14.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('- Google Analytics'),
                      ],
                    ),
                  ),
                  Text(
                    'Usługi świadczone przez podmioty trzecie są poza kontrolą Administratora. Podmioty te mogą w każdej chwili zmienić swoje warunki świadczenia usług, polityki prywatności, cel przetwarzania danych oraz sposów wykorzystywania plików cookie.',
                    style: h2,
                  ),
                ],
              ),
              FormFieldDivider(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '§8 Rodzaje gromadzonych danych',
                    style: h1,
                  ),
                  FormFieldDivider(),
                  Text(
                    'Serwis gromadzi dane o Użytkownikach. Cześć danych jest gromadzona automatycznie i anonimowo, a część danych to dane osobowe podane dobrowolnie przez Użytkowników w trakcie zapisywania się do poszczególnych usług oferowanych przez Serwis.',
                    style: h2,
                  ),
                  FormFieldDivider(),
                  Text(
                    '• Dane gromadzone podczas rejestracji:',
                    style: h2,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 14.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('- Imię / nazwisko / pseudonim'),
                        Text('- Login'),
                        Text('- Adres e-mail'),
                        Text('- Avatar / Zdjęcie profilowe'),
                      ],
                    ),
                  ),
                  Text(
                    '• Dane gromadzone podczas zapisu do usługi Newsletter',
                    style: h2,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 14.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('- Adres e-mail'),
                      ],
                    ),
                  ),
                  Text(
                    '• Dane gromadzone podczas dodawania komentarza / postu / tematu',
                    style: h2,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 14.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('- Imię i nazwisko / pseudonim'),
                        Text('- Adres e-mail'),
                      ],
                    ),
                  ),
                ],
              ),
              FormFieldDivider(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '§9 Dostęp do danych osobowych przez podmioty trzecie',
                    style: h1,
                  ),
                  FormFieldDivider(),
                  Text(
                    'Co do zasady jedynym odbiorcą danych osobowych podawanych przez Użytkowników jest Administrator. Dane gromadzone w ramach świadczonych usług nie są przekazywane ani odsprzedawane podmiotom trzecim.',
                    style: h2,
                  ),
                  FormFieldDivider(),
                  Text(
                    'Dostęp do danych (najczęściej na podstawie Umowy powierzenia przetwarzania danych) mogą posiadać podmioty, odpowiedzialne za utrzymania infrastruktury i usług niezbędnych do prowadzenia serwisu tj.:',
                    style: h2,
                  ),
                  FormFieldDivider(),
                  Text(
                    '• Firmy hostingowe, świadczące usługi hostingu lub usług pokrewnych dla Administratora',
                    style: h2,
                  ),
                  FormFieldDivider(),
                  Text(
                    'Powierzenie przetwarzania danych osobowych - Usługi Hostingu, VPS lub Serwerów Dedykowanych',
                    style: h2,
                  ),
                  FormFieldDivider(),
                  Text(
                    'Administrator w celu prowadzenia serwisu korzysta z usług zewnętrznego dostawcy hostingu, VPS lub Serwerów Dedykowanych - Contabo GmbH. Wszelkie dane gromadzone i przetwarzane w serwisie są przechowywane i przetwarzane w infrastrukturze usługodawcy zlokalizowanej w Polsce. Istnieje możliwość dostępu do danych wskutek prac serwisowych realizowanych przez personel usługodawcy. Dostęp do tych danych reguluje umowa zawarta pomiędzy Administratorem a Usługodawcą.',
                    style: h2,
                  ),
                ],
              ),
              FormFieldDivider(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '§10 Sposób przetwarzania danych osobowych',
                    style: h1,
                  ),
                  FormFieldDivider(),
                  Text(
                    'Dane osobowe podane dobrowolnie przez Użytkowników:',
                    style: h2,
                  ),
                  FormFieldDivider(),
                  Text(
                    '• Dane osobowe nie będą przekazywane poza Unię Europejską, chyba że zostały opublikowane na skutek indywidualnego działania Użytkownika (np. wprowadzenie komentarza lub wpisu), co sprawi, że dane będą dostępne dla każdej osoby odwiedzającej serwis.',
                    style: h2,
                  ),
                  Text(
                    '• Dane osobowe nie będą wykorzystywane do zautomatyzowanego podejmowania decyzji (profilowania).',
                    style: h2,
                  ),
                  Text(
                    '• Dane osobowe nie będą odsprzedawane podmiotom trzecim.',
                    style: h2,
                  ),
                  FormFieldDivider(),
                  Text(
                    'Dane anonimowe (bez danych osobowych) gromadzone automatycznie:',
                    style: h2,
                  ),
                  FormFieldDivider(),
                  Text(
                    '• Dane anonimowe (bez danych osobowych) będą przekazywane poza Unię Europejską.',
                    style: h2,
                  ),
                  Text(
                    '• Dane anonimowe (bez danych osobowych) nie będą wykorzystywane do zautomatyzowanego podejmowania decyzji (profilowania).',
                    style: h2,
                  ),
                  Text(
                    '• Dane anonimowe (bez danych osobowych) nie będą odsprzedawane podmiotom trzecim.',
                    style: h2,
                  ),
                ],
              ),
              FormFieldDivider(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '§11 Podstawy prawne przetwarzania danych osobowych',
                    style: h1,
                  ),
                  FormFieldDivider(),
                  Text(
                    'Serwis gromadzi i przetwarza dane Użytkowników na podstawie:',
                    style: h2,
                  ),
                  FormFieldDivider(),
                  Text(
                    '• Rozporządzenia Parlamentu Europejskiego i Rady (UE) 2016/679 z dnia 27 kwietnia 2016 r. w sprawie ochrony osób fizycznych w związku z przetwarzaniem danych osobowych i w sprawie swobodnego przepływu takich danych oraz uchylenia dyrektywy 95/46/WE (ogólne rozporządzenie o ochronie danych)',
                    style: h2,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 14.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('- art. 6 ust. 1 lit. a'),
                        Text('  osoba, której dane dotyczą wyraziła zgodę na przetwarzanie swoich danych osobowych w jednym lub większej liczbie określonych celów'),
                        Text('- art. 6 ust. 1 lit. b'),
                        Text('  przetwarzanie jest niezbędne do wykonania umowy, której stroną jest osoba, której dane dotyczą, lub do podjęcia działań na żądanie osoby, której dane dotyczą, przed zawarciem umowy'),
                        Text('- art. 6 ust. 1 lit. f'),
                        Text('  przetwarzanie jest niezbędne do celów wynikających z prawnie uzasadnionych interesów realizowanych przez administratora lub przez stronę trzecią'),
                      ],
                    ),
                  ),
                  Text(
                    '• Ustawa z dnia 10 maja 2018 r. o ochronie danych osobowych (Dz.U. 2018 poz. 1000)',
                    style: h2,
                  ),
                  Text(
                    '• Ustawa z dnia 16 lipca 2004 r. Prawo telekomunikacyjne (Dz.U. 2004 nr 171 poz. 1800)',
                    style: h2,
                  ),
                  Text(
                    '• Ustawa z dnia 4 lutego 1994 r. o prawie autorskim i prawach pokrewnych (Dz. U. 1994 Nr 24 poz. 83)',
                    style: h2,
                  ),
                  FormFieldDivider(),
                  Text(
                    'Dane anonimowe (bez danych osobowych) gromadzone automatycznie:',
                    style: h2,
                  ),
                  FormFieldDivider(),
                  Text(
                    '• Dane anonimowe (bez danych osobowych) będą przekazywane poza Unię Europejską.',
                    style: h2,
                  ),
                  Text(
                    '• Dane anonimowe (bez danych osobowych) nie będą wykorzystywane do zautomatyzowanego podejmowania decyzji (profilowania).',
                    style: h2,
                  ),
                  Text(
                    '• Dane anonimowe (bez danych osobowych) nie będą odsprzedawane podmiotom trzecim.',
                    style: h2,
                  ),
                ],
              ),
              FormFieldDivider(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '§12 Okres przetwarzania danych osobowych',
                    style: h1,
                  ),
                  FormFieldDivider(),
                  Text(
                    '• Dane osobowe podane dobrowolnie przez Użytkowników:',
                    style: h2,
                  ),
                  FormFieldDivider(),
                  Text(
                    'Co do zasady wskazane dane osobowe są przechowywane wyłącznie przez okres świadczenia Usługi w ramach Serwisu przez Administratora. Są one usuwane lub anonimizowane w okresie do 30 dni od chwili zakończenia świadczenia usług (np. usunięcie zarejestrowanego konta użytkownika, wypisanie z listy Newsletter, itp.)\n\nWyjątek stanowi sytuacja, która wymaga zabezpieczenia prawnie uzasadnionych celów dalszego przetwarzania tych danych przez Administratora. W takiej sytuacji Administrator będzie przechowywał wskazane dane, od czasu żądania ich usunięcia przez Użytkownika, nie dłużej niż przez okres 3 lat w przypadku naruszenia lub podejrzenia naruszenia zapisów regulaminu serwisu przez Użytkownika',
                    style: h2,
                  ),
                  FormFieldDivider(),
                  Text(
                    '• Dane anonimowe (bez danych osobowych) gromadzone automatycznie:',
                    style: h2,
                  ),
                  FormFieldDivider(),
                  Text(
                    'Anonimowe dane statystyczne, niestanowiące danych osobowych, są przechowywane przez Administratora w celu prowadzenia statystyk serwisu przez czas nieoznaczony',
                    style: h2,
                  ),
                ],
              ),
              FormFieldDivider(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '§13 Prawa Użytkowników związane z przetwarzaniem danych osobowych',
                    style: h1,
                  ),
                  FormFieldDivider(),
                  Text(
                    'Serwis gromadzi i przetwarza dane Użytkowników na podstawie:',
                    style: h2,
                  ),
                  FormFieldDivider(),
                  Text(
                    '• Prawo dostępu do danych osobowych - Użytkownikom przysługuje prawo uzyskania dostępu do swoich danych osobowych, realizowane na żądanie złożone do Administratora',
                    style: h2,
                  ),
                  Text(
                    '• Prawo do sprostowania danych osobowych - Użytkownikom przysługuje prawo żądania od Administratora niezwłocznego sprostowania danych osobowych, które są nieprawidłowe lub / oraz uzupełnienia niekompletnych danych osobowych, realizowane na żądanie złożone do Administratora',
                    style: h2,
                  ),
                  Text(
                    '• Prawo do usunięcia danych osobowych - Użytkownikom przysługuje prawo żądania od Administratora niezwłocznego usunięcia danych osobowych, realizowane za pośrednictwem panelu użytkownika dostępnego po zalogowaniu i narzędzi umożliwiających dostęp do konta w przypadku zapomnianego hasła. W przypadku kont użytkowników, usunięcie danych polega na anonimizacji danych umożliwiających identyfikację Użytkownika. Administrator zastrzega sobie prawo wstrzymania realizacji żądania usunięcia danych w celu ochrony prawnie uzasadnionego interesu Administratora (np. w gdy Użytkownik dopuścił się naruszenia Regulaminu czy dane zostały pozyskane wskutek prowadzonej korespondencji). W przypadku usługi Newsletter, Użytkownik ma możliwość samodzielnego usunięcia swoich danych osobowych korzystając z odnośnika umieszczonego w każdej przesyłanej wiadomości e-mail.',
                    style: h2,
                  ),
                  Text(
                    '• Prawo do ograniczenia przetwarzania danych osobowych - Użytkownikom przysługuje prawo ograniczenia przetwarzania danych osobowych w przypadkach wskazanych w art. 18 RODO, m.in. kwestionowania prawidłowość danych osobowych, realizowane na żądanie złożone do Administratora',
                    style: h2,
                  ),
                  Text(
                    '• Prawo do przenoszenia danych osobowych - Użytkownikom przysługuje prawo uzyskania od Administratora, danych osobowych dotyczących Użytkownika w ustrukturyzowanym, powszechnie używanym formacie nadającym się do odczytu maszynowego, realizowane na żądanie złożone do Administratora',
                    style: h2,
                  ),
                  Text(
                    '• Prawo wniesienia sprzeciwu wobec przetwarzania danych osobowych - Użytkownikom przysługuje prawo wniesienia sprzeciwu wobec przetwarzania jego danych osobowych w przypadkach określonych w art. 21 RODO, realizowane na żądanie złożone do Administratora',
                    style: h2,
                  ),
                  Text(
                    '• Prawo wniesienia skargi - Użytkownikom przysługuje prawo wniesienia skargi do organu nadzorczego zajmującego się ochroną danych osobowych.',
                    style: h2,
                  ),
                ],
              ),
              FormFieldDivider(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '§14 Kontakt do Administratora',
                    style: h1,
                  ),
                  FormFieldDivider(),
                  Text(
                    'Z Administratorem można skontaktować się w jeden z poniższych sposobów',
                    style: h2,
                  ),
                  FormFieldDivider(),
                  Text(
                    '• Adres poczty elektronicznej - bobifypl@gmail.com',
                    style: h2,
                  ),
                  Text(
                    '• Formularz kontaktowy - dostępny z poziomu aplikacji',
                    style: h2,
                  ),
                ],
              ),
              FormFieldDivider(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '§15 Wymagania Serwisu',
                    style: h1,
                  ),
                  FormFieldDivider(),
                  Text(
                    '• Ograniczenie zapisu i dostępu do plików Cookie na Urządzeniu Użytkownika może spowodować nieprawidłowe działanie niektórych funkcji Serwisu.',
                    style: h2,
                  ),
                  Text(
                    '• Administrator nie ponosi żadnej odpowiedzialności za nieprawidłowo działające funkcje Serwisu w przypadku gdy Użytkownik ograniczy w jakikolwiek sposób możliwość zapisywania i odczytu plików Cookie.',
                    style: h2,
                  ),
                ],
              ),
              FormFieldDivider(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '§16 Linki zewnętrzne',
                    style: h1,
                  ),
                  FormFieldDivider(),
                  Text(
                    'W Serwisie - artykułach, postach, wpisach czy komentarzach Użytkowników mogą znajdować się odnośniki do witryn zewnętrznych, z którymi Właściciel serwisu nie współpracuje. Linki te oraz strony lub pliki pod nimi wskazane mogą być niebezpieczne dla Twojego Urządzenia lub stanowić zagrożenie bezpieczeństwa Twoich danych. Administrator nie ponosi odpowiedzialności za zawartość znajdującą się poza Serwisem.',
                    style: h2,
                  ),
                ],
              ),
              FormFieldDivider(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '§17 Zmiany w Polityce Prywatności',
                    style: h1,
                  ),
                  FormFieldDivider(),
                  Text(
                    '• Administrator zastrzega sobie prawo do dowolnej zmiany niniejszej Polityki Prywatności bez konieczności informowania o tym Użytkowników w zakresie stosowania i wykorzystywania danych anonimowych lub stosowania plików Cookie.',
                    style: h2,
                  ),
                  Text(
                    '• Administrator zastrzega sobie prawo do dowolnej zmiany niniejszej Polityki Prywatności w zakresie przetwarzania Danych Osobowych, o czym poinformuje Użytkowników posiadających konta użytkownika lub zapisanych do usługi newsletter, za pośrednictwem poczty elektronicznej w terminie do 7 dni od zmiany zapisów. Dalsze korzystanie z usług oznacza zapoznanie się i akceptację wprowadzonych zmian Polityki Prywatności. W przypadku w którym Użytkownik nie będzie się zgadzał z wprowadzonymi zmianami, ma obowiązek usunąć swoje konto z Serwisu lub wypisać się z usługi Newsletter.',
                    style: h2,
                  ),
                  Text(
                    '• Wprowadzone zmiany w Polityce Prywatności będą publikowane na tej podstronie Serwisu.',
                    style: h2,
                  ),
                  FormFieldDivider(),
                  Text(
                    'Wprowadzone zmiany wchodzą w życie z chwilą ich publikacji.',
                    style: h2,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
