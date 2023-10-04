import 'package:amazon_clone/services/auth_service.dart';
import 'package:flutter/material.dart';

import '../common/global_variable.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_textfield.dart';

enum Auth { signIn, signUp }

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  static const String routeName = '/auth-screen';

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final AuthService authService = AuthService();

  // This line makes the Signup Screen to be the default page
  Auth _auth = Auth.signUp;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _signInFormKey = GlobalKey<FormState>();
  final _signUpFormKey = GlobalKey<FormState>();

  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
  }

  void signUpUser() {
    // setState(() {
    //   _isLoading = true;
    // });

    authService.signUpUser(
      context: context,
      email: _emailController.text,
      password: _passwordController.text,
      name: _nameController.text,
    );
  }

  void signInUser() {
    // setState(() {
    //   _isLoading = true;
    // });
    authService.signInUser(
      context: context,
      email: _emailController.text,
      password: _passwordController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalVariables.greyBackgroundCOlor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Welcome',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
              ),
              ListTile(
                tileColor: _auth == Auth.signUp
                    ? GlobalVariables.backgroundColor
                    : GlobalVariables.greyBackgroundCOlor,
                title: const Text(
                  'Create Account',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                leading: Radio(
                  value: Auth.signUp,
                  groupValue: _auth,
                  onChanged: (Auth? val) {
                    setState(() {
                      _auth = val!;
                    });
                  },
                  activeColor: GlobalVariables.secondaryColor,
                ),
              ),
              if (_auth == Auth.signUp)
                Container(
                  padding: const EdgeInsets.all(8),
                  color: GlobalVariables.backgroundColor,
                  child: Form(
                    key: _signUpFormKey,
                    child: Column(
                      children: [
                        CustomsTextfield(
                          controller: _nameController,
                          hintText: 'Name',
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomsTextfield(
                          controller: _emailController,
                          hintText: 'Email',
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomsTextfield(
                          controller: _passwordController,
                          hintText: 'Password',
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomButton(
                            color: GlobalVariables.secondaryColor,
                            text: 'Sign Up',
                            textColor: Colors.white,
                            onTap: () {
                              if (_signUpFormKey.currentState!.validate()) {
                                signUpUser();
                                const CircularProgressIndicator();
                              }
                            })
                      ],
                    ),
                  ),
                ),
              ListTile(
                tileColor: _auth == Auth.signIn
                    ? GlobalVariables.backgroundColor
                    : GlobalVariables.greyBackgroundCOlor,
                title: const Text(
                  'Sign-In.',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                leading: Radio(
                  value: Auth.signIn,
                  groupValue: _auth,
                  onChanged: (Auth? val) {
                    setState(() {
                      _auth = val!;
                    });
                  },
                  activeColor: GlobalVariables.secondaryColor,
                ),
              ),
              if (_auth == Auth.signIn)
                Container(
                  padding: const EdgeInsets.all(8),
                  color: GlobalVariables.backgroundColor,
                  child: Form(
                    key: _signInFormKey,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        CustomsTextfield(
                          controller: _emailController,
                          hintText: 'Email',
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomsTextfield(
                          controller: _passwordController,
                          hintText: 'Password',
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomButton(
                            color: GlobalVariables.secondaryColor,
                            text: 'Sign In',
                            textColor: Colors.white,
                            onTap: () {
                              if (_signInFormKey.currentState!.validate()) {
                                const CircularProgressIndicator();
                                signInUser();
                              }
                            })
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
