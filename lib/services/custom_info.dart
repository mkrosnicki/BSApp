import 'package:BSApp/util/my_colors_provider.dart';
import 'package:BSApp/widgets/common/primary_button.dart';
import 'package:flutter/material.dart';

Future<void> infoDialog(
  BuildContext context, {
  String title,
  String textContent,
  String textOK,
      String additionalActionText,
      VoidCallback additionalAction,
}) async {
  await showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      // title: title,
      contentPadding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 22.0),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.only(top: 14.0, bottom: 6.0),
            child: Text(
              title ?? 'Sukces',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
            child: Text(
              textContent ?? '',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 13, height: 1.3),
            ),
          ),
          Container(
            height: 30.0,
            margin: const EdgeInsets.only(top: 14.0),
            padding: EdgeInsets.zero,
            width: double.infinity,
            child: ButtonTheme(
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              child: PrimaryButton(
                textOK ?? 'OK',
                    () => Navigator.pop(context, true),
                fontSize: 13,
              ),
            ),
          ),
          if (additionalAction != null) Container(
            height: 30.0,
            width: double.infinity,
            margin: const EdgeInsets.only(top: 6.0),
            padding: EdgeInsets.zero,
            child: ButtonTheme(
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              child: TextButton(
                style: ButtonStyle(
                  padding: MaterialStateProperty.all(EdgeInsets.zero),
                ),
                onPressed: additionalAction,
                child: Text(
                  additionalActionText ?? 'Wykonaj',
                  style: const TextStyle(fontSize: 13, color: MyColorsProvider.DEEP_BLUE),
                ),
              ),
            ),
          )
        ],
      ),
    ),
  );
}
