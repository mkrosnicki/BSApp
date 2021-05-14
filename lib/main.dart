import 'package:BSApp/providers/activities.dart';
import 'package:BSApp/providers/auth.dart';
import 'package:BSApp/providers/categories.dart';
import 'package:BSApp/providers/comments.dart';
import 'package:BSApp/providers/current_user.dart';
import 'package:BSApp/providers/deals.dart';
import 'package:BSApp/providers/locations.dart';
import 'package:BSApp/providers/notifications.dart';
import 'package:BSApp/providers/posts.dart';
import 'package:BSApp/providers/searches.dart';
import 'package:BSApp/providers/topic_categories.dart';
import 'package:BSApp/providers/topics.dart';
import 'package:BSApp/providers/users.dart';
import 'package:BSApp/screens/authentication/change_password_screen.dart';
import 'package:BSApp/screens/authentication/login_registration_screen.dart';
import 'package:BSApp/screens/authentication/reset_password_screen.dart';
import 'package:BSApp/screens/comments/comment_screen.dart';
import 'package:BSApp/screens/common/category_selection_screen.dart';
import 'package:BSApp/screens/common/location_selection_screen.dart';
import 'package:BSApp/screens/deals/add_deal_screen.dart';
import 'package:BSApp/screens/deals/deal_details_screen.dart';
import 'package:BSApp/screens/deals/deal_search_result_screen.dart';
import 'package:BSApp/screens/deals/deals_screen.dart';
import 'package:BSApp/screens/favourites/favourites_screen.dart';
import 'package:BSApp/screens/forum/forum_category_screen.dart';
import 'package:BSApp/screens/forum/forum_screen.dart';
import 'package:BSApp/screens/forum/new_topic_screen.dart';
import 'package:BSApp/screens/forum/topic_screen.dart';
import 'package:BSApp/screens/main_screen.dart';
import 'package:BSApp/screens/notifications/notifications_screen.dart';
import 'package:BSApp/screens/profile/your_activity_screen.dart';
import 'package:BSApp/screens/profile/your_deals_screen.dart';
import 'package:BSApp/screens/profile/your_profile_screen.dart';
import 'package:BSApp/screens/profile/your_topics_screen.dart';
import 'package:BSApp/screens/users/user_profile_screen.dart';
import 'package:BSApp/util/my_colors_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('pl');
    // FlutterStatusbarcolor.setStatusBarColor(Colors.white);
    // SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    //     statusBarColor: Colors.white
    // ));
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, CurrentUser>(
          create: (context) => CurrentUser.empty(),
          lazy: false,
          update: (context, auth, previousCurrentUser) =>
          previousCurrentUser..update(auth.token, auth.userId),
        ),
        ChangeNotifierProxyProvider<Auth, Deals>(
          create: (context) => Deals.empty(),
          lazy: true,
          update: (context, auth, previousDeals) =>
              previousDeals..update(auth.token, previousDeals.deals),
        ),
        ChangeNotifierProxyProvider<Auth, Comments>(
          create: (context) => Comments.empty(),
          update: (context, auth, previousComments) => previousComments..update(auth.token, previousComments.comments),
        ),
        ChangeNotifierProxyProvider<Auth, Searches>(
          create: (context) => Searches.empty(),
          update: (context, auth, previousSearches) =>
              previousSearches..update(auth.token, previousSearches.searches),
        ),
        ChangeNotifierProxyProvider<Auth, Topics>(
          create: (context) => Topics.empty(),
          lazy: true,
          update: (context, auth, previousTopics) =>
              previousTopics..update(auth.token, previousTopics.topics),
        ),
        ChangeNotifierProxyProvider<Auth, Posts>(
          create: (context) => Posts.empty(),
          lazy: true,
          update: (context, auth, previousPosts) =>
              previousPosts..update(auth.token, previousPosts.posts),
        ),
        ChangeNotifierProxyProvider<CurrentUser, Notifications>(
          create: (context) => Notifications.empty(),
          lazy: false,
          update: (context, currentUser, previousNotifications) =>
          previousNotifications..update(currentUser.token, currentUser.me?.id, currentUser.me?.notificationsSeenAt),
        ),
        ChangeNotifierProxyProvider<Auth, Activities>(
          create: (context) => Activities.empty(),
          lazy: true,
          update: (context, auth, previousActivities) =>
          previousActivities..update(auth.token, previousActivities.activities),
        ),
        ChangeNotifierProxyProvider<Auth, Users>(
          create: (context) => Users.empty(),
          lazy: false,
          update: (context, auth, previousUsers) =>
          previousUsers..update(),
        ),
        ChangeNotifierProvider(
          create: (_) => Categories(),
        ),
        ChangeNotifierProvider(
          create: (_) => TopicCategories(),
        ),
        ChangeNotifierProvider(
          create: (_) => Locations(),
        ),
      ],
      child: MaterialApp(
        title: 'BSApp',
        theme: ThemeData(
          fontFamily: 'InterUI',
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          // scaffoldBackgroundColor: Color.fromRGBO(248, 250, 251, 1),
          scaffoldBackgroundColor: MyColorsProvider.BACKGROUND_COLOR,
          primarySwatch: Colors.blue,
          accentColor: const Color.fromRGBO(99, 137, 217, 1),
          // This makes the visual density adapt to the platform that you run
          // the app on. For desktop platforms, the controls will be smaller and
          // closer together (more dense) than on mobile platforms.
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: MainScreen(),
        routes: {
          LoginRegistrationScreen.routeName: (ctx) => LoginRegistrationScreen(),
          YourProfileScreen.routeName: (ctx) => YourProfileScreen(),
          YourDealsScreen.routeName: (ctx) => YourDealsScreen(),
          YourTopicsScreen.routeName: (ctx) => YourTopicsScreen(),
          YourActivityScreen.routeName: (ctx) => YourActivityScreen(),
          FavouritesScreen.routeName: (ctx) => FavouritesScreen(),
          ForumScreen.routeName: (ctx) => ForumScreen(),
          NotificationsScreen.routeName: (ctx) => NotificationsScreen(),
          ForumCategoryScreen.routeName: (ctx) => ForumCategoryScreen(),
          TopicScreen.routeName: (ctx) => TopicScreen(),
          DealsScreen.routeName: (ctx) => DealsScreen(),
          DealDetailsScreen.routeName: (ctx) => DealDetailsScreen(),
          DealSearchResultScreen.routeName: (ctx) => DealSearchResultScreen(),
          CategorySelectionScreen.routeName: (ctx) => CategorySelectionScreen(),
          LocationSelectionScreen.routeName: (ctx) => LocationSelectionScreen(),
          ResetPasswordScreen.routeName: (ctx) => ResetPasswordScreen(),
          UserProfileScreen.routeName: (ctx) => UserProfileScreen(),
          ChangePasswordScreen.routeName: (ctx) => ChangePasswordScreen(),
          AddDealScreen.routeName: (ctx) => AddDealScreen(),
          NewTopicScreen.routeName: (ctx) => NewTopicScreen(),
          CommentScreen.routeName: (ctx) => CommentScreen(),
        },
      ),
    );
  }
}
