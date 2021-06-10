import 'package:BSApp/models/custom_exception.dart';
import 'package:BSApp/providers/auth.dart';
import 'package:BSApp/screens/authentication/reset_password_screen.dart';
import 'package:BSApp/services/custom_info.dart';
import 'package:BSApp/util/my_styling_provider.dart';
import 'package:BSApp/widgets/common/facebook_button.dart';
import 'package:BSApp/widgets/common/google_button.dart';
import 'package:BSApp/widgets/common/grey_text_button.dart';
import 'package:BSApp/widgets/common/loading_indicator.dart';
import 'package:BSApp/widgets/common/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final Map<String, String> _authData = {'email': '', 'password': ''};
  bool _isLoading = false;

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  InputDecoration _getFormFieldDecoration(String hintText) {
    return MyStylingProvider.TEXT_FORM_FIELD_DECORATION
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
    await infoDialog(
      context,
      title: 'Błąd',
      textContent: 'Wystąpił błąd podczas próby logowania.',
    );
  }

  Future<void> _showNotVerifiedDialog() async {
    await infoDialog(
      context,
      title: 'Błąd',
      textContent:
          'Konto nie zostało zweryfikowane. Sprawdź skrzynkę i aktywuj konto!\n\n Jeśli nie otrzymałeś linku aktywacyjnego możemy wysłać go ponownie.',
      additionalAction: () {
        _resendActivationToken(context);
      },
      additionalActionText: 'Wyślij link aktywacyjny',
    );
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const Center(
            child: LoadingIndicator(),
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
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      child: const Text(
                        'Zaloguj się',
                        style: TextStyle(
                            color: Colors.black87,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
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
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
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
                      margin: const EdgeInsets.only(top: 2.0),
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
                        child: GreyTextButton(
                            'Nie pamiętasz hasła?',
                            () => Navigator.of(context)
                                .pushNamed(ResetPasswordScreen.routeName)),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(top: 2.0),
                      child: FacebookButton(),
                    ),
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(top: 0.0),
                      child: GoogleButton(),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
