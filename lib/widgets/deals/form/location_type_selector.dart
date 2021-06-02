import 'package:BSApp/models/location_type.dart';
import 'package:BSApp/util/image_assets_helper.dart';
import 'package:BSApp/util/my_colors_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LocationTypeSelector extends StatelessWidget {

  final LocationType locationType;
  final GestureTapCallback onTap;

  const LocationTypeSelector(this.locationType, this.onTap);

  bool get isInternet {
    return locationType == LocationType.INTERNET;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        // margin: const EdgeInsets.only(left: 16),
        padding: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: SizedBox(
                    height: 30.0,
                    child: Image.asset(
                      isInternet ? ImageAssetsHelper.internetPath() : ImageAssetsHelper.localPath(),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Rodzaj oferty',
                      style: const TextStyle(
                          fontSize: 11, color: Colors.grey, height: 1.3),
                    ),
                    Text(
                      isInternet ? 'Internetowa' : 'Lokalna',
                      style: const TextStyle(
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Icon(CupertinoIcons.arrow_2_circlepath, color: MyColorsProvider.DEEP_BLUE,)
          ],
        ),
      ),
    );
  }

  // void _switchLocationType() {
  //   setState(() {
  //     locationType = isInternetSelected ? LocationType.LOCAL : LocationType.INTERNET;
  //   });
  // }

}
