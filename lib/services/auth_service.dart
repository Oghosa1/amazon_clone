// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:amazon_clone/models/user_model.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import '../common/error_handling.dart';
import '../common/global_variable.dart';
import '../common/utils.dart';
import '../screens/auth_screen.dart';
import '../widgets/bottom_bar.dart';

class AuthService {
  //Sign up user
  void signUpUser({
    required BuildContext context,
    required email,
    required password,
    required name,
  }) async {
    try {
      UserModel userModel = UserModel(
        id: '',
        name: name,
        email: email,
        password: password,
        address: '',
        type: '',
        token: '',
        cart: [],
      );

      http.Response res = await http.post(Uri.parse('$uri/api/signup'),
          body: userModel.toJson(),
          headers: <String, String>{
            'Content-type': 'application/json; charset=UTF-8'
          });

      httpErrorHandling(
          response: res,
          context: context,
          onSuccess: () {
            // showSnackBar(
            //     context, 'Account created, login with the same crendential');

            showToast('Account created, login with the same crendential',
                context, Colors.green);
          });
    } catch (e) {
      // showSnackBar(context, e.toString());
      // showToast(e.toString(), context, Colors.red.shade300);
    }
  }

  //SignIn
  void signInUser({
    required BuildContext context,
    required email,
    required password,
  }) async {
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/api/signin'),
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
        headers: <String, String>{
          'Content-type': 'application/json; charset=UTF-8'
        },
      );

      httpErrorHandling(
          response: res,
          context: context,
          onSuccess: () async {
            SharedPreferences preferences =
                await SharedPreferences.getInstance();

            Provider.of<UserProvider>(context, listen: false).setUser(res.body);

            await preferences.setString(
                'x-auth-token', jsonDecode(res.body)['token']);

            // await preferences.setString(
            //     'user', jsonDecode(res.body)['address']);

            // showSnackBar(context, 'Login successful!');
            showToast('Login successful', context, Colors.green);

            Navigator.pushNamedAndRemoveUntil(
                context, BottomBar.routeName, (route) => false);
          });
    } catch (e) {
      // showSnackBar(context, e.toString());
      // showToast(e.toString(), context, Colors.red.shade400);
    }
  }

  //Get user data
  Future<void> getUserData(
    BuildContext context,
  ) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');

      if (token == null) {
        prefs.setString('x-auth-token', '');
      }

      var tokenRes = await http.post(
        Uri.parse('$uri/tokenIsValid'),
        headers: <String, String>{
          'Content-type': 'application/json; charset=UTF-8',
          'x-auth-token': token!
        },
      );

      var response = jsonDecode(tokenRes.body);

      if (response == true) {
        //Get the user data
        http.Response userRes = await http.get(
          Uri.parse('$uri/'),
          headers: <String, String>{
            'Content-type': 'application/json; charset=UTF-8',
            'x-auth-token': token
          },
        );

        // showToast(userRes.body, context, Colors.blue);

        // var userProvider =
        Provider.of<UserProvider>(context, listen: false).setUser(userRes.body);
        // userProvider.setUser(userRes.body);
      } else {
        showToast('Token has expired, please re-login', context, Colors.red);

        /// Navigating to a Auth screen
        // Navigator.push(
        //     context, MaterialPageRoute(builder: (context) => AuthScreen()));
      }
    } catch (e) {
      // showSnackBar(context, e.toString());
      // showSnackBar(context, 'Error here');
      // showToast(e.toString(), context, Colors.red.shade500);
    }
  }

  // Method to check if the token is still valid
  // Future<void> checkTokenValidity({required BuildContext context}) async {
  //   try {
  //     SharedPreferences prefs = await SharedPreferences.getInstance();
  //     String? token = prefs.getString('x-auth-token');

  //     if (token == null) {
  //       prefs.setString('x-auth-token', '');
  //       // showToast('Token is empty', context, Colors.green);
  //       return;
  //     }

  //     var tokenRes = await http.post(
  //       Uri.parse('$uri/tokenIsValid'),
  //       headers: <String, String>{
  //         'Content-type': 'application/json; charset=UTF-8',
  //         'x-auth-token': token
  //       },
  //     );

  //     var response = jsonDecode(tokenRes.body);

  //     if (response != true) {
  //       // Token is not valid, you can handle this case here
  //       // For example, you can log the user out or take appropriate action
  //       // based on your application's logic.

  //       prefs.setString('x-auth-token', '');
  //       Navigator.pushNamedAndRemoveUntil(
  //            context, AuthScreen.routeName, (route) => false);
  //       showToast('Token is not valid', context, Colors.green);
  //     } else {
  //       showToast('Token is valid', context, Colors.green);
  //     }
  //   } catch (e) {
  //     // Handle any errors here
  //     print('Error checking token validity: $e');
  //   }
  // }

  // Method to periodically check token validity every 30 minutes
  void startTokenValidityChecker(BuildContext context) {
    const Duration checkInterval = Duration(seconds: 30);

    Timer.periodic(checkInterval, (timer) {
      getUserData(context);
    });
  }
}
