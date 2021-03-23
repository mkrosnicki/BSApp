import 'package:BSApp/models/custom_exception.dart';
import 'package:BSApp/providers/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChangePasswordScreen extends StatefulWidget {
  static const routeName = '/change-password';

  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  var _newPasswordController = TextEditingController();
  String _currentPassword = '';
  String _newPassword = '';

  Future<void> _submit() async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    try {
      await Provider.of<Auth>(context, listen: false).changeUserPassword(_currentPassword, _newPassword);
      await _showDialog('Zmiana hasła', 'Hasło zostało zmienione.');
      Navigator.of(context).pop();

    } on CustomException catch (error) {
      if (error.toString().contains('Old password does not match')) {
        //
        await _showDialog('Błąd podczas zmieniania hasła', 'Podane hasło nie jest obecnym hasłem!');
      }
    } catch (error) {
      const errorMessage =
          'Zmiana hasła zakończyła się niepowodzeniem. Spróbuj później.';
      await _showDialog('Błąd podczas zmieniania hasła', errorMessage);
    }
  }

  Future<void> _showDialog(String title, String message) async {
    await showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            child: Text('Ok'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Zmiana hasłą'),
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
                    Text(
                      'Zmiana',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 40),
                    ),
                    Text(
                      'Hasła',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 40),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'W celu podaj swoje obecne hasło, następnie wprowadź nowe.',
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
                            decoration: const InputDecoration(
                                labelText: 'Obecne hasło'),
                            obscureText: true,
                            cursorColor: Colors.black,
                            validator: (value) {
                              if (value.isEmpty || value.length < 3) {
                                return 'Zbyt krótkie hasło';
                              } else {
                                return null;
                              }
                            },
                            onSaved: (value) {
                              _currentPassword = value;
                            },
                          ),
                          TextFormField(
                            decoration:
                                const InputDecoration(labelText: 'Nowe hasło'),
                            obscureText: true,
                            cursorColor: Colors.black,
                            controller: _newPasswordController,
                            validator: (value) {
                              if (value.isEmpty || value.length < 3) {
                                return 'Zbyt krótkie hasło';
                              } else {
                                return null;
                              }
                            },
                            onSaved: (value) {
                              _newPassword = value;
                            },
                          ),
                          TextFormField(
                            decoration: const InputDecoration(
                                labelText: 'Potwierdź nowe hasło'),
                            obscureText: true,
                            cursorColor: Colors.black,
                            validator: (value) {
                              if (value != _newPasswordController.text) {
                                return 'Hasła nie są takie same!';
                              } else {
                                return null;
                              }
                            },
                            onSaved: (value) {
                              _newPassword = value;
                            },
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 20),
                            width: double.infinity,
                            child: ElevatedButton(
                              child: const Text('Zmień hasło'),
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
