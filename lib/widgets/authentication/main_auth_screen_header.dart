import 'package:BSApp/util/fake_data_provider.dart';
import 'package:BSApp/widgets/common/user_avatar.dart';
import 'package:flutter/material.dart';

class MainAuthScreenHeader extends StatelessWidget {

  const MainAuthScreenHeader();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.only(top: 10.0),
      child: Flex(
        direction: Axis.horizontal,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            // ignore: avoid_unnecessary_containers
            child: Container(
              child: Flex(
                direction: Axis.vertical,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: UserAvatar(
                      username: 'U',
                      imagePath: FakeDataProvider.USER_AVATAR_PATH,
                      radius: 40,
                    ),
                  ),
                  Flex(
                    direction: Axis.vertical,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 2.0),
                        child: GestureDetector(
                          onTap: () => {},
                          child: const Text(
                            'Witaj w BSAPP',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
