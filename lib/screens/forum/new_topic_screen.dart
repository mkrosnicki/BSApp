import 'package:BSApp/models/topic_category_model.dart';
import 'package:BSApp/providers/topics.dart';
import 'package:BSApp/screens/forum/topic_screen.dart';
import 'package:BSApp/util/my_colors_provider.dart';
import 'package:BSApp/util/my_styling_provider.dart';
import 'package:BSApp/widgets/bars/app_bar_close_button.dart';
import 'package:BSApp/widgets/bars/base_app_bar.dart';
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

  @override
  Widget build(BuildContext context) {
    final passedCategory = ModalRoute.of(context).settings.arguments;
    topicCategory = passedCategory != null ? passedCategory as TopicCategoryModel : null;
    final node = FocusScope.of(context);
    return Scaffold(
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
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                cursorColor: Colors.black,
                textInputAction: TextInputAction.next,
                style: const TextStyle(fontSize: 12),
                decoration: textFieldDecoration.copyWith(hintText: 'Tytuł'),
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
                padding: EdgeInsets.all(8.0),
              ),
              TextFormField(
                minLines: 10,
                maxLines: 10,
                cursorColor: Colors.black,
                textInputAction: TextInputAction.next,
                style: const TextStyle(fontSize: 12),
                onFieldSubmitted: (_) => node.unfocus(),
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
    );
  }

  void _postNewTopic(TopicCategoryModel topicCategory) {
    Provider.of<Topics>(context, listen: false)
        .addNewTopic(_topicTitleController.text, _topicContentController.text,
            topicCategory.id)
        .then((topic) {
      Navigator.of(context)
          .popAndPushNamed(TopicScreen.routeName, arguments: topic);
    });
  }
}
