import 'package:BSApp/providers/auth.dart';
import 'package:BSApp/services/custom_info.dart';
import 'package:BSApp/util/my_styling_provider.dart';
import 'package:BSApp/widgets/bars/app_bar_back_button.dart';
import 'package:BSApp/widgets/bars/base_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ResetPasswordScreen extends StatefulWidget {
  static const routeName = '/reset-password';

  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  String _email = '';

  Future<void> _submit() async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    Provider.of<Auth>(context, listen: false).resetUserPassword(_email);
    await confirmInfo(
      context,
      title: 'Sukces',
      textContent: 'Hasło zostało zresetowane',
    );
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const BaseAppBar(
        title: 'Resetowanie hasła',
        leading: AppBarBackButton(Colors.black),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: const Text(
                      'W celu zresetowania hasła podaj przypisany do konta adres email.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          decoration: MyStylingProvider
                              .TEXT_FORM_FIELD_DECORATION
                              .copyWith(hintText: 'Email'),
                          keyboardType: TextInputType.emailAddress,
                          cursorColor: Colors.black,
                          validator: (value) {
                            if (value.isEmpty || !value.contains('@')) {
                              return 'Nieprawidłowy e-mail!';
                            } else {
                              return null;
                            }
                          },
                          onSaved: (value) {
                            _email = value;
                          },
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 20),
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: _submit,
                            child: const Text('Zresetuj hasło'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
