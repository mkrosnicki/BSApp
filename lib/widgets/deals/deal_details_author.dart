import 'package:BSApp/models/adder_info_model.dart';
import 'package:BSApp/providers/deals.dart';
import 'package:BSApp/screens/users/user_profile_screen.dart';
import 'package:BSApp/util/my_colors_provider.dart';
import 'package:BSApp/util/my_styling_provider.dart';
import 'package:BSApp/widgets/common/loading_indicator.dart';
import 'package:BSApp/widgets/common/server_error_splash.dart';
import 'package:BSApp/widgets/common/user_avatar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DealDetailsAuthor extends StatefulWidget {
  final String dealId;

  const DealDetailsAuthor(this.dealId);

  @override
  _DealDetailsAuthorState createState() => _DealDetailsAuthorState();
}

class _DealDetailsAuthorState extends State<DealDetailsAuthor> {
  AdderInfoModel _adderInfo;
  bool _isLoading = true;

  Future<void> _initAdderInfo(final BuildContext context, final String dealId) async {
    _adderInfo ??= await Provider.of<Deals>(context, listen: false).fetchAdderInfo(dealId);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initAdderInfo(context, widget.dealId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            height: 300,
            color: Colors.white,
            child: const Center(child: LoadingIndicator()),
          );
        } else {
          if (snapshot.error != null) {
            return const Center(
              child: ServerErrorSplash(),
            );
          } else {
            if (_adderInfo == null) {
              return Container();
            }
            return GestureDetector(
              onTap: () {
                if (_adderInfo != null) {
                  Navigator.of(context).pushNamed(UserProfileScreen.routeName, arguments: _adderInfo.id);
                }
              },
              child: Column(
                children: [
                  Container(
                    color: MyColorsProvider.BACKGROUND_COLOR,
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 6.0),
                    margin: const EdgeInsets.only(top: 10.0),
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      'DODANA PRZEZ',
                      style: TextStyle(color: MyColorsProvider.DEEP_BLUE, fontSize: 12),
                    ),
                  ),
                  Container(
                    margin: MyStylingProvider.ITEMS_MARGIN,
                    decoration: MyStylingProvider.ITEMS_BORDER.copyWith(color: Colors.white),
                    padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
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
                                  username: _adderInfo != null ? _adderInfo.username : 'U',
                                  image: _adderInfo != null ? _adderInfo.avatar : null,
                                  imagePath: _adderInfo != null? _adderInfo.imagePath : null,
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
                                  _adderInfo != null ? _adderInfo.username : 'Usuni??ty u??ytkownik',
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
                ],
              ),
            );
          }
        }
      },
    );
  }
}
