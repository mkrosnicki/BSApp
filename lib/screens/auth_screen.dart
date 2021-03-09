import 'package:BSApp/models/http_exception.dart';
import 'package:BSApp/providers/auth.dart';
import 'file:///D:/Projects/Flutter/BSApp/lib/util/util_functions.dart';
import 'package:BSApp/widgets/my_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthScreen extends StatefulWidget {
  static const routeName = '/auth';

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {

  final GlobalKey<FormState> _formKey = GlobalKey();
  var _isLoading = false;

  Map<String, String> _authData = {
    'email': '',
    'password': ''
  };

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
    print('sbumit');
    if (!_formKey.currentState.validate()) {
      // Invalid!
      print('validate');
      return;
    }
    _formKey.currentState.save();
    setState(() {
      _isLoading = true;
    });
    try {
      // TODO login vs signup
      // if (_authMode == AuthMode.Login) {
      if (true) {
        // Log user in
        await Provider.of<Auth>(context, listen: false).login(
          _authData['email'],
          _authData['password'],
        );
      } else {
        // Sign user up
        await Provider.of<Auth>(context, listen: false).signup(
          _authData['email'],
          _authData['password'],
        );
      }
    } on HttpException catch (error) {
      print('error.message');
      print(error.message);
      var errorMessage = 'Authentication failed';
      if (error.toString().contains('EMAIL_EXISTS')) {
        errorMessage = 'This email address is already in use.';
      } else if (error.toString().contains('INVALID_EMAIL')) {
        errorMessage = 'This is not a valid email address';
      } else if (error.toString().contains('WEAK_PASSWORD')) {
        errorMessage = 'This password is too weak.';
      } else if (error.toString().contains('EMAIL_NOT_FOUND')) {
        errorMessage = 'Could not find a user with that email.';
      } else if (error.toString().contains('Unauthorized')) {
        errorMessage = 'Nieprawidłowe hasło lub login.';
      }
      _showErrorDialog(errorMessage);
    } catch (error) {
      const errorMessage =
          'Could not authenticate you. Please try again later.';
      _showErrorDialog(errorMessage);
    }

    setState(() {
      _isLoading = false;
    });
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Błąd logowania'),
        content: Text(message),
        actions: <Widget>[
          FlatButton(
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
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
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
                cursorColor: Colors.black,
                obscureText: true,
                decoration: formFieldDecoration,
                validator: (value) {
                  if (value.length < 5) {
                    return 'Za krótkie hasło!';
                  } else {
                    return null;
                  }
                },
                onSaved: (value) {
                  _authData['password'] = value;
                },),
              Container(
                padding: const EdgeInsets.all(8.0),
                alignment: Alignment.centerLeft,
                child: const Text('Nie pamiętasz hasła?'),
              ),
              Container(
                width: double.infinity,
                child: RaisedButton(
                  child: Text('Zaloguj się'),
                  onPressed: _submit,
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: MyNavigationBar(3),
    );
  }
}
