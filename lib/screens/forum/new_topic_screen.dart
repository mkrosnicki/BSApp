import 'package:BSApp/models/topic_category_model.dart';
import 'package:BSApp/models/topic_screen_arguments.dart';
import 'package:BSApp/providers/topic_categories.dart';
import 'package:BSApp/providers/topics.dart';
import 'package:BSApp/screens/forum/topic_screen.dart';
import 'package:BSApp/util/my_colors_provider.dart';
import 'package:BSApp/util/my_styling_provider.dart';
import 'package:BSApp/widgets/bars/app_bar_close_button.dart';
import 'package:BSApp/widgets/bars/base_app_bar.dart';
import 'package:BSApp/widgets/common/loading_indicator.dart';
import 'package:BSApp/widgets/common/server_error_splash.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NewTopicScreen extends StatefulWidget {
  static const routeName = '/new-topic';

  @override
  _NewTopicScreenState createState() => _NewTopicScreenState();
}

class _NewTopicScreenState extends State<NewTopicScreen> {
  TopicCategoryModel topicCategory;
  final _formKey = GlobalKey<FormState>();
  final _topicTitleController = TextEditingController();
  final _topicContentController = TextEditingController();

  static const textFieldDecoration = InputDecoration(
    hintStyle: TextStyle(fontSize: 13),
    border: InputBorder.none,
    isDense: true,
    contentPadding:
        EdgeInsets.only(left: 12.0, right: 12.0, bottom: 8.0, top: 8.0),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: MyColorsProvider.BLUE),
    ),
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: MyColorsProvider.GREY_BORDER_COLOR),
    ),
    errorBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: MyColorsProvider.RED_SHADY),
    ),
    focusedErrorBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: MyColorsProvider.RED_SHADY),
    ),
  );

  void initTopicCategory() {
    final passedCategory = ModalRoute.of(context).settings.arguments;
    if (topicCategory == null && passedCategory != null) {
      topicCategory = passedCategory as TopicCategoryModel;
    }
  }

  @override
  Widget build(BuildContext context) {
    initTopicCategory();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: BaseAppBar(
        title: 'Nowy temat',
        leading: const AppBarCloseButton(Colors.black),
        actions: [
          TextButton(
            onPressed: () {
              if (_formKey.currentState.validate()) {
                _postNewTopic(topicCategory);
              }
            },
            child: const Text(
              'Wyślij',
              style: MyStylingProvider.TEXT_BLUE,
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    FocusScope.of(context).unfocus();
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return FutureBuilder(
                          future:
                          Provider.of<TopicCategories>(context, listen: false)
                              .fetchTopicCategories(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(child: LoadingIndicator());
                            } else {
                              if (snapshot.error != null) {
                                return const Center(
                                  child: ServerErrorSplash(),
                                );
                              } else {
                                return Consumer<TopicCategories>(
                                  builder: (context, topicCategoriesData, child) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Text('Wybierz temat'),
                                          ),
                                          ...topicCategoriesData.topicCategories
                                              .map(
                                                (e) => GestureDetector(
                                              onTap: () => _chooseCategory(e),
                                              child: ListTile(
                                                leading: SizedBox(
                                                  height: 35,
                                                  width: 35,
                                                  child: Image.asset(
                                                    'assets/images/car.png',
                                                    fit: BoxFit.fitHeight,
                                                  ),
                                                ),
                                                title: Text(
                                                  e.name,
                                                  style:
                                                  TextStyle(fontSize: 12),
                                                ),
                                              ),
                                            ),
                                          )
                                              .toList(),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              }
                            }
                          },
                        );
                      },
                    );
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 8.0),
                    margin: const EdgeInsets.only(bottom: 14.0, top: 6.0),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      border: Border(
                        bottom:
                        BorderSide(color: MyColorsProvider.GREY_BORDER_COLOR),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            if (topicCategory != null) SizedBox(
                              height: 25,
                              width: 25,
                              child: Image.asset(
                                'assets/images/car.png',
                                fit: BoxFit.fitHeight,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text(
                                topicCategory != null
                                    ? topicCategory.name
                                    : 'Wybierz temat',
                                style: const TextStyle(
                                    fontSize: 13, color: Colors.black87),
                              ),
                            ),
                          ],
                        ),
                        const Icon(
                          CupertinoIcons.chevron_down,
                          size: 20,
                          color: MyColorsProvider.DEEP_BLUE,
                        ),
                      ],
                    ),
                  ),
                ),
                TextFormField(
                  cursorColor: Colors.black,
                  textInputAction: TextInputAction.next,
                  style: const TextStyle(fontSize: 13),
                  decoration: textFieldDecoration.copyWith(
                      hintText: 'Tytuł'),
                  controller: _topicTitleController,
                  validator: (value) {
                    if (value.isEmpty || value.length < 5) {
                      return 'Tytuł musi mieć przynajmniej 5 znaków!';
                    } else {
                      return null;
                    }
                  },
                  onSaved: (value) {
                    // _newPassword = value;
                  },
                ),
                const Padding(
                  padding: EdgeInsets.all(12.0),
                ),
                TextFormField(
                  minLines: 12,
                  maxLines: 12,
                  cursorColor: Colors.black,
                  textInputAction: TextInputAction.next,
                  style: const TextStyle(fontSize: 13),
                  onFieldSubmitted: (_) => FocusScope.of(context).unfocus(),
                  decoration:
                  textFieldDecoration.copyWith(hintText: 'Napisz coś...'),
                  controller: _topicContentController,
                  validator: (value) {
                    if (value.isEmpty || value.length < 20) {
                      return 'Treść musi składać się przynajmniej z 20 znaków!';
                    } else {
                      return null;
                    }
                  },
                  onSaved: (value) {
                    // _newPassword = value;
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _postNewTopic(TopicCategoryModel topicCategory) {
    Provider.of<Topics>(context, listen: false)
        .addNewTopic(_topicTitleController.text, _topicContentController.text,
            topicCategory.id)
        .then((topic) {
      Navigator.of(context)
          .popAndPushNamed(TopicScreen.routeName, arguments: TopicScreenArguments(topic));
    });
  }

  void _chooseCategory(TopicCategoryModel topicCategory) {
    Navigator.pop(context);
    setState(() {
      this.topicCategory = topicCategory;
    });
  }
}
