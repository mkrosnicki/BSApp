import 'package:BSApp/models/custom_exception.dart';
import 'package:BSApp/providers/auth.dart';
import 'package:BSApp/util/util_functions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  Map<String, String> _authData = {'email': '', 'password': ''};
  bool _isLoading = false;

  var _emailController = TextEditingController();
  var _passwordController = TextEditingController();

  var formFieldDecoration = InputDecoration(
    enabledBorder: InputBorder.none,
    focusedErrorBorder: InputBorder.none,
    filled: true,
    fillColor: UtilFunctions.hexToColor('#e4e6e8'),
    focusColor: UtilFunctions.hexToColor('#e4e6e8'),
    border: UnderlineInputBorder(
      borderSide: const BorderSide(width: 0, style: BorderStyle.none),
    ),
    focusedBorder: UnderlineInputBorder(
      borderSide: const BorderSide(width: 0),
    ),
  );

  Future<void> _submit() async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    setState(() {
      _isLoading = true;
    });
    try {
      setState(() {
        _isLoading = true;
      });
      await Provider.of<Auth>(context, listen: false).login(
        _authData['email'],
        _authData['password'],
      );
    } on CustomException catch (error) {
      var errorMessage =
          'Logowanie zakończyło się niepowodzeniem. Spróbuj później.';
      if (error.toString().contains('must be a well-formed email address')) {
        errorMessage = 'Email w złym w formacie.';
      } else if (error.toString().contains('There is no user witch such email.')) {
        errorMessage = 'Nieprawidłowe hasło i / lub login.';
      } else if (error.toString().contains('Email is not verified')) {
        errorMessage = 'Konto nie zostało zweryfikowane. Sprawdź skrzynkę i aktywuj konto!';
      }
      await _showErrorDialog(errorMessage);
    } catch (error) {
      const errorMessage =
          'Logowanie zakończyło się niepowodzeniem. Spróbuj później.';
      await _showErrorDialog(errorMessage);
    }

    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _showErrorDialog(String message) async {
    await showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Błąd logowania'),
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
    return _isLoading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : SingleChildScrollView(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      alignment: Alignment.centerLeft,
                      child: const Text('E-mail'),
                    ),
                    TextFormField(
                      controller: _emailController,
                      cursorColor: Colors.black,
                      keyboardType: TextInputType.emailAddress,
                      decoration: formFieldDecoration,
                      validator: (value) {
                        if (value.isEmpty || !value.contains('@')) {
                          return 'Nieprawidłowy e-mail!';
                        } else {
                          return null;
                        }
                      },
                      onSaved: (value) {
                        _authData['email'] = value;
                      },
                    ),
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      alignment: Alignment.centerLeft,
                      child: const Text('Hasło'),
                    ),
                    TextFormField(
                      controller: _passwordController,
                      cursorColor: Colors.black,
                      obscureText: true,
                      decoration: formFieldDecoration,
                      validator: (value) {
                        if (value.length < 3) {
                          return 'Za krótkie hasło!';
                        } else {
                          return null;
                        }
                      },
                      onSaved: (value) {
                        _authData['password'] = value;
                      },
                    ),
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      alignment: Alignment.centerLeft,
                      child: const Text(
                          'Nie pamiętasz hasła? - Trudno, masz problem :D'), // TODO
                    ),
                    Container(
                      width: double.infinity,
                      child: ElevatedButton(
                        child: Text('Zaloguj się'),
                        onPressed: _submit,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
