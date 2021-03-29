import 'package:BSApp/models/custom_exception.dart';
import 'package:BSApp/providers/auth.dart';
import 'package:BSApp/screens/authentication/reset_password_screen.dart';
import 'package:BSApp/util/my_styling_provider.dart';
import 'package:BSApp/widgets/common/grey-text-button.dart';
import 'package:BSApp/widgets/common/primary-button.dart';
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

  _getFormFieldDecoration(String hintText) {
    return MyStylingProvider.textFormFieldDecoration()
        .copyWith(hintText: hintText);
  }

  Future<void> _submit() async {
    bool wasError = false;

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
      print('end login');
    } on CustomException catch (error) {
      wasError = true;
      if (error.toString().contains('Email is not verified')) {
        //
        await _showNotVerifiedDialog();
      } else {
        var errorMessage =
            'Logowanie zakończyło się niepowodzeniem. Spróbuj później.';
        if (error.toString().contains('must be a well-formed email address')) {
          errorMessage = 'Email w złym w formacie.';
        } else if (error
            .toString()
            .contains('There is no user witch such email.')) {
          errorMessage = 'Nieprawidłowe hasło i / lub login.';
        }
        await _showErrorDialog(errorMessage);
      }
    } catch (error) {
      wasError = true;
      const errorMessage =
          'Logowanie zakończyło się niepowodzeniem. Spróbuj później.';
      await _showErrorDialog(errorMessage);
    } finally {
      if (wasError) {
        setState(() {
          _isLoading = false;
        });
      } else {
        Navigator.of(context).pop();
      }
    }
  }

  void _resendActivationToken(BuildContext context) {
    Provider.of<Auth>(context, listen: false)
        .resendVerificationToken(_emailController.text);
    Navigator.of(context).pop();
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

  Future<void> _showNotVerifiedDialog() async {
    await showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Błąd logowania'),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              "Konto nie zostało zweryfikowane. Sprawdź skrzynkę i aktywuj konto!\n Nie otrzymałeś linku aktywacyjnego? Wyślij go ponownie.",
            ),
            Column(crossAxisAlignment: CrossAxisAlignment.center,
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextButton(
                      child: Text(
                        'Ok',
                        textAlign: TextAlign.center,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      }),
                  TextButton(
                      child: Text(
                        'Wyślij link atywacyjny ponownie',
                        textAlign: TextAlign.center,
                      ),
                      onPressed: () {
                        _resendActivationToken(context);
                      })
                ]),
          ],
        ),
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
                      padding:
                          EdgeInsets.symmetric(horizontal: 0.0, vertical: 12.0),
                      child: Text(
                        'Zaloguj się',
                        style: TextStyle(
                            color: Colors.black87,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 6.0, horizontal: 0.0),
                      child: TextFormField(
                        controller: _emailController,
                        cursorColor: Colors.black,
                        keyboardType: TextInputType.emailAddress,
                        decoration: _getFormFieldDecoration('E-mail'),
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
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 6.0, horizontal: 0.0),
                      child: TextFormField(
                        controller: _passwordController,
                        cursorColor: Colors.black,
                        obscureText: true,
                        decoration: _getFormFieldDecoration('Hasło'),
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
                    ),
                    Container(
                      width: double.infinity,
                      margin: EdgeInsets.only(top: 6.0),
                      child: PrimaryButton('Zaloguj się', _submit),
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.transparent),
                          padding: MaterialStateProperty.all(EdgeInsets.zero),
                        ),
                        onPressed: () => Navigator.of(context)
                            .pushNamed(ResetPasswordScreen.routeName),
                        child: GreyTextButton('Nie pamiętasz hasła?', () => Navigator.of(context)
                            .pushNamed(ResetPasswordScreen.routeName)),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
  }
}
