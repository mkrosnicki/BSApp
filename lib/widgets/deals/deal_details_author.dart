import 'package:BSApp/models/deal_model.dart';
import 'package:BSApp/screens/users/user_profile_screen.dart';
import 'package:BSApp/util/my_colors_provider.dart';
import 'package:BSApp/widgets/common/user_avatar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DealDetailsAuthor extends StatelessWidget {
  final DealModel deal;

  const DealDetailsAuthor(this.deal);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pushNamed(UserProfileScreen.routeName, arguments: deal.addedById),
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
        margin: const EdgeInsets.symmetric(vertical: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 12.0),
                  child: SizedBox(
                    width: 38.0,
                    child: UserAvatar(
                      username: deal.adderName,
                      image: deal.userAvatar,
                      radius: 24,
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Okazja dodana przez',
                      style: TextStyle(fontSize: 11, color: Colors.grey, height: 1.5),
                    ),
                    Text(
                      deal.adderName,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const Icon(
              CupertinoIcons.chevron_right,
              color: MyColorsProvider.DEEP_BLUE,
            ),
          ],
        ),
      ),
    );
  }
}
