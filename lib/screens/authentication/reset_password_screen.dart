import 'package:BSApp/providers/auth.dart';
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
              title: const Text('Hasło zostao zresetowane'),
              actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextButton(
                      child: const Text('Ok'),
                      onPressed: () {
                        Navigator.of(ctx).pop();
                      },
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
      appBar: AppBar(
        title: const Text('Resetowanie hasła'),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 50.0),
                      child: Text(
                        'Resetowanie',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 40),
                      ),
                    ),
                    Text(
                      'Hasła',
                      style:
                      const TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'W celu zresetowania hasła podaj adres email na jaki zostało zarejestrowane konto.',
                      style: const TextStyle(
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
                              child: const Text('Zresetuj hasło'),
                              onPressed: _submit,
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
      ),
    );
  }
}
