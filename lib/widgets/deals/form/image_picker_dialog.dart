import 'package:BSApp/services/html_dom_service.dart';
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
        borderRadius: BorderRadius.circular(20),
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
                padding: const EdgeInsets.only(top: 15),
                height: 300,
                child: ListView.builder(
                  itemCount: _imageUrls.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedIndex = index;
                              });
                            },
                            child: Container(
                              decoration: (index == _selectedIndex) ? BoxDecoration(
                                  border: Border.all(color: Colors.blue, width: 2.5)) : null,
                              child: Image.network(
                                _imageUrls[index],
                                height: 200.0,
                              ),
                            ),
                          ),
                        ),
                        const Divider(
                          thickness: 2,
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
            Align(
              child: TextButton(
                  onPressed: () {
                    String imageUrl = '';
                    if(_selectedIndex != -1) {
                      imageUrl = _imageUrls[_selectedIndex];
                    }
                    Navigator.of(context).pop(imageUrl);
                  },
                  child: const Text(
                    'Użyj zaznaczonego zdjęcia',
                  )),
            ),
            Align(
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
