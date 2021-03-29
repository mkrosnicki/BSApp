import 'package:BSApp/models/age_type.dart';
import 'package:BSApp/models/category_model.dart';
import 'package:BSApp/models/city_model.dart';
import 'package:BSApp/models/voivodeship_model.dart';
import 'package:BSApp/screens/common/category_selection_screen.dart';
import 'package:BSApp/screens/common/location_selection_screen.dart';
import 'package:BSApp/widgets/bars/my_navigation_bar.dart';
import 'package:flutter/material.dart';

class AddDealScreen extends StatefulWidget {
  static const routeName = '/add-deal';

  @override
  _AddDealScreenState createState() => _AddDealScreenState();
}

class _AddDealScreenState extends State<AddDealScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  bool _isLoading = false;

  List<CategoryModel> categories = [];
  AgeType ageType;
  _LocationType locationType;
  City city;
  Voivodeship voivodeship;
  bool showInternetOnly = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Dodaj nową okazje!'),
          ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Dodaj nową okazje'),
                SizedBox(
                  height: 10,
                ),
                Text('Tytuł ogłoszenia'),
                TextFormField(),
                SizedBox(
                  height: 10,
                ),
                Text('Link do okazji'),
                TextFormField(),
                SizedBox(
                  height: 10,
                ),
                Text('Opis'),
                TextFormField(),
                ListTile(
                  title: const Text('Kategoria'),
                  subtitle: categories.isNotEmpty
                      ? Text(
                    categoriesString,
                    style: TextStyle(color: Colors.blue),
                  )
                      : const Text('Wszystkie kategorie'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => _openCategorySelector(context),
                ),
                ListTile(
                  title: const Text('Wiek dziecka'),
                  subtitle: ageType == null
                      ? const Text('Dowolny')
                      : Text(
                    ageTypesString,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Container(
                  width: double.infinity,
                  child: Wrap(
                    alignment: WrapAlignment.spaceEvenly,
                    children: _buildAgeTypeChips(),
                  ),
                ),
                Text('Lokalizacja okazji'),
                Container(
                  width: double.infinity,
                  child: Wrap(
                    alignment: WrapAlignment.center,
                    children: _buildLocationTypeChips(),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                ListTile(
                  title: const Text('Lokalizacja'),
                  subtitle: voivodeship != null
                      ? Text(
                    locationString,
                    style: TextStyle(color: Colors.blue),
                  )
                      : const Text('Cała Polska'),
                  trailing: Icon(Icons.chevron_right),
                  onTap: () => _openLocationSelector(context),
                  enabled: !showInternetOnly,
                ),
                SizedBox(
                  height: 10,
                ),
                Text('Okazja zaczyna się:'),
                TextFormField(),
                SizedBox(
                  height: 10,
                ),
                Text('Okazja kończy się:'),
                TextFormField(),
                SizedBox(
                  height: 10,
                ),
                Text('Kod promocji'),
                TextFormField(),
                SizedBox(
                  height: 10,
                ),
                Text('Wartość zniżki'),
                TextFormField(),
                SizedBox(
                  height: 10,
                ),
                Text('Regularna cena'),
                TextFormField(),
                SizedBox(
                  height: 10,
                ),
                Text('Aktualna cena'),
                TextFormField(),
                SizedBox(
                  height: 10,
                ),
                Text('Koszt dostawy'),
                TextFormField(),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: MyNavigationBar(2),
    );
  }

  String get categoriesString {
    return categories.map((e) => e.name).join(" / ");
  }

  String get ageTypesString {
    return AgeTypeHelper.getReadable(ageType);
  }

  String get locationString {
    return voivodeship != null
        ? '${voivodeship.name} / ${city != null ? city.name : 'Wszystkie miasta'}'
        : null;
  }

  _openCategorySelector(BuildContext context) async {
    var selectedCategories = await Navigator.of(context)
        .pushNamed(CategorySelectionScreen.routeName);
    if (selectedCategories != null) {
      setState(() {
        categories = selectedCategories;
      });
    }
  }

  _buildAgeTypeChips() {
    List<Widget> list = [];
    AgeType.values.forEach(
      (e) => list.add(Container(
        margin: EdgeInsets.symmetric(vertical: 0.0, horizontal: 4.0),
        child: ChoiceChip(
          label: Text(AgeTypeHelper.getReadable(e)),
          selected: ageType == e,
          onSelected: (isSelected) {
            setState(() {
              if (isSelected) {
                ageType = e;
              } else {
                ageType = null;
              }
            });
          },
        ),
      )),
    );
    return list;
  }

  _buildLocationTypeChips() {
    List<Widget> list = _LocationType.values
        .map(
          (e) => Container(
            margin: EdgeInsets.symmetric(vertical: 0.0, horizontal: 4.0),
            child: ChoiceChip(
              label: Text(_LocationTypeHelper.getReadable(e)),
              selected: locationType == e,
              onSelected: (isSelected) {
                setState(() {
                  locationType = e;
                  if (locationType == _LocationType.LOCAL) {
                    showInternetOnly = false;
                  } else {
                    showInternetOnly = true;
                  }
                });
              },
            ),
          ),
        )
        .toList();
    return list;
  }

  _openLocationSelector(BuildContext context) async {
    var locations = await Navigator.of(context)
        .pushNamed(LocationSelectionScreen.routeName);
    if (locations != null) {
      setState(() {
        voivodeship = (locations as List)[0];
        city = (locations as List)[1];
      });
    }
  }
}



enum _LocationType {INTERNET, LOCAL}

class _LocationTypeHelper {
  static String getReadable(_LocationType type) {
    switch (type) {
      case _LocationType.INTERNET:
        return 'Okzaja w internecie';
      case _LocationType.LOCAL:
        return 'Okazja stacjonarna';
    }
  }
}
