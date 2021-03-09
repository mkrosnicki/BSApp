import 'package:BSApp/providers/auth.dart';
import 'package:BSApp/providers/deals.dart';
import 'package:BSApp/screens/auth_screen.dart';
import 'package:BSApp/screens/deal_details_screen.dart';
import 'package:BSApp/screens/deals_screen.dart';
import 'package:BSApp/screens/favourites_screen.dart';
import 'package:BSApp/screens/forum_screen.dart';
import 'package:BSApp/screens/profile_options_screen.dart';
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
        ChangeNotifierProvider(
          create: (_) => Deals(),
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
          AuthScreen.routeName: (ctx) => AuthScreen(),
          ProfileOptionsScreen.routeName: (ctx) => ProfileOptionsScreen(),
          FavouritesScreen.routeName: (ctx) => FavouritesScreen(),
          ForumScreen.routeName: (ctx) => ForumScreen(),
          DealsScreen.routeName: (ctx) => DealsScreen(),
          DealDetailsScreen.routeName: (ctx) => DealDetailsScreen(),
        },
      ),
    );
  }
}
