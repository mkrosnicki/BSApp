import 'package:BSApp/providers/categories.dart';
import 'package:BSApp/providers/current_user.dart';
import 'package:BSApp/providers/notifications.dart';
import 'package:BSApp/screens/forum/start_search_topic_button.dart';
import 'package:BSApp/screens/notifications/clear_notifications_button.dart';
import 'package:BSApp/util/my_colors_provider.dart';
import 'package:BSApp/util/my_styling_provider.dart';
import 'package:BSApp/widgets/bars/app_bar_add_to_observed_searches_button.dart';
import 'package:BSApp/widgets/bars/app_bar_back_button.dart';
import 'package:BSApp/widgets/bars/app_bar_bottom_border.dart';
import 'package:BSApp/widgets/bars/base_app_bar.dart';
import 'package:BSApp/widgets/common/loading_indicator.dart';
import 'package:BSApp/widgets/common/login_to_continue_splash.dart';
import 'package:BSApp/widgets/common/primary_button.dart';
import 'package:BSApp/widgets/common/server_error_splash.dart';
import 'package:BSApp/widgets/notifications/notifications_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class TopicSearchScreen extends StatefulWidget {
  static const routeName = '/topic-search';

  @override
  _TopicSearchScreenState createState() => _TopicSearchScreenState();
}

class _TopicSearchScreenState extends State<TopicSearchScreen> {
  final TextEditingController _searchTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        elevation: 0,
        title: _createSearchBox(context),
        leadingWidth: 40.0,
        backgroundColor: Colors.white,
        brightness: Brightness.light,
        backwardsCompatibility: false,
        systemOverlayStyle: const SystemUiOverlayStyle(statusBarColor: Colors.white),
        automaticallyImplyLeading: false,
        bottom: const AppBarBottomBorder(),
        leading: AppBarBackButton(
          Colors.black87,
          function: () => Navigator.of(context).pop(true),
        ),
        actions: [
          StartSearchTopicButton(),
        ],
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: Provider.of<Categories>(context, listen: false).fetchCategories(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: LoadingIndicator());
            } else {
              if (snapshot.error != null) {
                return const Center(
                  child: ServerErrorSplash(),
                );
              } else {
                return RefreshIndicator(
                  onRefresh: () => _refreshNotifications(context),
                  child: Consumer<Categories>(
                    builder: (context, categoriesData, child) {
                      if (categoriesData.categories.isNotEmpty) {
                        return _buildNoNotificationsSplashView();
                      } else {
                        return null;
                        // return ListView.builder(
                        //   itemBuilder: (context, index) =>
                        //       NotificationItem(categoriesData.myNotifications[index]),
                        //   itemCount: categoriesData.myNotifications.length,
                        // );
                      }
                    },
                  ),
                );
              }
            }
          },
        ),
      ),
    );
  }

  Widget _buildNoNotificationsSplashView() {
    return Container(
      color: Colors.white,
      child: const Center(
        child: Text(
          'Brak wyników wyszukiwania',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18, height: 1.5, fontWeight: FontWeight.w600, color: MyColorsProvider.LIGHT_GRAY),
        ),
      ),
    );
  }

  Future<void> _refreshNotifications(BuildContext context) async {
    await Provider.of<Notifications>(context, listen: false).fetchMyNotifications();
  }

  Widget _createSearchBox(BuildContext context) {
    return Container(
      width: double.infinity,
      alignment: Alignment.centerLeft,
      child:           Expanded(
        child: TextField(
          controller: _searchTextController,
          onSubmitted: (phrase) {
            // filterSettings.phrase = phrase;
            // _updateFilterSettings(filterSettings);
          },
          keyboardType: TextInputType.text,
          style: const TextStyle(fontSize: 12),
          decoration: MyStylingProvider.TEXT_FIELD_DECORATION.copyWith(
            hintText: 'Czego szukasz?',
            prefixIcon: const Padding(
              padding: EdgeInsets.all(0.0),
              child: Icon(
                CupertinoIcons.search,
                color: Colors.black54,
                size: 15,
              ),
            ),
            prefixIconConstraints: BoxConstraints.tight(
              const Size.square(30),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void deactivate() {
    Provider.of<Notifications>(context, listen: false).updateNotificationsTimestamp();
    Provider.of<CurrentUser>(context, listen: false).updateNotificationsTimestamp();
    super.deactivate();
  }
}
