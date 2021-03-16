import 'package:BSApp/providers/auth.dart';
import 'package:BSApp/providers/categories.dart';
import 'package:BSApp/providers/comments.dart';
import 'package:BSApp/providers/deals.dart';
import 'file:///D:/Projects/Flutter/BSApp/lib/screens/profile/added_deals_screen.dart';
import 'file:///D:/Projects/Flutter/BSApp/lib/screens/common/category_selection_screen.dart';
import 'file:///D:/Projects/Flutter/BSApp/lib/screens/deals/deal_details_screen.dart';
import 'file:///D:/Projects/Flutter/BSApp/lib/screens/deals/deal_search_result_screen.dart';
import 'file:///D:/Projects/Flutter/BSApp/lib/screens/deals/deals_screen.dart';
import 'file:///D:/Projects/Flutter/BSApp/lib/screens/favourites/favourites_screen.dart';
import 'file:///D:/Projects/Flutter/BSApp/lib/screens/forum/forum_screen.dart';
import 'file:///D:/Projects/Flutter/BSApp/lib/screens/authentication/login_registration_screen.dart';
import 'file:///D:/Projects/Flutter/BSApp/lib/screens/profile/profile_options_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, Deals>(
          update: (context, auth, previousDeals) {
            print(auth);
            print(auth.token);
            return Deals(
                allDeals: previousDeals != null ? previousDeals.deals : [],
                fetchedObservedDeals: previousDeals != null ? previousDeals.fetchedObservedDeals : [],
                token: auth.token);
          },
        ),
        ChangeNotifierProxyProvider<Auth, Comments>(
          update: (context, auth, previousComments) {
            return Comments(token: auth.token);
          },
        ),
        ChangeNotifierProvider(
          create: (_) => Categories(),
        ),
      ],
      child: MaterialApp(
        title: 'BSApp',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
          accentColor: Color.fromRGBO(99, 137, 217, 1),
          // This makes the visual density adapt to the platform that you run
          // the app on. For desktop platforms, the controls will be smaller and
          // closer together (more dense) than on mobile platforms.
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: DealsScreen(),
        routes: {
          LoginRegistrationScreen.routeName: (ctx) => LoginRegistrationScreen(),
          ProfileOptionsScreen.routeName: (ctx) => ProfileOptionsScreen(),
          AddedDealsScreen.routeName: (ctx) => AddedDealsScreen(),
          FavouritesScreen.routeName: (ctx) => FavouritesScreen(),
          ForumScreen.routeName: (ctx) => ForumScreen(),
          DealsScreen.routeName: (ctx) => DealsScreen(),
          DealDetailsScreen.routeName: (ctx) => DealDetailsScreen(),
          DealSearchResultScreen.routeName: (ctx) => DealSearchResultScreen(),
          CategorySelectionScreen.routeName: (ctx) => CategorySelectionScreen(),
        },
      ),
    );
  }
}
