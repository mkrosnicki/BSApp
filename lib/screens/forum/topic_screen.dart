import 'package:BSApp/util/my_styling_provider.dart';
import 'package:BSApp/widgets/bars/app_bar_back_button.dart';
import 'package:BSApp/widgets/bars/app_bar_bottom_border.dart';
import 'package:BSApp/widgets/bars/app_bar_close_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TopicScreen extends StatefulWidget {
  static const routeName = '/topic';

  @override
  _TopicScreenState createState() => _TopicScreenState();
}

class _TopicScreenState extends State<TopicScreen> {

  bool isInReplyState;


  @override
  void initState() {
    isInReplyState = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Forum',
          style: MyStylingProvider.TEXT_BLACK,
        ),
        automaticallyImplyLeading: false,
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        bottom: const AppBarBottomBorder(),
        leading: const AppBarBackButton(Colors.black),
        actions: [
          const AppBarCloseButton(Colors.black),
        ],
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => {
          setState(() {
            FocusScope.of(context).unfocus();
            isInReplyState = false;
          })
        },
        child: Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
          padding: const EdgeInsets.all(0),
          child: Stack(
            children: [
              Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Text(
                            'Temat',
                            style: TextStyle(fontSize: 22),
                          ),
                          Text(
                            'Temat',
                            style: TextStyle(fontSize: 22),
                          ),
                          Text(
                            'Temat',
                            style: TextStyle(fontSize: 22),
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (isInReplyState) Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.1,
                    color: Colors.white,
                    child: Center(
                      child: TextField(
                        autofocus: true,
                        decoration: InputDecoration(
                          labelText: 'Napisz komentarz',
                          fillColor: Colors.white,
                          filled: true,
                        ),
                        onChanged: (value) {
                          // setState(() {
                          //   _commentText = value;
                          // });
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: isInReplyState ? null : FloatingActionButton(
        onPressed: () {
          setState(() {
            isInReplyState = true;
          });
        },
        child: const Icon(CupertinoIcons.reply),
        backgroundColor: Colors.deepOrange,
      ),
      // bottomNavigationBar: MyNavigationBar(1),
    );
  }
}
