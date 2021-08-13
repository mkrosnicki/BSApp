import 'package:BSApp/widgets/bars/app_bar_back_button.dart';
import 'package:BSApp/widgets/bars/base_app_bar.dart';
import 'package:BSApp/widgets/common/form_field_divider.dart';
import 'package:flutter/material.dart';

class RegulationsScreen extends StatelessWidget {
  static const routeName = '/regulations';

  static const TextStyle h1 = TextStyle(fontSize: 15, fontWeight: FontWeight.w600);
  static const TextStyle h2 = TextStyle(fontSize: 13);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BaseAppBar(
        leading: AppBarBackButton(Colors.white),
        title: 'Regulamin',
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
                    'I. Pojęcia ogólne',
                    style: h1,
                  ),
                  FormFieldDivider(),
                  Text(
                    '• Regulamin – niniejszy regulamin',
                    style: h2,
                  ),
                  Text(
                    '• Serwis – aplikacja mobilna "Bobify"',
                    style: h2,
                  ),
                  Text(
                    '• Usługodawca – właściciel serwisu będący osobą fizyczną - Maciej Krośnicki',
                    style: h2,
                  ),
                  Text(
                    '• Usługobiorca – każda osoba fizyczna, uzyskująca dostęp do Serwisu i korzystająca z usług świadczonych za pośrednictwem Serwisu przez Usługodawcę.',
                    style: h2,
                  ),
                  Text(
                    '• Komunikacja Drogą Elektroniczną – Komunikacja pomiędzy stronami za pośrednictwem poczty elektronicznej (e-mail) oraz formularzy kontaktowych dostępnych z poziomu aplikacji.',
                    style: h2,
                  ),
                ],
              ),
              FormFieldDivider(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'II. Postanowienia ogólne',
                    style: h1,
                  ),
                  FormFieldDivider(),
                  Text(
                    '• Regulamin, określa zasady funkcjonowania i użytkowania Serwisu oraz określa zakres praw i obowiązków Usługobiorców i Usługodawcy związanych z użytkowaniem Serwisu.',
                    style: h2,
                  ),
                  Text(
                    '• Przedmiotem usług Usługodawcy jest udostępnienie nieodpłatnych narzędzi w postaci Serwisu, umożliwiających Usługobiorcom dostęp do treści w postaci wpisów, artykułów i materiałów audiowizualnych lub aplikacji internetowych i formularzy elektronicznych',
                    style: h2,
                  ),
                  Text(
                    '• Wszelkie ewentualne treści, artykuły i informacje zawierające cechy wskazówek lub porad publikowane na łamach Serwisu są jedynie ogólnym zbiorem informacji i nie są kierowane do poszczególnych Usługobiorców. Usługodawca nie ponosi odpowiedzialności za wykorzystanie ich przez Usługobiorców.',
                    style: h2,
                  ),
                  Text(
                    '• Usługobiorca bierze na siebie pełną odpowiedzialno za sposób wykorzystania materiałów udostępnianych w ramach Serwisu w tym za wykorzystanie ich zgodnie z obowiązującymi przepisami prawa.',
                    style: h2,
                  ),
                  Text(
                    '• Usługodawca nie udziela żadnej gwarancji co do przydatności materiałów umieszczonych w Serwisie.',
                    style: h2,
                  ),
                  Text(
                    '• Usługodawca nie ponosi odpowiedzialności z tytułu ewentualnych szkód poniesionych przez Usługobiorców Serwisu lub osoby trzecie w związku z korzystaniem z Serwisu. Wszelkie ryzyko związane z korzystaniem z Serwisu, a w szczególności z używaniem i wykorzystywaniem informacji umieszczonych w Serwisie, ponosi Usługobiorca korzystający z usług Serwisu.',
                    style: h2,
                  ),
                ],
              ),
              FormFieldDivider(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'III. Warunki używania Serwisu',
                    style: h1,
                  ),
                  FormFieldDivider(),
                  Text(
                    '• Używanie Serwisu przez każdego z Usługobiorców jest nieodpłatne i dobrowolne.',
                    style: h2,
                  ),
                  Text(
                    '• Usługobiorcy mają obowiązek zapoznania się z Regulaminem oraz pozostałymi dokumentami stanowiącymi jego integralną część i muszą zaakceptować w całości jego postanowienia w celu dalszego korzystania z Serwisu.',
                    style: h2,
                  ),
                  Text(
                    '• Usługobiorcy nie mogą wykorzystywać żadnych pozyskanych w Serwisie danych osobowych do celów marketingowych.',
                    style: h2,
                  ),
                  Text(
                    '• W celu zapewnienia bezpieczeństwa Usługodawcy, Usługobiorcy oraz innych Usługobiorców korzystających z Serwisu, wszyscy Usługobiorcy korzystający z Serwisu powinni stosować się do ogólnie przyjętych zasad bezpieczeństwa w sieci,',
                    style: h2,
                  ),
                  Text(
                    '• Zabrania się działań wykonywanych osobiście przez Usługobiorców lub przy użyciu oprorgamowania:',
                    style: h2,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 14.0),
                    child: Column(
                      children: [
                        Text('- bez zgody pisemnej, dekompilacji i analizy kodu źródłowego,'),
                        Text('- bez zgody pisemnej, powodujących nadmierne obciążenie serwera Serwisu,'),
                        Text(
                            '- bez zgody pisemnej, prób wykrycia luk w zabezpieczeniach Serwisu i konfiguracji serwera,'),
                        Text(
                            '- podejmowania prób wgrywania lub wszczykiwania na serwer i do bazy danych kodu, skryptów i oprogramowania mogących wyrządzić szkodę oprogramowaniu Serwisu, innym Usługobiorcom lub Usługodawcy,'),
                        Text(
                            '- podejmowania prób wgrywania lub wszczykiwania na serwer i do bazy danych kodu, skryptów i oprogramowania mogących śledzić lub wykradać dane Usługobiorców lub Usługodawcy,'),
                        Text(
                            '- podejmowania jakichkolwiek działań mających na celu uszkodzenie, zablokowanie działania Serwisu lub uniemożliwienie realizacji celu w jakim działa Serwis.'),
                      ],
                    ),
                  ),
                  Text(
                    '• W przypadku wykrycia zaistnienia lub potencjalnej możliwości zaistnienia incydentu Cyberbezpieczeństwa lub naruszenia RODO, Usługobiorcy w pierwszej kolejności powinni zgłosić ten fakt Usługodawcy w celu szybkiego usunięcia problemu / zagrożenia i zabezpieczenia interesów wszystkich Usługobiorców Serwisu.',
                    style: h2,
                  ),
                ],
              ),
              FormFieldDivider(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'IV. Warunki oraz zasady rejestracji',
                    style: h1,
                  ),
                  FormFieldDivider(),
                  Text(
                    '• Usługobiorcy mogą korzystać z Serwisu bez konieczności rejestracji.',
                    style: h2,
                  ),
                  Text(
                    '• Usługobiorcy muszą być zarejestrowani i posiadać konto w Serwisie by korzystać z dodatkowych usług świadczonych w Serwisie, dostępnych jedynie dla Usługobiorców po zalogowaniu.',
                    style: h2,
                  ),
                  Text(
                    '• Rejestracja w Serwisie jest dobrowolna.',
                    style: h2,
                  ),
                  Text(
                    '• Rejestracja w Serwisie jest nieodpłatna.',
                    style: h2,
                  ),
                  Text(
                    '• Każdy Usługobiorca może posiadać tylko jedno konto w Serwisie.',
                    style: h2,
                  ),
                  Text(
                    'Wymagania techniczne związane z rejestracją konta:',
                    style: h2,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 14.0),
                    child: Column(
                      children: [
                        Text('- posiadanie indywidualnego konta poczty elektronicznej e-mail,'),
                      ],
                    ),
                  ),
                  Text(
                    '• Rejestrujący się w Serwisie Usługobiorcy wyrażają zgodę na przetwarzanie ich danych osobowych przez Usługobiorcę w zakresie w jakim zostały one wprowadzone do Serwisu podczas procesu rejestracji oraz ich późniejszych zmianom lub usunięciu.',
                    style: h2,
                  ),
                  Text(
                    '• Usługodawca ma prawo zawieszać lub usuwać konta Usługobiorców według własnego uznania, uniemożliwiając lub ograniczając w ten sposób dostęp do poszczególnych lub wszystkich usług, treści, materiałów i zasobów Serwisu, w szczególności jeżeli Usługobiorca dopuści się łamania Regulaminu, powszechnie obowiązujących przepisów prawa, zasad współżycia społecznego lub działa na szkodę Usługodawcy lub innych Usługobiorców, uzasadnionego interesu Usługodawcy oraz podmiotów trzecich współpracujących lub nie z Usługodawcą.',
                    style: h2,
                  ),
                  Text(
                    '• Wszelkie usługi Serwisu mogą być zmieniane co do ich treści i zakresu, dodawane lub odejmowane, a także czasowo zawieszane lub dostęp do nich może być ograniczany, według swobodnej decyzji Usługodawcy, bez możliwości wnoszenia sprzeciwu w tym zakresie przez Usługobiorców.',
                    style: h2,
                  ),
                  Text(
                    '• Dodatkowe zasady bezpieczeństwa w zakresie korzystania z konta:',
                    style: h2,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 14.0),
                    child: Column(
                      children: [
                        Text(
                            '- Zabrania się Usługobiorcom zarejestrowanym w Serwisie do udostępniania loginu oraz hasła do swojego konta osobom trzecim.'),
                        Text(
                            '- Usługodawca nie ma prawa i nigdy nie będzie zażądać od Usługobiorcy hasła do wybranego konta.'),
                      ],
                    ),
                  ),
                  Text(
                    '• Usuwanie konta:',
                    style: h2,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 14.0),
                    child: Column(
                      children: [
                        Text(
                            '- Każdy Usługobiorca posiadający konto w Serwisie ma możliwość samodzielnego usunięcia konta z Serwisu.'),
                        Text('- Usługobiorcy mogą to uczynić po zalogowaniu się w panelu w Serwisie.'),
                        Text(
                            '- Usunięcie konta skutkuje usunięciem wszelkich danych identyfikacyjnych Usługobiorcy oraz anonimizacją nazwy użytkownika i adresu e-mail.'),
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
                    'V. Warunki świadczenia usługi Newsletter',
                    style: h1,
                  ),
                  FormFieldDivider(),
                  Text(
                    '• Usługobiorcy mogą korzystać z Serwisu bez konieczności zapisywania się do Newslettera.',
                    style: h2,
                  ),
                  Text(
                    '• Zapisanie się usługi Newslettera jest dobrowolne.',
                    style: h2,
                  ),
                  Text(
                    '• Zapisanie się do usługi Newslettera jest nieodpłatne.',
                    style: h2,
                  ),
                  Text(
                    '• Wymagania techniczne związane z usługą Newsletter:',
                    style: h2,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 14.0),
                    child: Column(
                      children: [
                        Text('- posiadanie indywidualnego konta poczty elektronicznej e-mail,'),
                      ],
                    ),
                  ),
                  Text(
                    '• Warunki świadczenia usługi Newsletter:',
                    style: h2,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 14.0),
                    child: Column(
                      children: [
                        Text(
                            '- podanie w formularzu elektronicznym indywidualnego konta poczty elektronicznej e-mail,'),
                        Text(
                            '- weryfikacja podanego konta pocztowego e-mail poprzez uruchomienie przesłanego na nie odnośnika,'),
                        Text('- wyrażenie zgody na otrzymywania powiadomień e-mail,'),
                      ],
                    ),
                  ),
                  Text(
                    '• Wypisanie się z usługi Newsletter:',
                    style: h2,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 14.0),
                    child: Column(
                      children: [
                        Text(
                            '- Każdy Usługobiorca zapisany do usługi Newsletter ma możliwość samodzielnego wypisania się z Usługi.'),
                        Text(
                            '- Usługobiorcy mogą to uczynić poprzez link umieszczony w każdej przesłanej wiadomości e-mail.'),
                        Text(
                            '- Wypisanie się z usługi Newsletter skutkuje usunięciem podanego adresu e-mail z bazy Usługodawcy.'),
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
                    'VI. Warunki komunikacji i świadczenia pozostałych usług w Serwisie',
                    style: h1,
                  ),
                  FormFieldDivider(),
                  Text(
                    '• Serwis udostępnia usługi i narzędzia umożliwiające Usługobiorcom interakcję z Serwisem w postaci:',
                    style: h2,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 14.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('- Formularz kontaktowy'),
                        Text('- Komentowania wpisów i artykułów'),
                        Text('- Publikowania własnych treści w postaci wpisów i artykułów'),
                        Text('- Publikowanie własnych treści w postaci materiałów graficznych i multimedialnych'),
                      ],
                    ),
                  ),
                  Text(
                    '• W przypadku kontaktu Usługobiorcy z Usługodawcą, dane osobowe Usługobiorców będa przetwarzane zgodnie z "Polityką Prywatności", stanowiącą integralną część Regulaminu.',
                    style: h2,
                  ),
                  Text(
                    '• Warunki umieszczania treści przez Usługobiorców w Serwisie:',
                    style: h2,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 14.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            '- Zabrania się umieszczania w Serwisie treści obraźliwych lub oszczerczych względem Usługodawcy, pozostałych Usługobiorców, osób trzecich oraz podmiotów trzecich,'),
                        Text(
                            '- Zabrania się umieszczania w Serwisie materiałów tekstowcyh, graficznych, audiowizualnych, skryptów, programów i innych utworów, na które Usługobiorca nie posiada się licencji, lub których autor praw majątkowych nie wyraził zgody na darmową publikację,'),
                        Text(
                            '- Zabrania się umieszczania w Serwisie treści wulgarnych, pornograficznych, erotycznych i niezgodnych z polskim i europejskim prawem a także odnośników do stron zawierających wskazane treści,'),
                        Text(
                            '- Zabrania się umieszczania w Serwisie skryptów i programów nadmiernie obciążających serwer, oprogramowania nielegalnego, oprogramowania służącego do naruszania zabezpieczeń oraz innych podobnych działań a także odnośników do stron zawierających wskazane materiały,'),
                        Text(
                            '- Zabrania się umieszczania w Serwisie treści merketingowych i reklamujących inne serwisy komercyjne, produkty, usługi czy komercyjne strony internetowe'),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 14.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            '- Każdy Usługobiorca zapisany do usługi Newsletter ma możliwość samodzielnego wypisania się z Usługi.'),
                        Text(
                            '- Usługobiorcy mogą to uczynić poprzez link umieszczony w każdej przesłanej wiadomości e-mail.'),
                        Text(
                            '- Wypisanie się z usługi Newsletter skutkuje usunięciem podanego adresu e-mail z bazy Usługodawcy.'),
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
                    'VII. Gromadzenie danych o Usługobiorcach',
                    style: h1,
                  ),
                  FormFieldDivider(),
                  Text(
                    '• W celu prawidłowego świadczenia usług przez Serwis, zabezpieczenia prawnego interesu Usługodawcy oraz w celu zapewnienia zgodności działania Serwisu z obowiązującym prawem, Usługodawca za pośrednictwem Serwisu gromadzi i przetwarza niektóre dane o Użytkownikach.',
                    style: h2,
                  ),
                  Text(
                    '• W celu prawidłowego świadczenia usług, Serwis wykorzystuje i zapisuje niektóre anonimowe informacje o Usługobiorcy w plikach cookies.',
                    style: h2,
                  ),
                  Text(
                    '• Zakres, cele, sposób oraz zasady przetwarzania danych dostępne są w załącznikach do Regulaminu: „Obowiązek informacyjny RODO” oraz w „Polityce prywatności„, stanowiących integralną część Regulaminu.',
                    style: h2,
                  ),
                  Text(
                    '• Dane zbierane podczas rejestracji:',
                    style: h2,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 14.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('- Nazwa użytkownika, imię i nazwisko, adres e-mail'),
                        Text(
                            '- W przypadku Usługobiorców zalogowanych (posiadających konto w Serwisie), w plikach cookies zapisywanych na urządzeniu Usługobiorcy może być umieszczony identyfikator Usługobiorcy powiązany z kontem Usługobiorcy'),
                        Text(
                            '- Wypisanie się z usługi Newsletter skutkuje usunięciem podanego adresu e-mail z bazy Usługodawcy.'),
                      ],
                    ),
                  ),
                  Text(
                    '• Dane zbierane podczas zapisywania do newslettera:',
                    style: h2,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 14.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('- adres e-mail'),
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
                    'VIII. Prawa autorskie',
                    style: h1,
                  ),
                  FormFieldDivider(),
                  Text(
                    '• Właścicielem Serwisu oraz praw autorskich do serwisu jest Usługodawca.',
                    style: h2,
                  ),
                  Text(
                    '• Część danych zamieszczonych w Serwisie są chronione prawami autorskimi należącymi do firm, instytucji i osób trzecich, niepowiązanych w jakikolwiek sposób z Usługodawcą, i są wykorzystywane na podstawie uzyskanych licencji, lub opartych na licencji darmowej.',
                    style: h2,
                  ),
                  Text(
                    '• Na podstawie Ustawy z dnia 4 lutego 1994 o prawie autorskim zabrania się wykorzystywania, kopiowania, reprodukowania w jakiejkolwiek formie oraz przetrzymywania w systemach wyszukiwania z wyłączeniem wyszukiwarki Google, Bing, Yahoo, NetSprint, DuckDuckGo, Facebook oraz LinkedIn jakichkolwiek artykułów, opisów, zdjęć oraz wszelkich innych treści, materiałów graficznych, wideo lub audio znajdujących się w Serwisie bez pisemnej zgody lub zgody przekazanej za pomocą Komunikacji Drogą Elektroniczną ich prawnego właściciela.',
                    style: h2,
                  ),
                  Text(
                    '• Zgodnie z Ustawą z dnia 4 lutego 1994 o prawie autorskim ochronie nie podlegają proste informacje prasowe, rozumiane jako same informacje, bez komentarza i oceny ich autora. Autor rozumie to jako możliwość wykorzystywania informacji z zamieszczonych w serwisie tekstów, ale już nie kopiowania całości lub części artykułów o ile nie zostało to oznaczone w poszczególnym materiale udostępnionym w Serwisie.',
                    style: h2,
                  ),
                ],
              ),
              FormFieldDivider(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'IX. Zmiany Regulaminu',
                    style: h1,
                  ),
                  FormFieldDivider(),
                  Text(
                    '• Wszelkie postanowienia Regulaminu mogą być w każdej chwili jednostronnie zmieniane przez Usługodawcę, bez podawania przyczyn.',
                    style: h2,
                  ),
                  Text(
                    '• Informacja o zmianie Regulaminu będzie rozsyłana Drogą Elektroniczną do Usługobiorców zarejestrowanych w Serwisie.',
                    style: h2,
                  ),
                  Text(
                    '• W przypadku zmiany Regulaminu jego postanowienia wchodzą w życie natychmiast po jego publikacji dla Usługobiorców nieposiadających konta w Serwisie.',
                    style: h2,
                  ),
                  Text(
                    '• W przypadku zmiany Regulaminu jego postanowienia wchodzą w życie z 7-dniowym okresem przejściowym dla Usługobiorców posiadających konta w Serwisie zarejestrowane przez zmianą Regulaminu.',
                    style: h2,
                  ),
                  Text(
                    '• Traktuje się iż każdy Usługobiorca, kontynuujący korzystanie z Serwisu po zmianie Regulaminu akceptuje go w całości.',
                    style: h2,
                  ),
                ],
              ),
              FormFieldDivider(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'X. Postanowienia końcowe',
                    style: h1,
                  ),
                  FormFieldDivider(),
                  Text(
                    '• Usługodawca nie odpowiada w żaden sposób, jak tylko pozwalają na to obowiązujące przepisy prawa, za treści przekazywane i publikowane w Serwisie przez Usługobiorców, za ich prawdziwość, rzetelność, autentyczność czy wady prawne.',
                    style: h2,
                  ),
                  Text(
                    '• Usługodawca dokona wszelkich starań by usługi Serwisu były oferowane w sposób ciągły. Nie ponosi on jednak żadnej odpowiedzialności za zakłócenia spowodowane siłą wyższą lub niedozwoloną ingerencją Usługobiorców, osób trzecich czy działalnością zewnętrznych automatycznych programów.',
                    style: h2,
                  ),
                  Text(
                    '• Usługodawca zastrzega sobie prawo do zmiany jakichkolwiek informacji umieszczonych w Serwisie w wybranym przez Usługodawcę terminie, bez konieczności uprzedniego powiadomienia Usługobiorców korzystających z usług Serwisu.',
                    style: h2,
                  ),
                  Text(
                    '• Usługodawca zastrzega sobie prawo do czasowego, całkowitego lub częściowego wyłączenia Serwisu w celu jego ulepszenia, dodawania usług lub przeprowadzania konserwacji, bez wcześniejszego uprzedzania o tym Usługobiorców.',
                    style: h2,
                  ),
                  Text(
                    '• Usługodawca zastrzega sobie prawo do wyłączenia Serwisu na stałe, bez wcześniejszego uprzedzania o tym Usługobiorców.',
                    style: h2,
                  ),
                  Text(
                    '• Usługodawca zastrzega sobie prawo do dokonania cesji w części lub w całości wszelkich swoich praw i obowiązków związanych z Serwisem, bez zgody i możliwości wyrażania jakichkolwiek sprzeciwów przez Usługobiorców.',
                    style: h2,
                  ),
                  Text(
                    '• Obowiązujące oraz poprzednie Regulaminy Serwisu znajduję się na tej podstronie pod aktualnym Regulaminem.',
                    style: h2,
                  ),
                  Text(
                    '• We wszelkich sprawach związanych z działalnością Serwisu należy kontaktować się z Usługodawcę korzystając z jednej z poniższych form kontaktu:',
                    style: h2,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 14.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('- Używając formularza kontaktowego dostępnego w Serwisie'),
                        Text('- Wysyłając wiadomość na adres e-mail: bobifypl@gmail.com'),
                      ],
                    ),
                  ),
                  Text(
                    '• Kontakt przy użyciu wskazanych środków komunikacji wyłącznie w sprawach związanych z prowadzonym Serwisem.',
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
