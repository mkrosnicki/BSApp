import 'package:BSApp/providers/notifications.dart';
import 'package:BSApp/providers/topics.dart';
import 'package:BSApp/screens/forum/start_search_topic_button.dart';
import 'package:BSApp/util/my_colors_provider.dart';
import 'package:BSApp/util/my_styling_provider.dart';
import 'package:BSApp/widgets/bars/app_bar_back_button.dart';
import 'package:BSApp/widgets/bars/app_bar_bottom_border.dart';
import 'package:BSApp/widgets/common/loading_indicator.dart';
import 'package:BSApp/widgets/common/server_error_splash.dart';
import 'package:BSApp/widgets/forum/topic_item.dart';
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
  final TextEditingController _searchTopicTextController = TextEditingController();

  bool _loaded = false;
  bool _waiting = false;

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
      body: _loaded ? _resultsView(context) : _buildNoTopicsFoundSplashView(),
    );
  }

  Widget _resultsView(BuildContext context) {
    if (_waiting) {
      return const Center(child: LoadingIndicator());
    } else {
      return Consumer<Topics>(
        builder: (context, topicsData, child) {
          if (topicsData.topics.isEmpty) {
            return _buildNoTopicsFoundSplashView();
          } else {
            return ListView.builder(
              itemBuilder: (context, index) => TopicItem(topicsData.topics[index]),
              itemCount: topicsData.topics.length,
            );
          }
        },
      );
    }
    return SafeArea(
      child: FutureBuilder(
        future: Provider.of<Topics>(context, listen: false).fetchDiscussionEntriesByPhrase('ciek'),
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
                child: Consumer<Topics>(
                  builder: (context, topicsData, child) {
                    if (!topicsData.topics.isNotEmpty) {
                      return _buildNoTopicsFoundSplashView();
                    } else {
                      return ListView.builder(
                        itemBuilder: (context, index) => TopicItem(topicsData.topics[index]),
                        itemCount: topicsData.topics.length,
                      );
                    }
                  },
                ),
              );
            }
          }
        },
      ),
    );
  }

  Widget _buildNoTopicsFoundSplashView() {
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
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _searchTopicTextController,
              onSubmitted: (phrase) {
                _searchForPhrase(phrase);
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
        ],
      ),
    );
  }

  Future<void> _searchForPhrase(String phrase) async {
    setState(() {
      _waiting = true;
    });
    await Provider.of<Topics>(context, listen: false).fetchDiscussionEntriesByPhrase(phrase);
    setState(() {
      _waiting = false;
      _loaded = true;
    });
  }
}
