import 'package:BSApp/models/add_deal_model.dart';
import 'package:BSApp/models/age_type.dart';
import 'package:BSApp/models/filter_settings.dart';
import 'package:BSApp/util/image_assets_helper.dart';
import 'package:BSApp/util/my_colors_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FiltersSelectionAgeTypesSelector extends StatelessWidget {
  final FilterSettings filterSettings;
  final Function(List<AgeType>) onSelection;

  FiltersSelectionAgeTypesSelector(this.filterSettings, this.onSelection);

  List<AgeType> selectedAgeTypes = [];

  @override
  Widget build(BuildContext context) {
    selectedAgeTypes = filterSettings.ageTypes;
    return InkWell(
      onTap: () => _openAgeTypesOptions(context),
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 12.0),
        child: Flex(
          direction: Axis.horizontal,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width - 60,
              child: Row(
                // crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: SizedBox(
                      height: 30.0,
                      child: Image.asset(
                        ImageAssetsHelper.ageTypePath(),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Odpowiednie dla wieku',
                          style: TextStyle(fontSize: 11, color: Colors.grey, height: 1.3),
                        ),
                        Text(
                          filterSettings.ageTypes != null && filterSettings.ageTypes.isNotEmpty
                              ? _ageTypesString(filterSettings.ageTypes)
                              : "Dowolny wiek",
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 40.0,
              child: Container(
                width: double.infinity,
                alignment: Alignment.centerRight,
                child: const Icon(
                  CupertinoIcons.chevron_right,
                  color: MyColorsProvider.DEEP_BLUE,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _openAgeTypesOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: ListView.builder(
                itemCount: AgeType.values.length + 1,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return Container(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      alignment: Alignment.center,
                      child: Text('Odpowiednie dla wieku'),
                    );
                  } else {
                    return _buildListTile(AgeType.values[index - 1], setModalState);
                  }
                },
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildListTile(AgeType ageType, StateSetter setModalState) {
    return ListTile(
      trailing: _isSelected(ageType)
          ? const Icon(
              CupertinoIcons.checkmark,
              size: 18,
              color: MyColorsProvider.DEEP_BLUE,
            )
          : Container(
              width: 0.0,
              height: 0.0,
            ),
      onTap: () {
        _selectAgeType(ageType, setModalState);
      },
      title: Text(
        AgeTypeHelper.getReadable(ageType),
        style: const TextStyle(fontSize: 13),
      ),
    );
  }

  bool _isSelected(final AgeType ageType) {
    return filterSettings.ageTypes.contains(ageType);
  }

  String _ageTypesString(final List<AgeType> ageTypes) {
    return ageTypes.map((e) => AgeTypeHelper.getReadable(e)).join(", ");
  }

  void _selectAgeType(final AgeType ageType, StateSetter setModalState) {
    setModalState(() {
      if (_isSelected(ageType)) {
        selectedAgeTypes.remove(ageType);
      } else {
        selectedAgeTypes.add(ageType);
      }
      onSelection(selectedAgeTypes);
    });
  }
}
