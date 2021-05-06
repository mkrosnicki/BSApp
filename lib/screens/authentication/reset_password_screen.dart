import 'package:BSApp/providers/auth.dart';
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
    await showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              title: const Text('Hasło zostało zresetowane'),
              actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(ctx).pop();
                      },
                      child: const Text('Ok'),
                    )
                  ],
                )
              ],
            ));
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BaseAppBar(
        title: 'Resetowanie hasła',
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 50.0),
                    child: Text(
                      'Resetowanie',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 40),
                    ),
                  ),
                  const Text(
                    'Hasła',
                    style:
                    TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'W celu zresetowania hasła podaj adres email na jaki zostało zarejestrowane konto.',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black38,
                    ),
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          decoration: const InputDecoration(labelText: 'Email'),
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
