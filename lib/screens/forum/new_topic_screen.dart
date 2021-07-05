import 'package:BSApp/models/topic_category_model.dart';
import 'package:BSApp/models/topic_screen_arguments.dart';
import 'package:BSApp/providers/topic_categories.dart';
import 'package:BSApp/providers/topics.dart';
import 'package:BSApp/screens/forum/topic_screen.dart';
import 'package:BSApp/util/image_assets_helper.dart';
import 'package:BSApp/util/my_colors_provider.dart';
import 'package:BSApp/util/my_styling_provider.dart';
import 'package:BSApp/widgets/bars/app_bar_close_button.dart';
import 'package:BSApp/widgets/bars/base_app_bar.dart';
import 'package:BSApp/widgets/common/form_field_title.dart';
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
    contentPadding: EdgeInsets.only(left: 12.0, right: 12.0, bottom: 8.0, top: 8.0),
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
        leading: const AppBarCloseButton(Colors.white),
        actions: [
          TextButton(
            onPressed: () {
              if (_formKey.currentState.validate()) {
                _postNewTopic(topicCategory);
              }
            },
            child: const Text(
              'Wyślij',
              style: TextStyle(color: Colors.white),
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    FocusScope.of(context).unfocus();
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return FutureBuilder(
                          future: Provider.of<TopicCategories>(context, listen: false).fetchTopicCategories(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return const Center(child: LoadingIndicator());
                            } else {
                              if (snapshot.error != null) {
                                return const Center(
                                  child: ServerErrorSplash(),
                                );
                              } else {
                                return Consumer<TopicCategories>(
                                  builder: (context, topicCategoriesData, child) {
                                    return ListView.builder(
                                      itemCount: topicCategoriesData.topicCategories.length + 1,
                                      itemBuilder: (context, index) {
                                        if (index == 0) {
                                          return Container(
                                            alignment: Alignment.center,
                                            padding: const EdgeInsets.only(bottom: 8.0, top: 14.0),
                                            child: const Text('Wybierz temat'),
                                          );
                                        } else {
                                          final TopicCategoryModel topic =
                                              topicCategoriesData.topicCategories[index - 1];
                                          return GestureDetector(
                                            onTap: () => _chooseCategory(topic),
                                            child: ListTile(
                                              leading: SizedBox(
                                                height: 35,
                                                width: 35,
                                                child: Image.asset(
                                                  ImageAssetsHelper.topicCategoryPath(topic.name),
                                                  fit: BoxFit.fitHeight,
                                                ),
                                              ),
                                              title: Text(
                                                topic.name,
                                                style: const TextStyle(fontSize: 12),
                                              ),
                                            ),
                                          );
                                        }
                                      },
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
                    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
                    margin: const EdgeInsets.only(bottom: 14.0, top: 6.0),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      border: Border(
                        bottom: BorderSide(color: MyColorsProvider.GREY_BORDER_COLOR),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            if (topicCategory != null)
                              Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: SizedBox(
                                  height: 25,
                                  width: 25,
                                  child: Image.asset(
                                    ImageAssetsHelper.topicCategoryPath(topicCategory.name),
                                    fit: BoxFit.fitHeight,
                                  ),
                                ),
                              ),
                            Text(
                              topicCategory != null ? topicCategory.name : 'Wybierz temat',
                              style: const TextStyle(fontSize: 13, color: Colors.black87),
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
                const FormFieldTitle('Tytuł'),
                TextFormField(
                  cursorColor: Colors.black,
                  textInputAction: TextInputAction.next,
                  style: const TextStyle(fontSize: 13),
                  decoration: MyStylingProvider.textFormFiledDecorationWithLabelText('Tytuł'),
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
                const FormFieldTitle('Treść'),
                TextFormField(
                  minLines: 12,
                  maxLines: 12,
                  cursorColor: Colors.black,
                  textInputAction: TextInputAction.next,
                  style: const TextStyle(fontSize: 13),
                  onFieldSubmitted: (_) => FocusScope.of(context).unfocus(),
                  decoration: MyStylingProvider.textFormFiledDecorationWithLabelText('Napisz coś...'),
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
        .addNewTopic(_topicTitleController.text, _topicContentController.text, topicCategory.id)
        .then((topic) {
      Navigator.of(context).popAndPushNamed(TopicScreen.routeName, arguments: TopicScreenArguments(topic));
    });
  }

  void _chooseCategory(TopicCategoryModel topicCategory) {
    Navigator.pop(context);
    setState(() {
      this.topicCategory = topicCategory;
    });
  }
}
