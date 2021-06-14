import 'dart:convert';

import 'package:BSApp/services/api_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:http/http.dart' as http;

class FacebookLoginScreen extends StatefulWidget {

  static const routeName = '/facebook-login';

  @override
  _FacebookLoginScreenState createState() => _FacebookLoginScreenState();
}

class _FacebookLoginScreenState extends State<FacebookLoginScreen> {
  bool _isLoggedIn = false;

  Map _userObj = {};

  @override
  Widget build(BuildContext context) {
    final FacebookLogin fbLogin = FacebookLogin();

    return Scaffold(
      appBar: AppBar(
        title: Text("Codesundar"),
      ),
      body: Container(
        child: _isLoggedIn
            ? Column(
                children: [
                  Image.network(_userObj["picture"]["data"]["url"]),
                  Text(_userObj["name"]),
                  Text(_userObj["email"]),
                  TextButton(
                      onPressed: () {
                        fbLogin.logOut().then((value) {
                          setState(() {
                            _isLoggedIn = false;
                            _userObj = {};
                          });
                        });
                      },
                      child: Text("Logout"))
                ],
              )
            : Center(
                child: ElevatedButton(
                  child: Text("Login with Facebook"),
                  onPressed: () {
                    signInFB(fbLogin);
                  },
                ),
              ),
      ),
    );
  }

  final ApiProvider _apiProvider = ApiProvider();

  Future signInFB(final FacebookLogin fbLogin) async {
    final FacebookLoginResult result = await fbLogin.logIn(["email"]);
    print(result.status);
    print(result.accessToken.userId);
    print(result.accessToken.token);
    final String token = result.accessToken.token;

    final response = await http.get('https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email&access_token=$token');
    final profile = json.decode(response.body);
    print(profile);

    await _apiProvider.post('/auth/login-fb', {'email': profile['email'], 'userId': profile['id'], 'inputToken': token});
    return profile;
  }
}
