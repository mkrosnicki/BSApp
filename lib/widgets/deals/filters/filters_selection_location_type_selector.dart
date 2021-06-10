import 'package:BSApp/models/filter_settings.dart';
import 'package:BSApp/util/image_assets_helper.dart';
import 'package:BSApp/util/my_colors_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FiltersSelectionLocationTypeSelector extends StatelessWidget {
  final FilterSettings filterSettings;
  final GestureTapCallback onTap;
  final bool enabled;

  const FiltersSelectionLocationTypeSelector(this.filterSettings, this.onTap, this.enabled);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: enabled ? onTap : null,
      child: Container(
        // margin: const EdgeInsets.only(left: 16),
        padding: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 12.0),
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
                      ImageAssetsHelper.localPath(),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Lokalizacja',
                      style: TextStyle(fontSize: 11, color: Colors.grey, height: 1.3),
                    ),
                    Text(
                      filterSettings.voivodeship == null ? 'Cała Polska' : filterSettings.locationString,
                      style: const TextStyle(
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Icon(
              CupertinoIcons.chevron_right,
              color: enabled ? MyColorsProvider.DEEP_BLUE : Colors.grey,
            )
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
