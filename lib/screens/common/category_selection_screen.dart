import 'package:BSApp/models/category_model.dart';
import 'package:BSApp/providers/categories.dart';
import 'package:BSApp/util/my_icons_provider.dart';
import 'package:BSApp/widgets/bars/app_bar_button.dart';
import 'package:BSApp/widgets/bars/app_bar_close_button.dart';
import 'package:BSApp/widgets/bars/base_app_bar.dart';
import 'package:BSApp/widgets/common/loading_indicator.dart';
import 'package:BSApp/widgets/common/server_error_splash.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategorySelectionScreen extends StatefulWidget {
  static const routeName = '/category-selection';

  @override
  _CategorySelectionScreenState createState() =>
      _CategorySelectionScreenState();
}

class _CategorySelectionScreenState extends State<CategorySelectionScreen> {
  List<CategoryModel> _allCategories;
  final List<CategoryModel> _selectedCategories = [];

  Future<void> _initCategories() {
    if (_allCategories == null) {
      return Provider.of<Categories>(context, listen: false)
          .fetchCategories()
          .then((_) {
        _allCategories =
            Provider.of<Categories>(context, listen: false).categories;
      });
    } else {
      return Future(() => {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: 'Wybierz kategorię',
        leading: AppBarButton(
          icon: MyIconsProvider.BACK_BLACK_ICON,
          onPress: () => _goUp(),
        ),
        actions: const [
          AppBarCloseButton(Colors.black),
        ],
      ),
      body: _selectedCategories.isEmpty
          ? FutureBuilder(
              future: _initCategories(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: LoadingIndicator());
                } else {
                  if (snapshot.error != null) {
                    return const Center(
                      child: ServerErrorSplash(),
                    );
                  } else {
                    return _buildCategoriesList(_allCategories);
                  }
                }
              },
            )
          : _buildCategoriesList(_selectedCategories
              .elementAt(_selectedCategories.length - 1)
              .subCategories),
    );
  }

  Widget _buildCategoriesList(List<CategoryModel> categories) {
    return Column(
      children: [
        if (_selectedCategories.isNotEmpty)
          ListTile(
            title: Text(
              _selectedCategories.elementAt(_selectedCategories.length - 1).name,
              style: const TextStyle(fontSize: 14),
            ),
            focusColor: Colors.grey,
          ),
        if (_selectedCategories.isNotEmpty)
          FlatButton(
            onPressed: () => _finishSelection(),
            child: ListTile(
              title: Text(
                'Wszystko w kategorii ${_selectedCategories.elementAt(_selectedCategories.length - 1).name}',
                style: const TextStyle(fontSize: 14),
              ),
              subtitle: const Text('Interesuje mnie wszystko w tej kategorii'),
              focusColor: Colors.grey,
            ),
          ),
        Expanded(
          child: ListView.builder(
            itemBuilder: (context, index) => FlatButton(
              padding: EdgeInsets.zero,
              onPressed: () => _selectCategory(categories[index]),
              child: ListTile(
                tileColor: Colors.white,
                title: Text(
                  categories[index].name,
                  style: const TextStyle(fontSize: 14),
                ),
                leading: SizedBox(
                  height: 40,
                  width: 40,
                  child: Image.asset(
                    CategoryModelHelper.imagePathForCategory(categories[index]),
                    fit: BoxFit.fitHeight,
                  ),
                ),
                // subtitle: Text(
                //     '${categories[index].subCategories.length} pod${_getCategoriesSuffix(categories[index].subCategories.length)}'),
                subtitle: Text(categories[index].description,
                    style: const TextStyle(fontSize: 13)),
                trailing: categories[index].subCategories.isEmpty
                    ? MyIconsProvider.NONE
                    : MyIconsProvider.FORWARD_ICON,
                focusColor: Colors.grey,
              ),
            ),
            itemCount: categories.length,
          ),
        ),
      ],
    );
  }

  void _selectCategory(CategoryModel category) {
    if (category.subCategories.isEmpty) {
      _selectedCategories.add(category);
      _finishSelection();
    } else {
      setState(() {
        _selectedCategories.add(category);
      });
    }
  }

  void _finishSelection() {
    Navigator.of(context).pop([..._selectedCategories]);
  }

  void _goUp() {
    if (_selectedCategories.isEmpty) {
      Navigator.of(context).pop(null);
    } else {
      setState(() {
        _selectedCategories.removeLast();
      });
    }
  }
}
