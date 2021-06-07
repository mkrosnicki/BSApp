import 'package:BSApp/services/html_dom_service.dart';
import 'package:BSApp/widgets/common/primary_button.dart';
import 'package:flutter/material.dart';

class ImagePickerDialog extends StatefulWidget {
  final String webSiteUrl;

  const ImagePickerDialog(this.webSiteUrl);

  @override
  _ImagePickerDialogState createState() => _ImagePickerDialogState();
}

class _ImagePickerDialogState extends State<ImagePickerDialog> {
  List<String> _imageUrls = [];

  int _selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6.0),
      ),
      elevation: 0,
      child: _content(context),
    );
  }

  Widget _content(context) {
    return Stack(
      children: <Widget>[
        Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(top: 12.0),
                height: 300,
                child: ListView.builder(
                  itemCount: _imageUrls.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(8.0),
                          decoration: (index == _selectedIndex)
                              ? BoxDecoration(border: Border.all(color: Colors.blue, width: 2.5))
                              : BoxDecoration(border: Border.all(color: Colors.white, width: 2.5)),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedIndex = index;
                              });
                            },
                            child: Container(
                              child: Image.network(
                                _imageUrls[index],
                                height: 200.0,
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 6.0),
              child: PrimaryButton(
                'Użyj zaznaczonego zdjęcia',
                () {
                  String imageUrl = '';
                  if (_selectedIndex != -1) {
                    imageUrl = _imageUrls[_selectedIndex];
                  }
                  Navigator.of(context).pop(imageUrl);
                },
              ),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 6.0),
              child: TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    'Anuluj',
                  )),
            ),
          ],
        ),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    _fetchUrls();
  }

  Future<void> _fetchUrls() async {
    final urls = await HtmlDomService.getImageUrlsFrom(widget.webSiteUrl);
    setState(() {
      _imageUrls = urls;
    });
  }
}
